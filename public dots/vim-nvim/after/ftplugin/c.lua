-- treesitter folding
vim.opt_local.foldmethod = "expr"
vim.opt_local.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt_local.foldnestmax = 3
vim.opt_local.foldlevel = 1
vim.opt_local.formatoptions = "crqnlj"

-- @TODOUA: refactor this exec block
-- vim.api.nvim_exec(
--   [[
-- setlocal shortmess+=c
-- ]],
--   false
-- )

-- LSP maps
vim.api.nvim_buf_set_keymap(
  0,
  "n",
  "<localleader>=",
  [[<cmd>lua vim.lsp.buf.formatting()<CR>
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
  "gd",
  [[<cmd>lua require'telescope.builtin'.lsp_definitions()<CR>
]],
  { noremap = true, silent = true }
)

vim.api.nvim_buf_set_keymap(
  0,
  "n",
  ",gi",
  [[<cmd>lua require'telescope.builtin'.lsp_implementations()<CR>
]],
  { noremap = true, silent = true }
)

-- @TODOUA: probably kill this map
vim.api.nvim_buf_set_keymap(
  0,
  "n",
  "<c-k>",
  [[<cmd>lua vim.lsp.buf.signature_help()<CR>]],
  { noremap = true, silent = true }
)

vim.api.nvim_buf_set_keymap(0, "n", "ga", [[<cmd>lua vim.lsp.buf.code_action()<CR>]], {
  noremap = true,
  silent = true,
})

vim.api.nvim_buf_set_keymap(
  0,
  "n",
  "<space>ld",
  [[<cmd>lua vim.diagnostic.open_float(0, {focusable = false, scope = 'line'})<CR>]],
  { noremap = true, silent = true }
)

-- Goto previous/next diagnostic warning/error
vim.api.nvim_buf_set_keymap(
  0,
  "n",
  "[d",
  [[<cmd>lua vim.diagnostic.goto_prev()<CR>]],
  { noremap = true, silent = true }
)

vim.api.nvim_buf_set_keymap(
  0,
  "n",
  "]d",
  [[<cmd>lua vim.diagnostic.goto_next()<CR>]],
  { noremap = true, silent = true }
)

-- monofile maps
-- compile
vim.api.nvim_buf_set_keymap(0, "n", "<localleader>cc", [[<cmd>make %:r<CR>]], { noremap = true, silent = true })
-- run
vim.api.nvim_buf_set_keymap(0, "n", "<localleader>cr", [[<cmd>!./%:r<CR>]], { noremap = true, silent = true })

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

-- Show diagnostic popup on CursorHold
vim.api.nvim_create_augroup("CLineDiagnostics", {})
vim.api.nvim_create_autocmd(
  "CursorHold",
  { command = "lua vim.diagnostic.open_float(0, {focusable = false, scope = 'line'})", group = "CLineDiagnostics" }
)
