-- *** Neovim Config Luatized *** --
require "joel.plugins"

-- telescope
require "joel.telescope"

-- mappings
require "joel.mappings"

-- completion
require "joel.completion"

-- settings(options)
require "joel.settings"

-- treesitter & lsp
require "joel.config"

-- require("joel.utils")

-- ** Mappings galore
-- see mappings.lua
-- @TODUA: finish refactoring & migrating below to mappings/settings to Lua!
vim.cmd [[
" Duplicate a selection
" Visual mode: D
vmap D y'>p
" Join lines and restore cursor location
nnoremap J mjJ`j
" -- completion maps --
" Mostly handled by `compe` 🌟
" thesaurus @TODO: Remove? only thing left in ~/.vim
" set thesaurus+=~/.vim/thesaurus/thesaurii.txt
inoremap <C-t> <C-x><C-t>
" line completion - use more!
inoremap <C-l> <C-x><C-l>
" check for spelling completion (compe?)
inoremap <C-s> <C-x><C-s>
" file path completion (compe!)
" inoremap <C-f> <C-x><C-f>
" Vim command-line completion
inoremap <C-v> <C-x><C-v>
" -- end completion maps --

" auto exit insert mode
au CursorHoldI * stopinsert
au FileType text set colorcolumn=100 autoindent linebreak
au BufNewFile,BufRead *.markdown,*.mdown,*.mkd,*.mkdn,*.mdwn,*.md,*.MD  set ft=markdown

" yank all in buffer
nmap <silent><leader>a :%y<cr>
" yank rest of the line - now builtin https://github.com/neovim/neovim/pull/13268
"nmap Y y$
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
" open latest `todo` file, set by `T mark
nnoremap <silent> <leader>to :sp \| norm `T<cr>
" Replace word under cursor in File (case-sensitive)
nmap <leader>sr :%s/<C-R><C-W>//gI<left><left><left>
" Replace word under cursor on Line (case-sensitive)
nmap <leader>sl :s/<C-R><C-W>//gI<left><left><left>
" undotree
nnoremap <silent><leader>u :UndotreeToggle<CR>
let g:undotree_HelpLine = 0
let g:undotree_WindowLayout = 2
let g:undotree_ShortIndicators = 1
let g:undotree_DiffpanelHeight = 6
" Fugitive maps
nnoremap <silent> <leader>gb :Git blame<Return>
nmap <leader>gp :Gpush origin
" splitsville
" - small vertical split to the right & go to it
" nnoremap <silent> ,\ :75vsp<CR><C-w><right>
" split - larger top
nnoremap <silent> ,- :22sp<CR><C-w><down>
" Markdown-preview settings
nmap <leader>md <Plug>MarkdownPreview
" nvim-tree settings
let g:nvim_tree_ignore = [ '.git', 'node_modules', '.cache', '.DS_Store' ]
" let g:nvim_tree_gitignore = 1
let g:nvim_tree_highlight_opened_files = 1
let g:nvim_tree_auto_close = 0
nnoremap <silent><C-p> :NvimTreeToggle<CR>
nnoremap <silent><space>f :NvimTreeFindFile<CR>
let g:nvim_tree_icons = { 'git': { 'unstaged': '±', 'staged': '', 'deleted': '✗' } }

" ** Test and  coverage related **
" Specify the path to `coverage.json` file relative to your current working directory.
let g:coverage_json_report_path = 'coverage/coverage-final.json'

" Define the symbol display for covered lines
let g:coverage_sign_covered = ''

" Define the symbol display for uncovered lines
let g:coverage_sign_uncovered = ''

" Define the interval time of updating the coverage lines
let g:coverage_interval = 3000

" Do not display signs on covered lines
let g:coverage_show_covered = 0

" Display signs on uncovered lines
let g:coverage_show_uncovered = 1

" using lowercase t for term:// split now
" nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
let g:test#runner_commands = ['Jest']
" jank/vim-test and mfussenegger/nvim-dap
"nnoremap <leader>dt :TestNearest -strategy=jest<CR>

" @TODUA: replace any desired features from floaterm or toggleterm here
" ** Built-in Term settings**
" open new neovim terminal: zsh in vsplit or split
" command! -nargs=* T split | terminal <args>
" nmap <silent> <leader>t :T<cr>
command! -nargs=* VT vsplit | terminal <args>
nmap <silent> <leader>tv :VT<cr>
" open existing terminal (or any) buffer in vert right split: @[N]
command! -nargs=* VRSB vertical rightbelow sb<args>
nnoremap <leader>br :VRSB
" delete terminal buffer - :q is fine to close in split
nnoremap <silent> <leader>tx :bd!<CR>
" open file under cursor in vert split - not term specific but...
nmap <silent> <leader>gf :vs <cfile><CR>

" handle darkening terminal buffers & highlighting active term buffer
au TermOpen,TermEnter * setlocal nonu nornu winhighlight=Normal:DarkenedTerm,NormalNC:DarkenedTermNC | execute 'keepalt' 'file' fnamemodify(getcwd() . '   '. bufnr('%'), ':t')

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

" change dir for window to file's dir
nnoremap <silent><leader>cd :lcd %:p:h<cr>
" change dir for window to file's git working dir
nnoremap <silent><leader>gd :Glcd<cr>

" Delete to Esc from (almost) all the things
nnoremap <Del> <Esc>
vnoremap <Del> <Esc>gV
onoremap <Del> <Esc>
cnoremap <Del> <C-C><Esc>
inoremap <Del> <Esc>`^
tnoremap <Del> <C-\><C-n>
" yank current file path
nnoremap <leader>fp :!ls %:p <bar> pbcopy<cr>
" diff since last save
" -- quicky
nnoremap <leader>c :w !diff % -<CR>
" full featured diff
command! DiffOrig let g:diffline = line('.') | vert new | set bt=nofile | r # | 0d_ | diffthis | :exe "norm! ".g:diffline."G" | wincmd p | diffthis | wincmd p
nnoremap <Leader>do :DiffOrig<cr>
" end diffing, delete scratch(or diff2) buffer & go back to location
nnoremap <silent> <leader>dc :bd<cr>:diffoff<cr>:exe "norm! ".g:diffline."G"<cr>
" diff 2 or more windows/splits, end with \dc or just :diffoff to keep file2
nnoremap <leader>dw :windo diffthis<cr>

" ------------------------------------------------------------- "
" @TODUA: make a Lua version of this & the map
nnoremap <silent>gx :call OpenURLUnderCursor()<CR>
function! OpenURLUnderCursor()
  let l:uri = expand('<cWORD>')
  silent exec "!open '" . l:uri . "'"
  :redraw!
endfunction
]]
