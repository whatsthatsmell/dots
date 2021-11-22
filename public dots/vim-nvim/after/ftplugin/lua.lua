vim.opt_local.textwidth = 120
vim.opt_local.shiftwidth = 2
vim.opt_local.colorcolumn = "121"
vim.opt_local.spell = false

-- Show diagnostic float on CursorHold but don't steal cursor
vim.api.nvim_exec(
  [[
  augroup ShowDiagnosticFloat
    autocmd!
    autocmd CursorHold * lua vim.diagnostic.open_float(0, {focusable = false, scope = 'line', source = 'always'})
  augroup end
]],
  false
)

-- LSP buf maps
vim.api.nvim_buf_set_keymap(
  0,
  "n",
  "grn",
  [[<cmd>lua vim.lsp.buf.rename()<CR>
]],
  { noremap = true }
)

vim.api.nvim_buf_set_keymap(
  0,
  "n",
  "<c-]>",
  [[<cmd>lua require'telescope.builtin'.lsp_definitions()<CR>
]],
  { noremap = true, silent = true }
)

vim.api.nvim_buf_set_keymap(
  0,
  "n",
  "gr",
  [[<cmd>lua require'telescope.builtin'.lsp_references()<CR>
]],
  { noremap = true, silent = true }
)

vim.api.nvim_buf_set_keymap(0, "n", "K", [[<cmd>lua vim.lsp.buf.hover()<CR>]], { noremap = true, silent = true })

vim.api.nvim_buf_set_keymap(
  0,
  "n",
  "<c-k>",
  [[<cmd>lua vim.lsp.buf.signature_help()<CR>]],
  { noremap = true, silent = true }
)
vim.api.nvim_buf_set_keymap(
  0,
  "n",
  "gd",
  [[<cmd>lua vim.lsp.buf.type_definition()<CR>]],
  { noremap = true, silent = true }
)

vim.api.nvim_buf_set_keymap(0, "n", "ga", [[<cmd>lua vim.lsp.buf.code_action()<CR>]], {
  noremap = true,
  silent = true,
})

vim.api.nvim_buf_set_keymap(
  0,
  "n",
  "g0",
  [[<cmd>lua vim.lsp.buf.document_symbol()<CR>]],
  { noremap = true, silent = true }
)

vim.api.nvim_buf_set_keymap(
  0,
  "n",
  "gW",
  [[<cmd>lua vim.lsp.buf.workspace_symbol()<CR>]],
  { noremap = true, silent = true }
)

vim.api.nvim_buf_set_keymap(0, "n", "1gD", [[<cmd>lua vim.lsp.buf.definition()<CR>]], {
  noremap = true,
  silent = true,
})

vim.api.nvim_buf_set_keymap(
  0,
  "n",
  "ge",
  [[<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>]],
  { noremap = true, silent = true }
)

-- Goto previous/next diagnostic warning/error
vim.api.nvim_buf_set_keymap(
  0,
  "n",
  "g[",
  [[<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>]],
  { noremap = true, silent = true }
)
vim.api.nvim_buf_set_keymap(
  0,
  "n",
  "g]",
  [[<cmd>lua vim.lsp.diagnostic.goto_next()<CR>]],
  { noremap = true, silent = true }
)
-- end of LSP buf maps

vim.api.nvim_exec(
  [[
setlocal formatoptions-=o
" source the file -
nmap <silent><localleader>1 :luafile%<cr>

" snippets for Lua - TODO: change autoselect next completion?
let b:vsnip_snippet_dir = expand('~/.config/nvim/snippets/')
]],
  false
)

-- define LSP signs
vim.fn.sign_define("DiagnosticSignHint", {
  text = "",
  texthl = "DiagnosticSignHint",
})

vim.fn.sign_define("DiagnosticSignWarn", {
  text = "",
  texthl = "DiagnosticSignWarn",
})

vim.fn.sign_define("DiagnosticSignError", {
  text = "",
  texthl = "DiagnosticSignError",
})

-- HL @TODOUAs
vim.fn.matchadd("Todoua", [[@TODOUA:]])
vim.cmd "hi Todoua guifg=#3791D4"

-- Setup cmp source buffer configuration (nvim-lua source only enables in Lua filetype)
local cmp = require "cmp"
cmp.setup.buffer {
  sources = {
    { name = "nvim_lua" },
    { name = "nvim_lsp" },
    { name = "treesitter" },
    { name = "vsnip" },
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
}
