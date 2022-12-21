-- Neovim Settings & Options - Lua
-- @TODOUA: continue refactor to Lua autocmd API: https://github.com/neovim/neovim/pull/17551
-- -- not just here but in ftps and anywhere else in rtp

-- go to last location when opening a buffer
vim.cmd [[
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif
]]

-- vimdows to close with 'q'
vim.cmd [[autocmd FileType help,qf,fugitive,fugitiveblame,netrw nnoremap <buffer><silent> q :close<CR>]]

-- @TODOUA: try to get a lot of this buffer switching logic moved somewhere better
-- handle darkening terminal buffers & highlighting active term buffer, set default isSplit = 0. Will be set as needed
vim.cmd [[au TermOpen,TermEnter * let b:isSplit=0 | setlocal nonu nornu winhighlight=Normal:DarkenedTerm,NormalNC:DarkenedTermNC | execute 'keepalt' 'file' fnamemodify(getcwd() . '   '. bufnr('%'), ':t')]]

-- when leaving terminal buffer in split, unlist it (if specified in b:isSplit)
vim.cmd [[
	augroup UnlistSplitTerms
	  autocmd!
    autocmd BufLeave * if &buftype == 'terminal' && b:isSplit  | setlocal nobuflisted | endif
  augroup end
]]

-- if buftype is terminal and isSplit then turn off bn/bp maps & alert
vim.cmd [[
	augroup UnsetBufTermSwitchMaps
	  autocmd!
    autocmd BufEnter * if &buftype == 'terminal' && b:isSplit  | nnoremap <buffer><silent><localleader><left> :echom 'No buffer switching (bn/bp maps) in this split terminal! See isSplit or buflisted.'<CR> | nnoremap <buffer><silent><localleader><right> :echom 'No buffer switching (bn/bp maps) in this split terminal! Toggle isSplit or set buflisted.'<CR> | endif
  augroup end
]]

-- turn on cursorline, cursorcolumn when searching, sync with hlsearch
vim.api.nvim_exec(
  [[
augroup nvim-incsearch-cursorline
	autocmd!
	autocmd CmdlineEnter /,\? :set cursorline cursorcolumn hlsearch
augroup END
]],
  false
)

-- ** Lua autocmd API ** --
-- auto exit insert mode
vim.api.nvim_create_augroup("AutoExitInsertMode", {})
vim.api.nvim_create_autocmd("CursorHoldI", { command = "stopinsert", group = "AutoExitInsertMode" })

-- Highlight yanked
vim.api.nvim_create_augroup("HighlightYank", {})
vim.api.nvim_create_autocmd(
  "TextYankPost",
  { command = "silent! lua vim.highlight.on_yank()", group = "HighlightYank" }
)

-- header files should be treated like .c files (not cpp)
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, { pattern = "*.h", command = "set filetype=c" })

-- options --
vim.cmd [[
" Options in VimL form
set termguicolors
" syntax highlight only to 1K instead of default 3K
set synmaxcol=1000
let &packpath=&runtimepath
set dictionary+=/usr/share/dict/words
set wildignore+=*/node_modules/*,*/coverage/*
set guicursor=
set clipboard=unnamedplus
set undodir=~/.config/nvim/undodir
set undofile
set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
set grepformat=%f:%l:%c:%m,%f:%l:%m
]]

-- THEME stuff
vim.cmd "set fillchars+=vert:│"
vim.cmd "colorscheme codesmell_dark"
-- vim.cmd "colorscheme tokyonight-night"

vim.cmd "set spellfile=~/.config/nvim/spell/en.utf-8.add"
vim.cmd "filetype plugin indent on"

-- Options/Settings **
-- Window scope
-- @TODOUA: I really should just be using `opt` in here
vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.numberwidth = 6

-- winbar with time/date, file name,git change counts and modified
vim.opt.winbar = "%=%m %{strftime('%b %d %H:%M')}  %f %{get(b:,'gitsigns_status','')} "
-- Global scope
vim.o.completeopt = "menu,menuone,preview,noselect,noinsert"
vim.o.inccommand = "split"
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.scrolloff = 1
vim.o.hidden = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.showcmd = false -- default if cmdheight is 0
-- vim.opt.cmdheight = 0 - let is default to 1 until https://github.com/neovim/neovim/issues/18958
-- @TODOUA: consider using the global `cursorhold_updatetime` from FixCursorHold
vim.o.updatetime = 2000
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.pumblend = 5
vim.cmd [[hi PmenuSel blend=0]]

-- ** Global Vim vars that are on a solo-ish mission **
-- update tmux status on every move - but it only updates when moved - I want it to update on move and default
-- vim.g.tpipeline_cursormoved = 1
-- restore tmux status after vim closed
-- vim.g.tpipeline_restore = 1

-- Copilot globals
-- vim.g.copilot_filetypes = { ["*"] = false }
-- vim.g.copilot_no_tab_map = true

vim.g.matchup_matchparen_deferred = 1

-- * Colorizer *
-- auto color fts
vim.g.colorizer_auto_filetype = "yaml,zsh,zsh-theme,lua,vim,json"
-- keep colorizing on bufleave
vim.g.colorizer_disable_bufleave = 1
-- vim-test settings (JavaScript only)
-- https://github.com/vim-test/vim-test
-- @TODOUA: Need to figure out how to setlocal in ftplugin
-- -- I really don't want these globals
vim.g.coverage_sign_uncovered = ""
-- Specify the path to `coverage.json` file relative to your current working directory.
vim.g.coverage_json_report_path = "coverage/coverage-final.json"
-- @TODOUA: if we have to keep these global then finish Luatizing
vim.api.nvim_exec(
  [[
" Define the symbol display for covered lines
let g:coverage_sign_covered = ''

" Define the interval time of updating the coverage lines
let g:coverage_interval = 3000

" Do not display signs on covered lines
let g:coverage_show_covered = 0

" Display signs on uncovered lines
let g:coverage_show_uncovered = 1

let g:test#runner_commands = ['Jest']
]],
  false
)
-- * End of vim-test settings * --

-- indent-blankline (& list) settings
-- https://github.com/lukas-reineke/indent-blankline.nvim
-- g:indent_blankline_disable_with_nolist not working for me (19-Nov-2021)
vim.opt.list = false
vim.opt.listchars:append "space:⋅"
vim.opt.listchars:append "eol:↴"
vim.opt.listchars:append "trail:"
require("indent_blankline").setup {
  space_char_blankline = " ",
  buftype_exclude = { "terminal", "help", "telescope" },
  show_current_context = true,
  use_treesitter = true,
  enabled = false,
  -- in theme
  char_highlight_list = {
    "IndentBlanklineIndent1",
    "IndentBlanklineIndent2",
  },
}

local M = {}
-- boolify strings!
local toBool = {
  ["1"] = true,
  ["0"] = false,
}
-- Note: `foldcolumn` is not a boolean. You can set other values.
-- I only want to toggle between these two values though.
function M.toggle_fold_col()
  if toBool[vim.api.nvim_win_get_option(0, "foldcolumn")] then
    vim.opt.foldcolumn = "0"
  else
    vim.opt.foldcolumn = "1"
  end

  require "notify"(
    "foldcolumn is set to " .. vim.api.nvim_win_get_option(0, "foldcolumn"),
    "info",
    { title = "Window Option Toggled:" }
  )
end

-- toggle search crosshairs
function M.toggle_crosshairs()
  local current_win = vim.api.nvim_get_current_win()
  vim.api.nvim_set_option("hlsearch", not vim.api.nvim_get_option "hlsearch")
  vim.cmd [[windo :lua vim.api.nvim_win_set_option(0, 'cursorline', vim.api.nvim_get_option 'hlsearch')
]]
  vim.cmd [[windo :lua vim.api.nvim_win_set_option(0, 'cursorcolumn', vim.api.nvim_get_option 'hlsearch')
]]
  vim.api.nvim_set_current_win(current_win)
end

return M
