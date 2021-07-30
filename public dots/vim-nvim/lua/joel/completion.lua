-- this really is compe.lua
-- setup compe, tab completion, and snippet support
local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
  local col = vim.fn.col "." - 1
  if col == 0 or vim.fn.getline("."):sub(col, col):match "%s" then
    return true
  else
    return false
  end
end

_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif vim.fn.call("vsnip#available", { 1 }) == 1 then
    return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn["compe#complete"]()
  end
end

_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif vim.fn.call("vsnip#jumpable", { -1 }) == 1 then
    return t "<Plug>(vsnip-jump-prev)"
  else
    return t "<S-Tab>"
  end
end

-- @TODOUA: maps in dedicated plugin modules? Together with mappings module?
-- compe tab maps
vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", { expr = true })
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", { expr = true })
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", { expr = true })
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", { expr = true })
-- other compe maps
vim.api.nvim_set_keymap("i", "<C-Space>", "compe#complete()", { expr = true, noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<CR>", "compe#confirm('<CR>')", { expr = true, noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-e>", "compe#close('<C-e>')", { expr = true, noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-f>", "compe#scroll({ 'delta': +4 })", { expr = true, noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-d>", "compe#scroll({ 'delta': -4 })", { expr = true, noremap = true, silent = true })
