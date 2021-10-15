vim.api.nvim_buf_set_keymap(0, "n", "<localleader>f", ":%!jq .<CR>", { noremap = false, silent = false })
-- @TODOUA: yml - Remember that prettier is around for yaml files. Just call it manually when needed
