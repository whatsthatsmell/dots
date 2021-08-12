vim.cmd [[
au TextYankPost * lua vim.highlight.on_yank {on_visual = false}

" header files should treated like .c files
autocmd BufRead,BufNewFile *.h set filetype=c

" turn on cursorline, cursorcolumn when searching, sync with hlsearch
augroup nvim-incsearch-cursorline
	autocmd!
	autocmd CmdlineEnter /,\? :set cursorline cursorcolumn hlsearch
augroup END

" Options in VimL form
set termguicolors
" syntax highlight only to 1K instead of default 3K
set synmaxcol=1000

let &packpath=&runtimepath
set completeopt=menu,menuone,preview,noselect,noinsert
set dictionary+=/usr/share/dict/words
set wildignore+=*/node_modules/*,*/coverage/*
set guicursor=
set clipboard=unnamedplus
set updatetime=2000
set undodir=~/.config/nvim/undodir
set undofile
set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
set grepformat=%f:%l:%c:%m,%f:%l:%m

" global vars in Vim form **
" netrw settings
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_winsize = 27
let g:netrw_list_hide= netrw_gitignore#Hide()

]]

-- Trial DAP maps
-- vim.cmd [[nnoremap <silent> <leader>dr :lua require'dap'.continue()<CR>]]
-- vim.cmd [[nnoremap <leader>ds :lua require'dap'.stop()<CR>]]
-- vim.cmd [[nnoremap <leader>da :lua require'joel.debugHelper'.attach()<CR>]]
-- vim.cmd [[nnoremap <leader>dg :lua require'joel.debugHelper'.debugGql()<CR>]]
-- vim.cmd [[nnoremap <silent> <leader>db :lua require'dap'.toggle_breakpoint()<CR>]]
-- vim.cmd [[nnoremap <silent> <space>dh :lua require('dap.ui.variables').hover()<CR>]]

-- THEME stuff
vim.cmd "set fillchars+=vert:│"
vim.cmd "colorscheme codesmell_dark"

vim.cmd "set spellfile=~/.config/nvim/spell/en.utf-8.add"
vim.cmd "filetype plugin indent on"

-- Options/Settings **
-- Window scope
vim.wo.number = true
vim.wo.relativenumber = true

-- Global scope
vim.o.inccommand = "split"
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.scrolloff = 1
vim.o.hidden = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.showcmd = false

-- Buffer scope
vim.bo.tabstop = 2
vim.bo.shiftwidth = 2

-- Global Vim vars that are on a solo mission **
-- vim.g.fzf_gh_website = 1
vim.g.matchup_matchparen_deferred = 1
