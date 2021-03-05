set nocompatible              " be iMproved, required
filetype off                  " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
set nu
set rnu
set hidden
set completeopt=menu,menuone,preview,noselect,noinsert
set omnifunc=ale#completion#OmniFunc
set dictionary+=/usr/share/dict/words
set wildignore+=*/node_modules/*,*/coverage/*
set incsearch
set ignorecase
set smartcase
set ts=2
set sw=2
set splitbelow

highlight clear ALEErrorSign
highlight clear ALEWarningSign
let g:ale_sign_error = "❗️"
let g:ale_sign_warning = "⚠︎"

syntax enable
" rando
noremap <silent><Leader>\ :noh<cr>
" write only if something is changed
noremap <Leader>w :up<cr>
noremap <silent> <Leader>q :q<cr>
noremap <silent> <Leader>Q :q!<cr>
inoremap <C-a> <esc>:call AutoPairsToggle()<cr>a
" expands to dir of current file in cmd mode
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
" go to next buffer
nnoremap <silent> <leader><right> :bn<CR>
" go to prev buffer
nnoremap <silent> <leader><left> :bp<CR>
" delete current buffer - will close split
nnoremap <silent> <leader>x :bd<CR>
" Experimental *** delete current buffer - don't close split*
nmap ,d :b#<bar>bd#<CR>
" 'grep' word under cursor
nnoremap <silent> <leader>g :Rg <C-R>=expand("<cword>")<CR><CR>
" 'grep' -- ripgrep!
nnoremap <silent> <leader>rg :Rg <CR>

" ALE keys
nmap <silent> <leader>h :ALEHover<cr>
nmap <leader>f <Plug>(ale_fix)
nmap <silent> <leader>d <Plug>(ale_go_to_definition)
nnoremap <silent> <leader>r :ALEFindReferences -relative<Return>
nnoremap <silent> <leader>rn :ALERename<Return>

" Startify: make/save a (new) session
nmap <leader>ss :SSave<cr>
" open file in directory of current file
nmap <leader>e :e %:h/
nmap <leader>v :vs %:h/
let g:ale_completion_enabled = 1
let g:ale_completion_autoimport = 1

call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'dense-analysis/ale'
Plugin 'pangloss/vim-javascript'
Plugin 'jiangmiao/auto-pairs'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-commentary'
Plugin 'airblade/vim-gitgutter'
call vundle#end()

"let g:lightline = { 'colorscheme': 'PaperColor' }
filetype plugin indent on    " required
" auto exit insert mode
au CursorHoldI * stopinsert
au FileType text set colorcolumn=100 autoindent linebreak
au BufNewFile,BufRead *.markdown,*.mdown,*.mkd,*.mkdn,*.mdwn,*.md,*.MD  set ft=markdown
