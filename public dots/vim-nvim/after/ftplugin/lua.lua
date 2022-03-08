-- sumneko/lua-language-server 2.5.1+
vim.opt_local.textwidth = 120
vim.opt_local.shiftwidth = 2
vim.opt_local.colorcolumn = "121"
vim.opt_local.spell = false
vim.opt_local.formatoptions = "jcrql"

-- Show diagnostic float on CursorHold
vim.api.nvim_create_augroup("LuaLineDiagnostics", {})
vim.api.nvim_create_autocmd("CursorHold", {
  command = "lua vim.diagnostic.open_float(0, {focusable = false, scope = 'line', source = 'always'})",
  group = "LuaLineDiagnostics",
})

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

-- Other maps
-- Source the file
vim.api.nvim_buf_set_keymap(0, "n", "<localleader>1", [[<cmd>luafile%<CR>]], { noremap = false, silent = true })

-- snippets dir- vsnip. Need to try LuaSnip
vim.b.vsnip_snippet_dir = vim.fn.expand "~/.config/nvim/snippets/"

-- define LSP signs
vim.fn.sign_define("DiagnosticSignError", {
  text = "",
  texthl = "DiagnosticSignError",
})

vim.fn.sign_define("DiagnosticSignWarn", {
  text = "",
  texthl = "DiagnosticSignWarn",
})

vim.fn.sign_define("DiagnosticSignHint", {
  text = "",
  texthl = "DiagnosticSignHint",
})

vim.fn.sign_define("DiagnosticSignInfo", {
  text = "",
  texthl = "DiagnosticSignInfo",
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
      option = {
        get_bufnrs = function()
          return vim.api.nvim_list_bufs()
        end,
      },
    },
    { name = "path" },
  },
}
