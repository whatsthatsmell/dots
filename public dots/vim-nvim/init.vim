set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/.vimrc
set guicursor=
set clipboard=unnamedplus
set noshowcmd
set splitright
set updatetime=2000
set undodir=~/.vim/undodir
set undofile
set inccommand=nosplit
set scrolloff=1
call plug#begin('~/.vim/plugged')
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
Plug 'jparise/vim-graphql'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-rhubarb'
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'
Plug 'tpope/vim-abolish'
Plug 'stsewd/fzf-checkout.vim'
Plug 'pbrisbin/vim-mkdir'
Plug 'vim-test/vim-test'
Plug 'mbbill/undotree'
Plug 'ruanyl/coverage.vim'
Plug 'mhinz/vim-startify'
Plug 'ron89/thesaurus_query.vim'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'moll/vim-node'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'rust-lang/rust.vim'
Plug 'NLKNguyen/papercolor-theme'
Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }
" Neovim lsp Plugins
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
" Plug 'pwntester/octo.nvim'
" Plug 'nvim-lua/popup.nvim'
" Plug 'nvim-lua/plenary.nvim'
" Plug 'nvim-telescope/telescope.nvim'
" Plug 'tjdevries/nlua.nvim'
" Plug 'tjdevries/lsp_extensions.nvim'
" Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" trial ** cheatsheet sh - settings in after/ftplugin/javascript.vim
Plug 'dbeniamine/cheat.sh-vim'
call plug#end()

" thesaurus settings
let g:tq_enabled_backends=["datamuse_com", "mthesaur_txt"]
" firenvim
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
" syntax highlight only to 1K instead of default 3K
set synmaxcol=1000
" lightline config
let g:lightline = {
			\ 'component': {
	    \  'spell': '%{&spell?"SPELL":""}',
      \  'lineinfo': '%3l/%1L:%-2c'},
			\ 'active': {
			\   'left': [ [ 'mode', 'paste', 'spell' ],
			\             [ 'gitbranch', 'readonly', 'filename' ] ],
			\   'right': [ [ 'lineinfo' ],
			\             [ 'filetype' ], [ 'linter_errors'] ] },
			\ 'inactive': {
			\  'left': [ ['filename'] ],
			\  'right': [ ['filetype'] ] }, 
			\ 'component_function': {
			\   'gitbranch': 'FugitiveHead',
			\   'filename': 'LightlineFilename',
			\ }
			\ }
let g:lightline.component_expand = {
      \  'linter_errors': 'lightline#ale#errors'
      \ }
let g:lightline.component_type = {
      \     'linter_errors': 'warning'
      \ }

function! LightlineFilename()
	let filename = expand('%:~:.') !=# '' ? expand('%:~:.') : '[No Name]'
	let modified = &modified ? ' +' : ''
	return filename . modified
endfunction

" PaperColor settings
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
"let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
" lua require'lspconfig'.rust_analyzer.setup{ on_attach=require'completion'.on_attach }
" ** using ALE as the client except for clang (for now) specifics in after/ftplugin/c.vim **
lua require'lspconfig'.clangd.setup{ on_attach=require'completion'.on_attach }
" still not working: allow stop insert while editing a file under lsp
" lua << EOF
"     vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
"       vim.lsp.diagnostic.on_publish_diagnostics, {
"         -- delay update diagnostics
"         update_in_insert = false,
"       }
"     )
" EOF

" open quickfix or loc list
nmap <silent><leader>co :cope<CR>
nmap <silent><leader>lo :lope<CR>
" vim-surround maps
" surround word under cursor w/ backticks
nmap <leader>` ysiw`
" -- trial mappings --
" Duplicate a selection
" Visual mode: D
vmap D y'>p
" Join lines and restore cursor location (J) {{{
nnoremap J mjJ`j
" }}}
" ----
" save some strokes
nnoremap ; :
vnoremap ; :
" dictionary completion - overrides digraphs mapping
inoremap <C-k> <C-x><C-k>
" thesaurus completion- plugin
inoremap <C-t> <C-x><C-u>
" line completion
inoremap <C-l> <C-x><C-l>
" When editing a file, always jump to the last known cursor position
autocmd BufReadPost *
			\ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
			\ |   exe "normal! g`\""
			\ | endif
" clone paragraph -- needs work for code
" noremap cp yap<S-}>p
" --- end of trial mappings ---
" no help when I fat finger F1
nmap <F1> <Esc>
nmap Y "+y$
" Move between panes
nmap <up> <C-w><up>
nmap <down> <C-w><down>
nmap <left> <C-w><left>
nmap <right> <C-w><right>
" back in jumplist
nmap <silent> <leader><bs> <C-o>
" forward in jumplist
nmap <silent> <leader><space> <C-i>
" Add empty line(s)
nnoremap <silent> [<space>  :<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[
nnoremap <silent> ]<space>  :<c-u>put =repeat(nr2char(10), v:count1)<cr>
" open latest `todo` file, set by `T mark
nnoremap <silent> <leader>to :sp \| norm `T<cr>
" Replace word under cursor in file
nmap <leader>sr *:%s//
" undotree
nnoremap <silent><leader>u :UndotreeToggle<CR>
let g:undotree_HelpLine = 0
let g:undotree_WindowLayout = 2
let g:undotree_ShortIndicators = 1
let g:undotree_DiffpanelHeight = 6
" Fugitive settings
nnoremap <silent> <leader>gb :Git blame<Return>
nnoremap <silent> <leader>hh :GitGutterLineHighlightsToggle<Return>
nmap <leader>gp :Gpush origin
" fzf-checkout settings
nnoremap <leader>gc :GBranches<CR>
let g:fzf_branch_actions = {
			\ 'rebase': {
			\   'prompt': 'Rebase> ',
			\   'execute': 'echo system("{git} rebase {branch}")',
			\   'multiple': v:false,
			\   'keymap': 'ctrl-r',
			\   'required': ['branch'],
			\   'confirm': v:false,
			\ },
			\ 'diff': {
			\   'prompt': 'Diff> ',
			\   'execute': 'Git diff {branch}',
			\   'multiple': v:false,
			\   'keymap': 'ctrl-f',
			\   'required': ['branch'],
			\   'confirm': v:false,
			\ },
			\ 'track': {
			\   'prompt': 'Track> ',
			\   'execute': 'echo system("{git} checkout --track {branch}")',
			\   'multiple': v:false,
			\   'keymap': 'ctrl-t',
			\   'required': ['branch'],
			\   'confirm': v:false,
			\ },
			\}
let g:fzf_checkout_git_options = '--sort=-committerdate'
let g:fzf_checkout_previous_ref_first = v:true

" OS X-like space bar to scroll.
nnoremap <Space> <C-F>
" Markdown-preview settings
nmap <leader>md <Plug>MarkdownPreview
" Specify the path to `coverage.json` file relative to your current working directory.
let g:coverage_json_report_path = 'coverage/coverage-final.json'

" Define the symbol display for covered lines
let g:coverage_sign_covered = '⦿'

" Define the interval time of updating the coverage lines
let g:coverage_interval = 3000

" Do not display signs on covered lines
let g:coverage_show_covered = 0

" Display signs on uncovered lines
let g:coverage_show_uncovered = 1
" Test settings
" using lowercase t for term:// split now
" nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
" Term settings
" open zsh in vsplit
nmap <silent> <leader>t :vs term://zsh<cr>
au TermOpen * setlocal nonu nornu
" - not sure why I have this & <del> set? hmmm
if has('nvim')
	tmap <C-o> <C-\><C-n>
endif



let g:test#runner_commands = ['Jest']

" Delete to Esc from (almost) all the things
nnoremap <Del> <Esc>
vnoremap <Del> <Esc>gV
onoremap <Del> <Esc>
cnoremap <Del> <C-C><Esc>
inoremap <Del> <Esc>`^
tnoremap <Del> <C-\><C-n>
" diff since last save
nnoremap <leader>c :w !diff % -<CR>
command! DiffOrig let g:diffline = line('.') | vert new | set bt=nofile | r # | 0d_ | diffthis | :exe "norm! ".g:diffline."G" | wincmd p | diffthis | wincmd p
nnoremap <Leader>do :DiffOrig<cr>
nnoremap <leader>dc :bd<cr>:diffoff<cr>:exe "norm! ".g:diffline."G"<cr>
" fzf configure
nnoremap <C-p> :GFiles<CR>
nnoremap <leader>p :Files<CR>
nnoremap <silent> <leader>fm :Marks<CR>
nnoremap <silent> <leader>rt :VimRTP<CR>
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.7 } }
let g:fzf_preview_window = 'right:55%'
let $FZF_DEFAULT_OPTS='--reverse'
command! -bang -nargs=* Rg
			\ call fzf#vim#grep(
			\   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
			\   fzf#vim#with_preview(), <bang>0)

command! -bang VimRTP call fzf#vim#files('~/.vim', <bang>0)

" vim-doge
let g:doge_mapping = '<Leader>j'

" startify
nmap <silent> <leader>m :Startify<cr>
let g:startify_files_number = 4
let g:startify_enable_special = 0
let g:startify_change_to_vcs_root = 1
let g:startify_padding_left = 2
let g:startify_custom_header = "startify#pad(split(system('date'), '\n') + split(system('pwd'), '\n'))"
let g:startify_relative_path = 1

" returns all modified files of the current git repo
" `2>/dev/null` makes the command fail quietly, so that when we are not
" in a git repo, the list will be empty
function! s:gitModified()
	let files = systemlist('git ls-files -m 2>/dev/null')
	return map(files, "{'line': v:val, 'path': v:val}")
endfunction

" same as above, but show untracked files, honoring .gitignore
function! s:gitUntracked()
	let files = systemlist('git ls-files -o --exclude-standard 2>/dev/null')
	return map(files, "{'line': v:val, 'path': v:val}")
endfunction

let g:startify_lists = [
			\ { 'type': 'files',     'header': ['   Recent']            },
			\ { 'type': 'dir',       'header': ['   Dir '. getcwd()] },
			\ { 'type': 'sessions',  'header': ['   Sessions']       },
			\ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
			\ { 'type': function('s:gitModified'),  'header': ['   git modified']},
			\ { 'type': function('s:gitUntracked'), 'header': ['   git untracked']},
			\ { 'type': 'commands',  'header': ['   Commands']       },
			\ ]
" bring on the goodness nvim 0.5
augroup LuaHighlight
	autocmd!
	autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
augroup END
" open already open files read-only
autocmd SwapExists * let v:swapchoice = "o"
" no c++ here
autocmd BufRead,BufNewFile *.h set filetype=c
