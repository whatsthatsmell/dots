-- @TODOUA: yml - Remember that prettier is around for yaml files. Just call it manually when needed
-- global for jsonpath plugin: https://github.com/mogelbrod/vim-jsonpath
vim.g.jsonpath_register = "*"
-- json mappings
vim.api.nvim_buf_set_keymap(0, "n", "<localleader>f", ":%!jq .<CR>", { noremap = false, silent = false })
-- jsonpath mappings
vim.api.nvim_buf_set_keymap(0, "n", "<localleader>jp", ":JsonPath<CR>", { noremap = true, silent = false })
vim.api.nvim_buf_set_keymap(0, "n", "<localleader>jg", ":call jsonpath#goto()<CR>", { noremap = true, silent = true })
