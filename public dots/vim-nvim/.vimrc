set nocompatible              " be iMproved, required
filetype off                  " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
set nu
set rnu
set hidden
set completeopt=menu,menuone,preview,noselect,noinsert
set omnifunc=ale#completion#OmniFunc
set wildignore+=*/node_modules/*,*/coverage/*
set colorcolumn=80
set incsearch
set ignorecase
set smartcase
set ts=2
set sw=2
highlight ColorColumn ctermbg=darkgrey
highlight clear ALEErrorSign
highlight clear ALEWarningSign
let g:ale_sign_error = "❗️"
let g:ale_sign_warning = "⚠︎"
syntax enable
" copy to sys clipboard
noremap <Leader>y "+y
noremap <Leader>\ :noh<cr>
noremap <Leader>w :w<cr>
noremap <silent> <Leader>q :q<cr>
nnoremap <silent> <leader>s :setlocal spell!<cr>
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
" go to next buffer
nnoremap <silent> <leader>b :bn<CR>
" go to prev buffer
nnoremap <silent> <leader>B :bp<CR>
" delete current buffer
nnoremap <silent> <leader>x :bd<CR>
" 'grep' word under cursor
nnoremap <silent> <leader>g :Rg <C-R>=expand("<cword>")<CR><CR>
" ALE keys
nmap <silent> <leader>h :ALEHover<cr>
nmap <silent> <leader>f :ALEFix<cr>
nmap <silent> <leader>d :ALEGoToDefinition<cr>
nnoremap <silent> <leader>r :ALEFindReferences -relative<Return>
nnoremap <silent> <leader>rn :ALERename<Return>

" make/save current (latest) session
nmap <leader>M :mksession! ~/vim-sessions/latest.ses<cr>
" make/save a new session
nmap <leader>m :mksession! ~/vim-sessions/
" augroup filetype_haskell
	" autocmd FileType haskell set iskeyword=a-z,A-Z,_,.,39,<,>,*,$,#
	" autocmd FileType haskell set formatoptions+=tcro
	" autocmd FileType haskell set formatoptions-=l
	" autocmd Filetype haskell setlocal ts=2 sw=2 expandtab autoindent
" augroup END
let g:ale_completion_enabled = 1
"let g:ale_lint_on_text_changed = 'never'
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'dense-analysis/ale'
Plugin 'pangloss/vim-javascript'
Plugin 'scrooloose/nerdtree'
Plugin 'jiangmiao/auto-pairs'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'tpope/vim-surround'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-repeat'
Plugin 'airblade/vim-gitgutter'
Plugin 'NLKNguyen/papercolor-theme'
call vundle#end()
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint'],
\}
let g:ale_linters = {
\   'javascript': ['eslint', 'tsserver'],
\}
let g:airline#extensions#ale#enabled = 1
"let g:airline_section_a = 'Easy Mode'
let g:airline_section_y = 'BN: %{bufnr("%")}'
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'default'
let g:airline_powerline_fonts = 1
let g:airline_theme='papercolor'
let g:lightline = { 'colorscheme': 'PaperColor' }
filetype plugin indent on    " required
so ~/.vim/abbrev.vim
au CursorHoldI * stopinsert
au FileType markdown set colorcolumn=100 autoindent linebreak
au FileType text set colorcolumn=100 autoindent linebreak
au BufNewFile,BufRead *.markdown,*.mdown,*.mkd,*.mkdn,*.mdwn,*.md,*.MD  set ft=markdown
