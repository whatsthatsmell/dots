-- @TODOUA: probably gut this or even rm it. May move some to utils
-- Based on johann2357/nvim-smartbufs: https://git.io/J6dTY - Updated using current 20-Oct-2021 Lua API
local M = {}

--- Checks whether the buffer is valid.
-- Checks if buffer is valid and listed.
-- @param buf_id buffer id to be checked.
-- @treturn bool
local function is_valid_buffer(buf_id)
  return vim.api.nvim_buf_is_valid(buf_id) and vim.fn.getbufvar(buf_id, "&buflisted") == 1
end

--- Checks whether the buffer is a regular file buffer.
-- It also checks if buffer is valid and listed.
-- @param buf_id buffer id to be checked.
-- @treturn bool
local function is_file_buffer(buf_id)
  return is_valid_buffer(buf_id) and vim.fn.getbufvar(buf_id, "&buftype") ~= "terminal"
end

-- Checks whether the buffer is regular file buffer.
--- It also checks if buffer is valid and listed.
local function get_active_buffers()
  local bufs = vim.api.nvim_list_bufs()
  local active_buffers = {}
  local count = 0
  for idx, buf_id in pairs(bufs) do
    if is_file_buffer(buf_id) then
      count = count + 1
      active_buffers[count] = buf_id
    end
  end
  return active_buffers
end

--- Opens the given buffer id.
-- It uses the current window.
-- @param buf_id buffer id to be opened.
-- @treturn nil
local function open_buf_id(buf_id)
  -- TODO: find a better way to do this
  -- vim.api.nvim_command(string.format("buffer %d", buf_id))
  vim.api.nvim_win_set_buf(0, buf_id)
end

--- Find buffer in buffer table.
-- Finds a given buffer in the active buffers table (no terminal buffers included).
-- @param buf_id buffer id to be found.
-- @param buffer_table table with buffer ids.
-- @return buf_id index found or nil if not found.
local function find_buffer(buf_id, buffer_table)
  for idx, table_buf_id in ipairs(buffer_table) do
    if buf_id == table_buf_id then
      return idx
    end
  end
end

--- Opens the given buffer index in buffers table.
-- It uses the current window.
-- @param buf_idx buffer index to be opened.
-- @treturn nil
M.goto_buffer = function(buf_idx)
  local active_bufs = get_active_buffers()
  local selected_buf = active_bufs[buf_idx]
  if selected_buf then
    open_buf_id(selected_buf)
  end
end

-- @TODOUA: `get_active_buffers` filters out terminals.
--- Make it possible to go through prev and next terminal buffers
--- ... when starting from a terminal buffer
-- Opens the next buffer in relation to the current one.
--- It only considers normal file buffers. Similar to :bnext
--- ^^ This applies when triggered from terminal buffers as well!
M.goto_next_buffer = function()
  local active_bufs = get_active_buffers()
  local current_buf_id = vim.api.nvim_get_current_buf()
  local total_bufs = table.maxn(active_bufs)
  local buf_idx = find_buffer(current_buf_id, active_bufs)
  if buf_idx == nil then
    -- TODO: keep track of last used buffer
    buf_idx = 0
  end
  local next_buf_idx = (buf_idx + 1) % (total_bufs + 1)
  if next_buf_idx == 0 then
    next_buf_idx = 1
  end
  M.goto_buffer(next_buf_idx)
end

--- Opens the previous buffer in relation to the current one.
-- It only considers normal file buffers. Similar to :bprev
-- ^^ Applies to Terminal buffers as well!
-- see comments in `goto_next_buffer` for more context
M.goto_prev_buffer = function()
  local active_bufs = get_active_buffers()
  local current_buf_id = vim.api.nvim_get_current_buf()
  local total_bufs = table.maxn(active_bufs)
  local buf_idx = find_buffer(current_buf_id, active_bufs)
  if buf_idx == nil then
    -- TODO: keep track of last used buffer
    buf_idx = 0
  end
  local prev_buf_idx = (buf_idx - 1) % (total_bufs + 1)
  if prev_buf_idx == 0 then
    prev_buf_idx = total_bufs
  end
  M.goto_buffer(prev_buf_idx)
end

-- Closes current active buffer.
--- Also calls goto_prev_buffer so it doesn't close the current window.
--- Will error if no write since last change
M.close_current_buffer = function()
  local buf_id = vim.api.nvim_get_current_buf()
  M.goto_prev_buffer()
  vim.api.nvim_buf_delete(buf_id, {})
end

-- Unloads current active buffer! (best for terminal buffers)
--- Closes the current window
--- Will not error if no write since last change - changes will be lost
--- This is primarily for "deleting" terminal buffers
M.unload_current_buffer = function()
  vim.api.nvim_buf_delete(0, { force = true, unload = true })
end

--- Closes the given buffer index in buffers table.
-- If buf_idx is the current buffer it will call close_current_buffer.
-- @param buf_idx buffer index to be opened.
-- @treturn nil
-- M.close_buffer = function(buf_idx)
--   local active_bufs = get_active_buffers()
--   local selected_buf = active_bufs[buf_idx]
--   if selected_buf == nil then
--     return
--   end
--
--   local current_buf_id = vim.api.nvim_get_current_buf()
--   if selected_buf == current_buf_id then
--     M.close_current_buffer()
--   else
--     vim.api.nvim_command(string.format("bdelete %d", selected_buf))
--   end
-- end

return M
