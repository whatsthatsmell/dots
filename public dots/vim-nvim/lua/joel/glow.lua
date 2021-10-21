-- Credit https://github.com/ellisonleao/glow.nvim
-- Needed this to work with .MD ft extensions
-- The commit here explicitly disallows capitalized MD extension: https://git.io/JiTji
-- I may put in a PR but I also don't need the install stuff etc.
-- It should just work with filtype being markdown
-- Glow's preview falls somewhere between Neovim's own rendering & the `MarkdownPreview` plugin...
-- ...that outs to the browser. May be a value add.
-- Trying because anytime I don't need to switch to a browser, I win!
-- I also integrated `nvim-notify`
-- No keymaps added by me: just type :Glow
local api = vim.api
local win, buf
local bin_path = vim.g.glow_binary_path
if bin_path == nil then
  bin_path = vim.env.HOME .. "/.local/bin"
end
local M = {}

local function has_value(tab, val)
  for _, value in ipairs(tab) do
    if value == val then
      return true
    end
  end
  return false
end

local function validate(path)
  if vim.fn.executable(bin_path .. "/glow") == 0 then
    require "notify"
  end

  -- trim and get the full path
  path = string.gsub(path, "%s+", "")
  path = string.gsub(path, '"', "")
  path = path == "" and "%" or path
  path = vim.fn.expand(path)
  path = vim.fn.fnamemodify(path, ":p")
  local file_exists = vim.fn.filereadable(path) == 1

  -- check if file exists
  if not file_exists then
    api.nvim_err_writeln "file does not exist"
    return
  end

  local ext = vim.fn.fnamemodify(path, ":e")
  if not has_value({ "md", "markdown", "MD" }, ext) then
    require "notify"("Only markdown files are supported", "warn", { title = "Glow" })
    return
  end

  return path
end

function M.close_window()
  api.nvim_win_close(win, true)
end

-- open_window draws a custom window with the markdown contents
local function open_window(path)
  -- window size
  local width = api.nvim_get_option "columns"
  local height = api.nvim_get_option "lines"
  local win_height = math.ceil(height * 0.8 - 4)
  local win_width = math.ceil(width * 0.8)
  local row = math.ceil((height - win_height) / 2 - 1)
  local col = math.ceil((width - win_width) / 2)

  local opts = {
    style = "minimal",
    relative = "editor",
    width = win_width,
    height = win_height,
    row = row,
    col = col,
    border = "shadow",
  }

  -- create preview buffer and set local options
  buf = api.nvim_create_buf(false, true)
  win = api.nvim_open_win(buf, true, opts)
  api.nvim_buf_set_option(buf, "bufhidden", "wipe")
  api.nvim_win_set_option(win, "winblend", 0)
  api.nvim_buf_set_keymap(
    buf,
    "n",
    "q",
    ":lua require('joel.glow').close_window()<CR>",
    { noremap = true, silent = true }
  )
  api.nvim_buf_set_keymap(
    buf,
    "n",
    "<Esc>",
    ":lua require('joel.glow').close_window()<CR>",
    { noremap = true, silent = true }
  )

  vim.fn.termopen(string.format("glow %s", vim.fn.shellescape(path)))
end

function M.glow(file)
  local current_win = vim.fn.win_getid()
  if current_win == win then
    M.close_window()
  else
    local path = validate(file)
    if path == nil then
      return
    end
    open_window(path)
  end
end

return M
