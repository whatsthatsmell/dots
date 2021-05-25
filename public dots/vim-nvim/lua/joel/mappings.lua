-- Mappings galore & commands
  -- toggle search highlights with cursorline & cursorcolumn
	-- See augroup nvim-incsearch-cursorline for symmetry
vim.api.nvim_set_keymap('n', '<Leader>\\', ':set hlsearch! cursorline! cursorcolumn!<CR>', { noremap = true, silent = true })
	-- write only if changed
vim.api.nvim_set_keymap('n', '<Leader>w', ':up<CR>', { noremap = true })
	-- quit (or close window)
vim.api.nvim_set_keymap('n', '<Leader>q', ':q<CR>', {  noremap = true, silent = true })
-- toggle hunk highlight
vim.api.nvim_set_keymap('n', '<Leader>hh',  [[<Cmd>lua require"gitsigns".toggle_linehl()<CR>]], { noremap = true, silent = true })
-- use ZQ for :q! (quit & discard changes)
-- Discard all changed buffers & quit
vim.api.nvim_set_keymap('n', '<Leader>Q', ':qall!<CR>', {  noremap = true, silent = true })
-- write all and quit
vim.api.nvim_set_keymap('n', '<Leader>W', ':wqall<CR>', {  noremap = true, silent = true })
-- Buffer stuff - <C-6> is toggle current and alt(last viewed)
-- go to next buffer
vim.api.nvim_set_keymap('n', '<Leader><right>', ':bn<CR>', {  noremap = true, silent = true })
-- go to prev buffer
vim.api.nvim_set_keymap('n', '<Leader><left>', ':bp<CR>', {  noremap = true, silent = true })
-- delete current buffer - don't close split
vim.api.nvim_set_keymap('n', ',d', ':b#<bar>bd#<CR>', { noremap = false, silent = true })
-- delete current buffer - will close split - :q to close split
vim.api.nvim_set_keymap('n', '<Leader>x', ':bd<CR>', {  noremap = true, silent = true })
-- open available commands & run it
vim.api.nvim_set_keymap('n', ',c',  [[<Cmd>lua require"telescope.builtin".commands()<CR>]], { noremap = true, silent = true })

-- commands - Lua API in the works: https://github.com/neovim/neovim/pull/12378
vim.cmd([[
au TextYankPost * lua vim.highlight.on_yank {on_visual = false}

" header files should treated like .c files
autocmd BufRead,BufNewFile *.h set filetype=c
]])


