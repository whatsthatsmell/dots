set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/.vimrc
set guicursor=
set noshowcmd
call plug#begin('~/.vim/plugged')
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
Plug 'jparise/vim-graphql'
Plug 'tpope/vim-eunuch'
Plug 'morhetz/gruvbox'
call plug#end()
let g:firenvim_config = { 
    \ 'globalSettings': {
        \ 'alt': 'all',
    \  },
    \ 'localSettings': {
        \ '.*': {
            \ 'cmdline': 'neovim',
            \ 'priority': 0,
            \ 'selector': 'textarea, div[role="textbox"]',
            \ 'takeover': 'never',
        \ },
    \ }
\ }
set bg=light
let g:gruvbox_italic=1
let g:gruvbox_contrast_light = 'soft'
set termguicolors
colorscheme gruvbox
nnoremap <Del> <Esc>
vnoremap <Del> <Esc>gV
onoremap <Del> <Esc>
cnoremap <Del> <C-C><Esc>
inoremap <Del> <Esc>`^
