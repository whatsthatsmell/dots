-- ** Mappings galore & commands & options FOR NOW **
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
-- show LSP diagnostics for all open buffers
vim.api.nvim_set_keymap('n', '<space>d',  [[<Cmd>lua require"telescope.builtin".lsp_workspace_diagnostics()<CR>]], { noremap = true, silent = true })
-- commands - Lua API in the works: https://github.com/neovim/neovim/pull/12378
-- git_branches
vim.api.nvim_set_keymap('n', '<leader>gc', [[<Cmd>lua require"telescope.builtin".git_branches()<CR>]], { noremap = true, silent = true })
vim.cmd([[
au TextYankPost * lua vim.highlight.on_yank {on_visual = false}

" header files should treated like .c files
autocmd BufRead,BufNewFile *.h set filetype=c

" turn on cursorline, cursorcolumn when searching, sync with hlsearch
augroup nvim-incsearch-cursorline
	autocmd!
	autocmd CmdlineEnter /,\? :set cursorline cursorcolumn hlsearch
augroup END

" Options in VimL form
set t_Co=256
set termguicolors
set bg=dark
" syntax highlight only to 1K instead of default 3K
set synmaxcol=1000
" THEME stuff
" better vertsplit char- part of ci_dark theme
set fillchars+=vert:│
let g:ci_dark_enable_bold = 1
" let g:rainbow_active = 1
colorscheme ci_dark

set runtimepath^=~/.vim
let &packpath=&runtimepath
set hidden
set completeopt=menu,menuone,preview,noselect,noinsert
set dictionary+=/usr/share/dict/words
set wildignore+=*/node_modules/*,*/coverage/*
set guicursor=
set clipboard=unnamedplus
set noshowcmd
set splitbelow
set splitright
set updatetime=2500
" @TODUA: move under ~/.config/neovim/"
set undodir=~/.vim/undodir
set undofile
set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
set grepformat=%f:%l:%c:%m,%f:%l:%m

" global vars in Vim form **
" netrw settings
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_winsize = 27
let g:netrw_list_hide= netrw_gitignore#Hide()

]])

-- @TODUA: Try TJ's opt update
-- Options **
-- window scope
vim.wo.number = true
vim.wo.relativenumber = true
-- global scope
vim.o.inccommand = 'split'
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.scrolloff = 1
-- buffer scope
vim.bo.tabstop = 2
vim.bo.shiftwidth = 2

-- Global Vim vars **
vim.g.fzf_gh_website = 1
-- vim.g.matchup_surround_enabled = 1
vim.g.matchup_matchparen_deferred = 1
