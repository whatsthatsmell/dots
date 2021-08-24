-- Credit: https://github.com/David-Kunz/treesitter-unit
-- @TODOUA: Possibly switch to the plugin (locally) once kinks worked out
local ts_utils = require "nvim-treesitter.ts_utils"

local M = {}

local get_text = function(bufnr, line)
  return vim.api.nvim_buf_get_lines(bufnr, line - 1, line, false)[1]
end

local get_node_for_cursor = function(cursor)
  if cursor == nil then
    cursor = vim.api.nvim_win_get_cursor(0)
  end
  local root = ts_utils.get_root_for_position(unpack { cursor[1] - 1, cursor[2] })
  if not root then
    return
  end
  return root:named_descendant_for_range(cursor[1] - 1, cursor[2], cursor[1] - 1, cursor[2])
end

local get_main_node = function(cursor)
  local node = get_node_for_cursor(cursor)
  if node == nil then
    return node
  end
  local parent = node:parent()
  local root = ts_utils.get_root_for_node(node)
  local start_row = node:start()
  while parent ~= nil and parent ~= root and parent:start() == start_row do
    node = parent
    parent = node:parent()
  end
  return node
end

local move_row_while_empty = function(bufnr, curr_line, delta)
  local line = curr_line
  if get_text(bufnr, line) == "" then
    local parent = line + delta
    local line_parent = get_text(bufnr, parent)
    while parent >= 0 and line_parent == "" do
      line = parent
      parent = line + delta
      line_parent = get_text(bufnr, parent)
    end
  end
  return line
end

local move_col_while_empty = function(bufnr, curr_line)
  local line = curr_line
  local text = get_text(bufnr, line)
  local found = string.find(text, "[^%s]")
  return found and found - 1 or 0
end

local select_range = function(bufnr, start_row, start_col, end_row, end_col, mode)
  start_row = start_row + 1
  start_col = start_col + 1
  end_row = end_row + 1
  end_col = end_col + 1
  mode = mode or "v"
  vim.fn.setpos(".", { bufnr, start_row, start_col, 0 })
  vim.cmd("normal! " .. mode, true, true, true)
  vim.fn.setpos(".", { bufnr, end_row, end_col - 1, 0 })
end

local function get_selection_range(outer)
  local bufnr = vim.api.nvim_get_current_buf()
  local cursor = vim.api.nvim_win_get_cursor(0)

  local sel_row = cursor[1]
  local sel_col = cursor[2]
  if outer and get_text(bufnr, sel_row) == "" then
    sel_row = move_row_while_empty(bufnr, sel_row, 1) + 1
    sel_col = 0
  end
  if outer then
    sel_col = move_col_while_empty(bufnr, sel_row)
  end

  local node = get_main_node { sel_row, sel_col }
  if node == nil then
    return
  end
  local start_row, start_col, end_row, end_col = node:range()

  local mode = "v"
  if outer then
    if cursor[1] < sel_row then
      start_row = move_row_while_empty(bufnr, start_row, -1) - 1
    else
      local text = get_text(bufnr, end_row + 2)
      if text == "" then
        end_row = move_row_while_empty(bufnr, end_row + 2, 1) - 1
        start_col = 0
        mode = "V"
      end
    end
  end
  return start_row, start_col, end_row, end_col, mode
end

M.select = function(outer)
  local bufnr = vim.api.nvim_get_current_buf()
  local start_row, start_col, end_row, end_col, mode = get_selection_range(outer)
  if start_row == nil then
    return
  end
  select_range(bufnr, start_row, start_col, end_row, end_col, mode)
end

local highlight_ns = vim.api.nvim_create_namespace "treesitter-unit-ns"
local last_start
local last_end

M.highlight_unit = function(higroup)
  local bufnr = vim.api.nvim_get_current_buf()
  if last_start then
    vim.api.nvim_buf_clear_namespace(bufnr, highlight_ns, 0, -1)
  end
  local start_row, start_col, end_row, end_col = get_selection_range()
  if start_row == nil then
    return
  end
  last_start = { start_row, start_col }
  last_end = { end_row, end_col }
  vim.highlight.range(bufnr, highlight_ns, higroup, last_start, last_end)
end

M.enable_highlighting = function(higroup)
  local used_higroup = higroup or "CursorLine"
  vim.cmd "augroup treesitter-unit-highlight"
  vim.cmd "autocmd!"
  vim.cmd('autocmd CursorMoved * lua require"joel.treesitter".highlight_unit("' .. used_higroup .. '")')
  vim.cmd "augroup END"
end

M.disable_highlighting = function()
  vim.cmd "augroup treesitter-unit-highlight"
  vim.cmd "autocmd!"
  vim.cmd "augroup END"
end

M.delete = function(for_change)
  local bufnr = vim.api.nvim_get_current_buf()
  local node = get_main_node()
  local start_row, start_col, end_row, end_col = node:range()
  local replaced = for_change and " " or ""
  vim.api.nvim_buf_set_text(bufnr, start_row, start_col, end_row, end_col, { replaced })
end

M.change = function()
  M.delete(true)
  vim.cmd "startinsert"
end

return M
