-- @TODOUA: yml - Remember that prettier is around for yaml files. Just call it manually when needed
-- global for jsonpath plugin: https://github.com/mogelbrod/vim-jsonpath
vim.g.jsonpath_register = "*"
-- json mappings
vim.api.nvim_buf_set_keymap(0, "n", "<localleader>f", ":%!jq .<CR>", { noremap = false, silent = false })
-- jsonpath mappings
vim.api.nvim_buf_set_keymap(0, "n", "<localleader>jp", ":JsonPath<CR>", { noremap = true, silent = false })
vim.api.nvim_buf_set_keymap(0, "n", "<localleader>jg", ":call jsonpath#goto()<CR>", { noremap = true, silent = true })

--- https://github.com/lewis6991/dotfiles/blob/de2f982b4d6fa03cf01d115a2df7dffa6fcf6398/config/nvim/after/ftplugin/json.lua --
function JsonFolds()
  local line = vim.fn.getline(vim.v.lnum)
  -- let l:lline = split(l:line, '\zs')
  local inc = vim.fn.count(line, "{")
  local dec = vim.fn.count(line, "}")
  local level = inc - dec
  if level == 0 then
    return "="
  elseif level > 0 then
    return "a" .. level
  elseif level < 0 then
    return "s" .. -level
  end
end

vim.opt_local.conceallevel = 0
vim.opt_local.foldnestmax = 5
vim.opt_local.foldmethod = "marker"
vim.opt_local.foldmarker = "{,}"

vim.opt_local.foldmethod = "expr"
vim.opt_local.foldexpr = "v:lua.JsonFolds()"
vim.opt_local.foldenable = false
----
