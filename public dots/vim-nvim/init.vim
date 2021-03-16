set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/.vimrc
set guicursor=
set clipboard=unnamedplus
set noshowcmd
set splitright
set updatetime=2500
set undodir=~/.vim/undodir
set undofile
set inccommand=split
set scrolloff=1

" rip off TJ DeVries' local_plug func until I move to lua (seems inevitable)
" https://github.com/tjdevries/config_manager/blob/993bf6852bfec2778df797dcd7e217579b8f563d/xdg_config/nvim/init.vim#L31
function! s:local_plug(package_name) abort 
  if isdirectory(expand("~/vim-dev/plugins/" . a:package_name))
    execute "Plug '~/vim-dev/plugins/".a:package_name."'"
  else
    execute "Plug 'joelpalmer/" .a:package_name."'"
  endif
endfunction
" -- end local_plug()

call plug#begin('~/.vim/plugged')
" locals
" call s:local_plug('TBD.vim')
" add more locals --
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
Plug 'jparise/vim-graphql'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-unimpaired'
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'
Plug 'tpope/vim-abolish'
Plug 'stsewd/fzf-checkout.vim'
Plug 'pbrisbin/vim-mkdir'
Plug 'vim-test/vim-test'
Plug 'mbbill/undotree'
Plug 'ruanyl/coverage.vim'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'moll/vim-node'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'rust-lang/rust.vim'
Plug 'cespare/vim-toml'
Plug 'NLKNguyen/papercolor-theme'
Plug 'andymass/vim-matchup'
" Neovim lsp Plugins
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
" Plug 'pwntester/octo.nvim'
" Plug 'nvim-lua/popup.nvim'
" Plug 'nvim-lua/plenary.nvim'
" Plug 'nvim-telescope/telescope.nvim'
" Plug 'tjdevries/nlua.nvim'
Plug 'nvim-lua/lsp_extensions.nvim'
Plug 'junegunn/vim-peekaboo'
call plug#end()


" NERDTree
let NERDTreeShowHidden=1
let NERDTreeMinimalMenu=1
let NERDTreeMinimalUI = 1

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
			\       'transparent_background': 1,
			\       'override' : {
			\       'cursorlinenr_bg' : ['#e4e4e4', '254'],
			\         'color10' : ['#005f00', '22'],
			\         'color03' : ['#005f87', '24'],
			\         'color11' : ['#lclclc', '234'],
			\         'spellbad' : ['#ffaf87', '216'],
			\       }
			\     }
			\   }
			\ }
colorscheme PaperColor

" lsp config - JavaScipt using ALE/lsp hybrid. Look in JavaScript ftplugin.
" Additional lsp settings in ftplugin for each language
" - C
lua require'lspconfig'.clangd.setup{ on_attach=require'completion'.on_attach }
" - VimL 
lua require'lspconfig'.vimls.setup{}
" - Rust
lua <<EOF

-- nvim_lsp object
local nvim_lsp = require'lspconfig'

-- function to attach completion when setting up lsp
local on_attach = function(client)
    require'completion'.on_attach(client)
end

-- Enable rust_analyzer
nvim_lsp.rust_analyzer.setup({
    on_attach=on_attach,
    settings = {
        ["rust-analyzer"] = {
            cargo = {
                loadOutDirsFromCheck = true
            },
            procMacro = {
                enable = true
            },
        }
    }
})

-- Enable diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    update_in_insert = true,
  }
)
EOF

" sessions
nmap <leader>ss :mksession ~/vim-sessions/
nmap <leader>os :mksession! ~/vim-sessions/
nmap <silent><leader>ls :mksession! ~/vim-sessions/latest.vim<cr>

" paste last thing yanked, not deleted
nmap ,p "0p
nmap ,P "0P

" open quickfix or loc list
nmap <silent><leader>co :cope<CR>
nmap <silent><leader>lo :lope<CR>
" vim-surround maps
" surround word under cursor w/ backticks
nmap <leader>` ysiW`
" Duplicate a selection
" Visual mode: D
vmap D y'>p
" Join lines and restore cursor location
nnoremap J mjJ`j
" save some strokes (best mapping ever)
nnoremap ; :
vnoremap ; :
" dictionary completion - overrides digraphs mapping
inoremap <C-d> <C-x><C-k>
" thesaurus completion
set thesaurus+=~/.vim/thesaurus/thesaurii.txt
inoremap <C-t> <C-x><C-t>
" line completion
inoremap <C-l> <C-x><C-l>
" check for spelling completion
inoremap <C-s> <C-x><C-s>
" file path completion
inoremap <C-f> <C-x><C-f>
" Vim command-line completion
inoremap <C-v> <C-x><C-v>

" When editing a file, always jump to the last known cursor position
autocmd BufReadPost *
			\ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
			\ |   exe "normal! g`\""
			\ | endif
" no help when I fat finger F1
nmap <F1> <Esc>
" yank all in buffer
nmap <silent><leader>a :%y<cr>
" yank the rest of the line
nmap Y y$
" Move between Vimdows
nmap <up> <C-w><up>
nmap <down> <C-w><down>
nmap <left> <C-w><left>
nmap <right> <C-w><right>
" back in jumplist
nmap <silent> <leader><bs> <C-o>
" forward in jumplist
nmap <silent> <leader><space> <C-i>
" Add empty line(s)
" handled by unimpaired for now
" nnoremap <silent> [<space>  :<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[
" nnoremap <silent> ]<space>  :<c-u>put =repeat(nr2char(10), v:count1)<cr>
" open latest `todo` file, set by `T mark
nnoremap <silent> <leader>to :sp \| norm `T<cr>
" Replace word under cursor in file
nmap <leader>sr *:%s//
" Replace word under cursor in line
nmap <leader>sl *:s///g<left><left>
" undotree
nnoremap <silent><leader>u :UndotreeToggle<CR>
let g:undotree_HelpLine = 0
let g:undotree_WindowLayout = 2
let g:undotree_ShortIndicators = 1
let g:undotree_DiffpanelHeight = 6
" Fugitive & git gutter settings
nnoremap <silent> <leader>gb :Git blame<Return>
nnoremap <silent> <leader>hu :GitGutterUndoHunk<Return>
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
" **Term settings**
" open zsh in vsplit or split
command! -nargs=* T split | terminal <args>
nmap <silent> <leader>ts :T<cr>
command! -nargs=* VT vsplit | terminal <args>
nmap <silent> <leader>t :VT<cr>
" delete terminial buffer - :q is fine in split
nnoremap <silent> <leader>tx :bd!<CR>
" open file under cursor in vert split - not term specific but...
nmap <silent> <leader>gf :vs <cfile><CR>
au TermOpen,TermEnter * setlocal nonu nornu | execute 'keepalt' 'file' fnamemodify(getcwd() . ' BN:' . bufnr('%'), ':t')
" - not sure why I have this & <del> set? hmmm
if has('nvim')
	tmap <C-o> <C-\><C-n>
endif
" -- this all needs to become one function call --
" -- yank path out of terminal
command! -nargs=* NCD call chansend(b:terminal_job_id, "yp\<cr>")
nmap <silent><leader>D :NCD<cr>
" -- change lcd to term dir (copied from above :NCD)
nmap <silent><leader>F :lcd<c-r>+<cr>
" --- 
" end term settings ***

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
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>bc :BCommits<CR>
nnoremap <C-p> :GFiles<CR>
nnoremap <leader>p :Files<CR>
nnoremap <silent> <leader>fm :Marks<CR>
nnoremap <silent> <leader>rt :VimRTP<CR>
" search notes
nnoremap <silent> <leader>n :Notes<CR>
" new not or open a note
nnoremap <silent>,n :vs ~/notes/<CR>
let g:fzf_layout = { 'window': { 'width': 0.99, 'height': 0.8 } }
let g:fzf_preview_window = 'right:61%'
let $FZF_DEFAULT_OPTS='--reverse'
command! -bang -nargs=* Rg
			\ call fzf#vim#grep(
			\   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
			\   fzf#vim#with_preview(), <bang>0)

command! -bang VimRTP call fzf#vim#files('~/.vim', <bang>0)
command! -bang Notes call fzf#vim#files('~/notes', <bang>0)

autocmd! FileType fzf set laststatus=1 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

augroup LuaHighlight
	autocmd!
	autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
augroup END
" open already open files read-only
" autocmd SwapExists * let v:swapchoice = "o"
" no c++ here
autocmd BufRead,BufNewFile *.h set filetype=c
