-- Lua tables are the only data structures in Lua. They're used as dictionaries, lists, graphs, trees, etc.
-- Tables, Tables, Tables
-- Tables are created via expression: similar to an object literal in JavaScript
-- Tables only exist as long as there is a reference - it is gc'd
-- Lua table indexes are 1 based!!
-- Note that Neovim uses Lua 5.1

-- DN(vim.api.nvim_get_mode())
-- DN(vim.api.nvim_list_bufs())

local keymaps_table = {}
local modes = { "v", "n", "i", "c" }

for _, mode in pairs(modes) do
  local global = vim.api.nvim_get_keymap(mode)
  for _, keymap in pairs(global) do
    print(keymap.rhs)
    table.insert(keymaps_table, keymap)
  end
  local buf_local = vim.api.nvim_buf_get_keymap(0, mode)
  for _, keymap in pairs(buf_local) do
    table.insert(keymaps_table, keymap)
  end
end

local telescope_keymaps = {}
local i = 0
for _, keymap in pairs(keymaps_table) do
  local found = false
  if keymap.rhs:find("telescope", 1, true) then
    found = true
    if found then
      i = i + 1
      -- print(i, keymap.mode, keymap.rhs)
      table.insert(telescope_keymaps, keymap)
    end
  end
end

-- DN(telescope_keymaps, "telescope maps")
-- DN(telescope_keymaps)
