-- Neovim Settings - Lua
-- auto exit insert mode
vim.api.nvim_exec(
  [[
  augroup AutoExitInsertMode
    autocmd!
    autocmd CursorHoldI * stopinsert
  augroup end
]],
  false
)

-- set markdown FTs
vim.api.nvim_exec(
  [[
  augroup SetMarkdownFt
    autocmd!
    autocmd BufNewFile,BufRead *.markdown,*.mdown,*.mkd,*.mkdn,*.mdwn,*.md,*.MD  set ft=markdown
  augroup end
]],
  false
)

-- Highlight on yank
vim.api.nvim_exec(
  [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]],
  false
)

-- @TODOUA: Break these commands out into nvim_exec blocks
vim.cmd [[
" header files should treated like .c files
autocmd BufRead,BufNewFile *.h set filetype=c

" turn on cursorline, cursorcolumn when searching, sync with hlsearch
augroup nvim-incsearch-cursorline
	autocmd!
	autocmd CmdlineEnter /,\? :set cursorline cursorcolumn hlsearch
augroup END

" Options in VimL form
set termguicolors
" syntax highlight only to 1K instead of default 3K
set synmaxcol=1000

let &packpath=&runtimepath
set completeopt=menu,menuone,preview,noselect,noinsert
set dictionary+=/usr/share/dict/words
set wildignore+=*/node_modules/*,*/coverage/*
set guicursor=
set clipboard=unnamedplus
set updatetime=2000
set undodir=~/.config/nvim/undodir
set undofile
set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
set grepformat=%f:%l:%c:%m,%f:%l:%m

]]

-- Trial DAP maps
-- vim.cmd [[nnoremap <silent> <leader>dr :lua require'dap'.continue()<CR>]]
-- vim.cmd [[nnoremap <leader>ds :lua require'dap'.stop()<CR>]]
-- vim.cmd [[nnoremap <leader>da :lua require'joel.debugHelper'.attach()<CR>]]
-- vim.cmd [[nnoremap <leader>dg :lua require'joel.debugHelper'.debugGql()<CR>]]
-- vim.cmd [[nnoremap <silent> <leader>db :lua require'dap'.toggle_breakpoint()<CR>]]
-- vim.cmd [[nnoremap <silent> <space>dh :lua require('dap.ui.variables').hover()<CR>]]

-- THEME stuff
vim.cmd "set fillchars+=vert:│"
vim.cmd "colorscheme codesmell_dark"

vim.cmd "set spellfile=~/.config/nvim/spell/en.utf-8.add"
vim.cmd "filetype plugin indent on"

-- Options/Settings **
-- Window scope
vim.wo.number = true
vim.wo.relativenumber = true

-- Global scope
vim.o.inccommand = "split"
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.scrolloff = 1
vim.o.hidden = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.showcmd = false

-- Buffer scope
vim.bo.tabstop = 2
vim.bo.shiftwidth = 2

-- Global Vim vars that are on a solo-ish mission **
-- vim.g.fzf_gh_website = 1
vim.g.matchup_matchparen_deferred = 1
-- * Colorizer *
-- auto color fts
vim.g.colorizer_auto_filetype = "yaml,zsh,zsh-theme,lua,vim,json"
-- keep colorizing on bufleave
vim.g.colorizer_disable_bufleave = 1
-- indent-blankline settings
vim.opt.list = false
vim.opt.listchars:append "space:⋅"
vim.opt.listchars:append "eol:↴"
vim.opt.listchars:append "trail:"
-- @TODOUA: make indent lines lighter
require("indent_blankline").setup {
  show_end_of_line = true,
  space_char_blankline = " ",
  buftype_exclude = { "terminal", "help", "telescope" },
  show_current_context = true,
  use_treesitter = true,
  enabled = false,
}

-- Oww, we need the func, we gotta have that func
local M = {}
local toBool = {
  ["1"] = true,
  ["0"] = false,
}
-- Note: `foldcolumn` is not a boolean. You can set other values.
-- I only want to toggle between these two values though.
-- There's probably a better way.
-- @TODOUA: 🐍 case
function M.toggle_fold_col()
  if toBool[vim.opt.foldcolumn:get()] then
    vim.opt.foldcolumn = "0"
  else
    vim.opt.foldcolumn = "1"
  end
  vim.api.nvim_echo({ { "foldcolumn is set to " .. vim.opt.foldcolumn:get() } }, false, {})
end

-- not a 'setting' - need a new module
-- open URI under cursor
function M.open_uri()
  local Job = require "plenary.job"
  local uri = vim.fn.expand "<cWORD>"
  local j = Job
    :new({
      "open",
      uri,
    })
    :sync()
end
return M
