local function current_buffer_number()
  return "﬘ " .. vim.api.nvim_get_current_buf()
end

local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed,
    }
  end
end

local function current_date()
  return os.date "%x"
end

local function current_working_dir()
  local cwd = string.sub(vim.fn.getcwd(), 12)
  return "~" .. cwd
end
-- @TODOUA: keep tinkering with theme and section layouts!
-- @TODOUA: roll my own status bar or try expressline
-- https://github.com/nvim-lualine/lualine.nvim
local custom_auto = require "lualine.themes.auto"
custom_auto.terminal.a.bg = "#1e90ff"
custom_auto.normal.a.bg = "#A9A9A9"
custom_auto.normal.c.fg = "#D7DFC5"
custom_auto.insert.c.fg = "#99D57E"
custom_auto.command.a.bg = "#1e90ff"
custom_auto.command.b.fg = "#1e90ff"
custom_auto.replace.a.bg = "#C83434"
custom_auto.visual.a.bg = "#725191"
custom_auto.visual.b.fg = "#1e90ff"

require("lualine").setup {
  options = {
    icons_enabled = true,
    theme = custom_auto,
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = {},
    always_divide_middle = true,
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = {
      { "b:gitsigns_head", icon = "" },
      { "diff", source = diff_source },
      { "diagnostics", sources = { "nvim_lsp" } },
    },
    lualine_c = { { "filename", path = 1 } },
    lualine_x = { "filetype" },
    lualine_y = { { current_buffer_number }, { current_working_dir }, { current_date } },
    lualine_z = { "location" },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = { { current_buffer_number } },
    lualine_z = {},
  },
  tabline = {},
  extensions = {},
}
