set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/.vimrc
set guicursor=
set noshowcmd
call plug#begin('~/.vim/plugged')
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
Plug 'jparise/vim-graphql'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-eunuch'
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
set t_Co=256
set bg=light
" papercolor config
let g:PaperColor_Theme_Options = {
  \   'theme': {
  \     'default.light': { 
  \       'override' : {
  \         'color10' : ['#005f00', '22'],
  \         'color11' : ['#lclclc', '234'],
  \         'spellbad' : ['#ffaf87', '216']
  \       }
  \     }
  \   }
  \ }
colorscheme PaperColor
" Delete to Esc from (almost) all the things
nnoremap <Del> <Esc>
vnoremap <Del> <Esc>gV
onoremap <Del> <Esc>
cnoremap <Del> <C-C><Esc>
inoremap <Del> <Esc>`^
" fzf configure
nnoremap <C-p> :GFiles<CR>
nnoremap <leader>p :Files<CR>
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.5 } }
let g:fzf_preview_window = 'right:55%'
let $FZF_DEFAULT_OPTS='--reverse'
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)
