-- markdown ftplugin
vim.opt_local.colorcolumn = "101"
vim.opt.autoindent = true
vim.opt.linebreak = true
-- @TODOUA:
-- spell is not staying local for some reason
-- have to set nospell in other fts that are opened after a markdown
vim.opt_local.spell = true
vim.opt_local.conceallevel = 2

-- *markdown surround maps - with nvim-surround and without*
-- wrap selection in markdown link
vim.api.nvim_buf_set_keymap(0, "v", ",wl", [[c[<c-r>"]()<esc>]], { noremap = false })

-- italicize Word - in visual: S{arg}
vim.api.nvim_buf_set_keymap(0, "n", "<leader>_", "ysiW_", { noremap = false })

-- Markdown Preview
-- For Glow, just type :Glow
vim.api.nvim_buf_set_keymap(0, "n", ",md", "<Plug>MarkdownPreview", { noremap = false })

-- toggle TS highlighting for markdown
vim.api.nvim_buf_set_keymap(0, "n", ",th", ":TSBufToggle highlight<CR>", { noremap = false })

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

-- Persist Markdown Folds
vim.api.nvim_create_augroup("PersistMarkdownFolds", {})
vim.api.nvim_create_autocmd("BufWinLeave", { command = "mkview", pattern = "*.md", group = "PersistMarkdownFolds" })
vim.api.nvim_create_autocmd(
  "BufWinEnter",
  { command = "silent! loadview", pattern = "*.md", group = "PersistMarkdownFolds" }
)

-- match and highlight hyperlinks
-- -- standalone
vim.fn.matchadd("matchURL", [[http[s]\?:\/\/[[:alnum:]%\/_#.-]*]])
vim.cmd "hi matchURL guifg=DodgerBlue"

-- grey out for strikethrough
vim.fn.matchadd("matchStrike", [[[~]\{2}.\+[~]\{2}]])
vim.cmd "hi matchStrike guifg=gray"

-- Setup cmp setup buffer configuration - 👻 text off for markdown
local cmp = require "cmp"
cmp.setup.buffer {
  sources = {
    { name = "vsnip" },
    { name = "spell" },
    {
      name = "buffer",
      option = {
        get_bufnrs = function()
          -- @TODOUA: Trying out just populate from visible buffers. Keep?
          local bufs = {}
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            bufs[vim.api.nvim_win_get_buf(win)] = true
          end
          return vim.tbl_keys(bufs)
        end,
      },
    },
    { name = "path" },
  },
  experimental = {
    ghost_text = false,
  },
}
