-- copilot enabled explicitly for JS
-- vim.b.copilot_enabled = true
-- require "notify"(
--   "Copilot enabled for JavaScript. :copilot disable/enable. <C-j> to Accept().",
--   "info",
--   { title = "Copilot " }
-- )

-- typescript-language-server: 0.11.2
vim.opt_local.linebreak = true
vim.opt_local.colorcolumn = "81"
vim.opt_local.spell = false

-- treesitter Folding
vim.opt_local.foldmethod = "expr"
vim.opt_local.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt_local.foldnestmax = 3
vim.opt_local.foldlevel = 1

-- ** Key Maps ** --
-- *** Test related - 🤡 Jest **
-- You can set these globally or per ftp. Only using for JS for now. 17-Feb-2022
-- these "Ctrl mappings" work well when Caps Lock is mapped to Ctrl
-- Test running keymaps for JavaScript and Jest
-- @TODOUA: I want -i like with vim-test for Jest on some projects
-- @TODOUA: Figure out what to do with globals in settings → Lua
-- Trying https://github.com/klen/nvim-test - was https://github.com/vim-test/vim-test
vim.api.nvim_buf_set_keymap(0, "n", "t<C-n>", ":TestNearest<CR>", { noremap = false, silent = true })
vim.api.nvim_buf_set_keymap(0, "n", "t<C-f>", ":TestFile<CR>", { noremap = false, silent = true })
vim.api.nvim_buf_set_keymap(0, "n", "t<C-s>", ":TestSuite<CR>", { noremap = false, silent = true })
vim.api.nvim_buf_set_keymap(0, "n", "t<C-l>", ":TestLast<CR>", { noremap = false, silent = true })
-- vim.api.nvim_buf_set_keymap(0, "n", "t<C-g>", ":TestVisit<CR>", { noremap = false, silent = true })
-- End of Test stuff

-- LSP buf maps
-- -- go to impl - not all LSPs implement this
vim.api.nvim_buf_set_keymap(
  0,
  "n",
  "gD",
  "<cmd>lua vim.lsp.buf.implementation()<CR>",
  { noremap = true, silent = true }
)

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
  "<localleader>f",
  [[<cmd>lua vim.lsp.buf.formatting()<CR>
]],
  { noremap = true, silent = true }
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

-- @TODOUA: debug this. Wonky inconsistent behavior
-- Better off just grepping for <cword> for now: <leader>g on cursor word
vim.api.nvim_buf_set_keymap(
  0,
  "n",
  "gW",
  [[<cmd>lua require'telescope.builtin'.lsp_workspace_symbols({query=vim.fn.expand('<cword>')})<CR>]],
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
-- end of LSP buf maps

-- execute visual selection in node REPL
vim.api.nvim_buf_set_keymap(0, "v", "<localleader>1", ":w !node -p<cr>", { noremap = false, silent = true })

-- wrap selection in JSON.stringify(*)
vim.api.nvim_buf_set_keymap(0, "v", ",js", [[cJSON.stringify(<c-r>"<esc>>]], { noremap = false })

-- wrap selection in console.log
vim.api.nvim_buf_set_keymap(0, "v", ",cl", [[cconsole.log(<c-r>"<esc>]], { noremap = false })

-- end of key maps

-- snippets dir- vsnip. Need to try LuaSnip
vim.b.vsnip_snippet_dir = vim.fn.expand "~/.config/nvim/snippets/javascript/"

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

vim.api.nvim_exec(
  [[
" rainbow color HLs
hi rainbowcol1 guifg=#4B4DA4
hi rainbowcol2 guifg=#C7C84A
hi rainbowcol3 guifg=#8182EB
hi rainbowcol4 guifg=#BCCEA3
hi rainbowcol6 guifg=#1B9C36
]],
  false
)

-- Show diagnostic float on CursorHold
vim.api.nvim_create_augroup("JSLineDiagnostics", {})
vim.api.nvim_create_autocmd(
  "CursorHold",
  { command = "lua vim.diagnostic.open_float(0, {focusable = false, scope = 'line'})", group = "JSLineDiagnostics" }
)

vim.api.nvim_exec(
  [[
match matchDebug /\.debug/

hi matchDebug guifg=Red
]],
  false
)

-- Setup cmp source buffer configuration
local cmp = require "cmp"
cmp.setup.buffer {
  sources = {
    { name = "nvim_lsp" },
    { name = "treesitter" },
    { name = "vsnip" },
    {
      name = "buffer",
      option = {
        get_bufnrs = function() return vim.api.nvim_list_bufs() end,
      },
    },
    { name = "path" },
  },
}
