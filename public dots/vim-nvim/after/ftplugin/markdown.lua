-- markdown ftplugin
vim.opt_local.colorcolumn = "101"
vim.opt.autoindent = true
vim.opt.linebreak = true
-- @TODOUA:
-- spell is not staying local for some reason
-- have to set nospell in other fts that are opened after a markdown
vim.opt_local.spell = true
vim.conceallevel = 2
vim.api.nvim_exec(
  [[
" arrows
iabbrev >> →
iabbrev << ←
iabbrev ^^ ↑
iabbrev VV ↓

" eunuch map
nmap <buffer><silent><localleader>rn :Rename<space>

" snippets for markdown
let b:vsnip_snippet_dir = expand('~/.config/nvim/snippets/')
]],
  false
)

vim.api.nvim_exec(
  [[
augroup PersistMarkdownFolds
  autocmd!
  autocmd BufWinLeave *.md mkview
  autocmd BufWinEnter *.md silent! loadview
augroup end
]],
  false
)

-- match and highlight URLs
-- @TODOUA:
-- -- Pure Luafication(Nvim API)
-- -- Work in @NoSpell
-- -- Peruse the Treesitter MD grammars for future possibilities
-- -- Only using in markdown for now. Don't want this in theme (for now)
-- -- -- Although, it leaks out to buffers opened after the MD file(Kind of like it for now)
vim.api.nvim_exec(
  [[
match matchURL /http[s]\?:\/\/[[:alnum:]%\/_#.-]*/

hi matchURL guifg=Blue
]],
  false
)

-- add current line as task to todoist - markdown files only (for now)
vim.api.nvim_buf_set_keymap(
  0,
  "n",
  "<localleader>t",
  [[<Cmd>lua require'joel.funcs'.create_todoist_task()<CR>]],
  { noremap = false }
)

-- Setup cmp setup buffer configuration - 👻 text off for markdown
local cmp = require "cmp"
cmp.setup.buffer {
  sources = {
    { name = "vsnip" },
    { name = "spell" },
    {
      name = "buffer",
      opts = {
        get_bufnrs = function()
          return vim.api.nvim_list_bufs()
        end,
      },
    },
    { name = "path" },
  },
  experimental = {
    ghost_text = false,
  },
}
