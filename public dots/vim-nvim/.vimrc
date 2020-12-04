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
" set thesaurus+=~/.vim/thesaurus/mthesaur.txt
set wildignore+=*/node_modules/*,*/coverage/*
" set colorcolumn=120 " ******- handled by matchadd below
set incsearch
set ignorecase
set smartcase
set ts=2
set sw=2
set splitbelow
" highlight ColorColumn ctermbg=darkgrey - handled by theme/color.vim
call matchadd('ColorColumn', '\%81v', 100)
highlight clear ALEErrorSign
highlight clear ALEWarningSign
let g:ale_sign_error = "❗️"
let g:ale_sign_warning = "⚠︎"
syntax enable
" copy selection to sys clipboard
noremap <Leader>y "+y
" copy word undor cursor to sys clipboard
noremap <Leader>yw "+yiw
" rando
noremap <silent><Leader>\ :noh<cr>
" write only if something is changed
noremap <Leader>w :up<cr>
noremap <silent> <Leader>q :q<cr>
nnoremap <silent> <leader>s :setlocal spell!<cr>
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
" go to next buffer
nnoremap <silent> <leader><right> :bn<CR>
" go to prev buffer
nnoremap <silent> <leader><left> :bp<CR>
" delete current buffer
nnoremap <silent> <leader>x :bd<CR>
" delete terminial buffer
nnoremap <silent> <leader>tx :bd!<CR>
" fuzzy buff!
nnoremap <silent> <leader>b :Buffers<CR>
" 'grep' word under cursor
nnoremap <silent> <leader>g :Rg <C-R>=expand("<cword>")<CR><CR>
" 'grep' -- ripgrep!
nnoremap <silent> <leader>rg :Rg <CR>

" ALE keys
nmap <silent> <leader>h :ALEHover<cr>
nmap <silent> <leader>f <Plug>(ale_fix)
nmap <silent> <leader>d <Plug>(ale_go_to_definition)
nnoremap <silent> <leader>r :ALEFindReferences -relative<Return>
nnoremap <silent> <leader>rn :ALERename<Return>

" Startify: make/save a (new) session
nmap <leader>ss :SSave<cr>
" open file in directory of current file
nmap <leader>e :e %:h/
let g:ale_completion_enabled = 1
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'dense-analysis/ale'
Plugin 'pangloss/vim-javascript'
Plugin 'jiangmiao/auto-pairs'
Plugin 'tpope/vim-surround'
" Plugin 'vim-airline/vim-airline'
" Plugin 'vim-airline/vim-airline-themes'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-commentary'
Plugin 'airblade/vim-gitgutter'
call vundle#end()
" NERDTree
let NERDTreeShowHidden=1
" Airline
" let g:airline#extensions#ale#enabled = 1
" let g:airline_section_y = 'B:%{bufnr("%")}'
" let g:airline#extensions#tabline#buffer_nr_show = 1
" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#formatter = 'default'
" let g:airline_powerline_fonts = 1
" let g:airline_theme='papercolor'
"let g:lightline = { 'colorscheme': 'PaperColor' }
filetype plugin indent on    " required
" move to rtp ASAP
so ~/.vim/abbrev.vim
au CursorHoldI * stopinsert
" au FileType markdown set colorcolumn=100 autoindent linebreak conceallevel=2
au FileType text set colorcolumn=100 autoindent linebreak
au BufNewFile,BufRead *.markdown,*.mdown,*.mkd,*.mkdn,*.mdwn,*.md,*.MD  set ft=markdown
