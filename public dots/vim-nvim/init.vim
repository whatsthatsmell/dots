" source ~/.vimrc :-(
" -- ready to move to init.lua...
" -- All. The. Lua --
lua << END
-- the speedway to init.lua 🤣 
vim.cmd([[
call plug#begin('~/.vim/plugged')
" Plugins
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-abolish'
Plug 'stsewd/fzf-checkout.vim'
Plug 'pbrisbin/vim-mkdir'
Plug 'vim-test/vim-test'
Plug 'mbbill/undotree'
Plug 'ruanyl/coverage.vim'
Plug 'moll/vim-node'
Plug 'rust-lang/rust.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'junegunn/vim-peekaboo'
Plug 'chrisbra/Colorizer'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
Plug 'voldikss/vim-floaterm'
call plug#end()

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
set nu
set rnu
set hidden
set completeopt=menu,menuone,preview,noselect,noinsert
set dictionary+=/usr/share/dict/words
set wildignore+=*/node_modules/*,*/coverage/*
set incsearch
set ignorecase
set smartcase
set ts=2
set sw=2
set guicursor=
set clipboard=unnamedplus
set noshowcmd
set splitbelow
set splitright
set updatetime=2500
set undodir=~/.vim/undodir
set undofile
set inccommand=split
set scrolloff=1
set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
set grepformat=%f:%l:%c:%m,%f:%l:%m

" netrw settings
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_winsize = 27
let g:netrw_list_hide= netrw_gitignore#Hide()

let g:matchup_surround_enabled = 1

" fzf-gh settings
let g:fzf_gh_website=1

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

]])

require('joel.plugins')

-- treesitter
	require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true
  },
	incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
	indent = {
    enable = true,
		disable = { "javascript" }
  },
	matchup = {
    enable = true,
  },
	autopairs = {
		enable = true
	},
	  playground = {
    enable = true,
    disable = {},
    updatetime = 25,
    persist_queries = false,
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  },
	rainbow = {
    enable = true,
    extended_mode = true, -- Highlight also non-parentheses delimiters
    max_file_lines = 1000, 
	}
}
-- telescope
require('joel.telescope')

-- setup compe
-- snippet support
local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif vim.fn.call("vsnip#available", {1}) == 1 then
    return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
    return t "<Plug>(vsnip-jump-prev)"
  else
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

-- Enable diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
		underline = true,
    signs = true,
    update_in_insert = false,
  }
)

-- Send diagnostics to quickfix list
do
  local method = "textDocument/publishDiagnostics"
  local default_handler = vim.lsp.handlers[method]
  vim.lsp.handlers[method] = function(err, method, result, client_id, bufnr, config)
    default_handler(err, method, result, client_id, bufnr, config)
    local diagnostics = vim.lsp.diagnostic.get_all()
    local qflist = {}
    for bufnr, diagnostic in pairs(diagnostics) do
      for _, d in ipairs(diagnostic) do
        d.bufnr = bufnr
        d.lnum = d.range.start.line + 1
        d.col = d.range.start.character + 1
        d.text = d.message
        table.insert(qflist, d)
      end
    end
    vim.lsp.util.set_qflist(qflist)
  end
end

-- mappings galore
  -- toggle search highlights
vim.api.nvim_set_keymap('n', '<Leader>\\', ':set hlsearch!<CR>', { noremap = true, silent = true })
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
-- @TODUA: refactor more mappings to Lua
vim.cmd([[
" expands to dir of current file in cmd mode
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" open file in directory of current file
nmap <leader>e :e %:h/
nmap <leader>v :vs %:h/

" compe maps
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

" sessions
nmap <leader>ss :mksession ~/vim-sessions/
nmap <leader>os :wa<Bar>exe "mksession! " . v:this_session
nmap <silent><leader>ls :mksession! ~/vim-sessions/latest.vim<cr>

" paste last thing yanked(not system copied), not deleted
nmap ,p "0p
nmap ,P "0P

" DELETE: with y,d or c{motion} & it wont replace "0
nnoremap _ "_
" REPLACE: delete inner word & replace with last yanked (including system)
nmap ,r "_diwhp
" open quickfix / close
nmap <silent><leader>co :cope<CR>
nmap <silent><leader>cl :cclose<CR>
" open location list - close manually
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
" -- completion maps --
" Mostly handled by `compe` 🌟
" thesaurus completion @TODO: Remove?
set thesaurus+=~/.vim/thesaurus/thesaurii.txt
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

filetype plugin indent on    " required
" auto exit insert mode
au CursorHoldI * stopinsert
au FileType text set colorcolumn=100 autoindent linebreak
au BufNewFile,BufRead *.markdown,*.mdown,*.mkd,*.mkdn,*.mdwn,*.md,*.MD  set ft=markdown

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
" open latest `todo` file, set by `T mark
nnoremap <silent> <leader>to :sp \| norm `T<cr>
" Replace word under cursor in file (case-sensitive)
nmap <leader>sr *:%s///gI<left><left><left>
" Replace word under cursor in line (case-sensitive)
nmap <leader>sl *:s///gI<left><left><left>
" undotree
nnoremap <silent><leader>u :UndotreeToggle<CR>
let g:undotree_HelpLine = 0
let g:undotree_WindowLayout = 2
let g:undotree_ShortIndicators = 1
let g:undotree_DiffpanelHeight = 6
" Fugitive maps
nnoremap <silent> <leader>gb :Git blame<Return>
nmap <leader>gp :Gpush origin
nnoremap <leader>gc :GBranches<CR>
" splitsville
" - small vertical split to the right & go to it
nnoremap <silent> ,\ :75vsp<CR><C-w><right>
" split - larger top
nnoremap <silent> ,- :22sp<CR><C-w><down>
" Markdown-preview settings
nmap <leader>md <Plug>MarkdownPreview
" 
" ** Test and  coverage related **
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

" using lowercase t for term:// split now
" nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
let g:test#runner_commands = ['Jest']

" floaterm maps etc.
let g:floaterm_title = '  ($1/$2) '
" vft to open in main nvim
nnoremap   <silent>   <leader>tn    :FloatermNew<CR>
tnoremap   <silent>   <leader>tn    <C-\><C-n>:FloatermNew<CR>
nnoremap   <silent>   <leader>tp    :FloatermPrev<CR>
tnoremap   <silent>   <leader>tp    <C-\><C-n>:FloatermPrev<CR>
" nnoremap   <silent>   <F9>    :FloatermNext<CR>
" tnoremap   <silent>   <F9>    <C-\><C-n>:FloatermNext<CR>
nnoremap   <silent>   <leader>t   :FloatermToggle<CR>
tnoremap   <silent>   <leader>t   <C-\><C-n>:FloatermToggle<CR>
" **Term settings**
" open new neovim terminal: zsh in vsplit or split
" command! -nargs=* T split | terminal <args>
" nmap <silent> <leader>t :T<cr>
command! -nargs=* VT vsplit | terminal <args>
nmap <silent> <leader>tv :VT<cr>
" open existing terminal (or any) buffer in vert right split: @[N]
command! -nargs=* VRSB vertical rightbelow sb<args>
nnoremap <leader>br :VRSB
" delete terminal buffer - :q is fine in split
nnoremap <silent> <leader>tx :bd!<CR>
" open file under cursor in vert split - not term specific but...
nmap <silent> <leader>gf :vs <cfile><CR>
au TermOpen,TermEnter * setlocal nonu nornu | execute 'keepalt' 'file' fnamemodify(getcwd() . ' ⓣ  '. bufnr('%'), ':t')

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
" telescope time
" -- find files with gitfiles & fallback on find_files
nnoremap <silent> ,<space> :lua require'joel.telescope'.project_files()<cr>
" browse, explore and create notes
nnoremap <silent> ,n :lua require'joel.telescope'.find_notes()<cr>
" search notes
nnoremap <silent> <space>n :lua require'joel.telescope'.grep_notes()<cr>
" Explore files starting at $HOME
nnoremap <silent> ,e :lua require'joel.telescope'.file_explorer()<cr>
" greg for a string
nnoremap <silent> <space>g :lua require'joel.telescope'.grep_prompt()<cr>
" find a Vim runtimepath file
nnoremap <silent> <leader>rt :lua require'joel.telescope'.vim_rtp()<cr>
" find or create neovim configs
nnoremap <silent> <leader>nc :lua require'joel.telescope'.nvim_config()<cr>
" slowness: https://github.com/nvim-telescope/telescope.nvim/issues/392
nnoremap <silent> ,g :Telescope live_grep<cr>
nnoremap <silent> ,k :Telescope keymaps<cr>
nnoremap <silent> ,b :Telescope buffers<cr>
nnoremap <silent> ,h :Telescope help_tags<cr>
nnoremap <silent> <leader>fm :Telescope marks<cr>
nnoremap <silent> <leader>is :Telescope gh issues<cr>
" FZF mappings and config
" ---> :PRS and :PRSR - fzf-gh.vim
" PRs assigned awaiting my review
nnoremap <silent> <leader>pr :PRSR<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>bc :BCommits<CR>
nnoremap <silent> <leader>bt :BTags<CR>
nnoremap <silent> ,l :Lines<CR>
nnoremap <silent> <leader>l :BLines<CR>
nnoremap <C-p> :GFiles<CR>
nnoremap <leader>p :Files<CR>
" 'grep' word under cursor
nnoremap <silent> <leader>g :Rg <C-R>=expand("<cword>")<CR><CR>
" 'grep' -- ripgrep!
nnoremap <silent> <leader>rg :RG<CR>
let g:fzf_layout = { 'window': { 'width': 0.99, 'height': 0.8 } }
let g:fzf_preview_window = 'right:61%'
let $FZF_DEFAULT_OPTS='--reverse --multi'

autocmd! FileType fzf set laststatus=1 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

augroup LuaHighlight
	autocmd!
	autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
augroup END

autocmd BufRead,BufNewFile *.h set filetype=c

nnoremap <silent>gx :call OpenURLUnderCursor()<CR>

" fzf-checkout settings
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
" ripgrep with FZF only used as selector
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" FZF fuzzy file finding with ripgrep
command! -bang -nargs=* Rg
			\ call fzf#vim#grep(
			\   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
			\   fzf#vim#with_preview(), <bang>0)

function! OpenURLUnderCursor()
  let l:uri = expand('<cWORD>')
  silent exec "!open '" . l:uri . "'"
  :redraw!
endfunction
]])
END
