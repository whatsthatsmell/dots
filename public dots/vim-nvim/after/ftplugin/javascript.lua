vim.opt_local.linebreak = true
vim.opt_local.colorcolumn = "81"
vim.opt_local.spell = false

-- ** Test and coverage related - Jest **
-- these "Ctrl mappings" work well when Caps Lock is mapped to Ctrl
-- Test running keymaps for JavaScript and Jest
-- @TODOUA: I don't always want the `-i`
-- @TODOUA: Figure out what to do with globals in settings → Lua
-- https://github.com/vim-test/vim-test
vim.api.nvim_buf_set_keymap(0, "n", "t<C-n>", ":TestNearest<CR>", { noremap = false, silent = true })
vim.api.nvim_buf_set_keymap(0, "n", "t<C-f>", ":TestFile<CR>", { noremap = false, silent = true })
vim.api.nvim_buf_set_keymap(0, "n", "t<C-s>", ":TestSuite -i<CR>", { noremap = false, silent = true })
vim.api.nvim_buf_set_keymap(0, "n", "t<C-l>", ":TestLast<CR>", { noremap = false, silent = true })
vim.api.nvim_buf_set_keymap(0, "n", "t<C-g>", ":TestVisit<CR>", { noremap = false, silent = true })
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

vim.api.nvim_exec(
  [[
" treesitter folding
setlocal foldmethod=expr
setlocal foldexpr=nvim_treesitter#foldexpr()
setlocal foldnestmax=3
setlocal foldlevel=1

" rainbow color HLs
hi rainbowcol1 guifg=#4B4DA4
hi rainbowcol2 guifg=#C7C84A
hi rainbowcol3 guifg=#8182EB
hi rainbowcol4 guifg=#BCCEA3
hi rainbowcol6 guifg=#1B9C36

" open braces
inoremap <buffer> {<cr> {<cr>}<c-o><s-o>

" snippets for JS - TODO: change autoselect next completion?
let b:vsnip_snippet_dir = expand('~/.config/nvim/snippets/javascript/')

" retab - fix existing after expandtab
nmap <silent>,rt :retab<cr>
" execute visual selection in node REPL
vmap <silent><localleader>1 :w !node -p<cr>
" wrap selection in JSON.stringify(*)
vmap ,js cJSON.stringify(<c-r>"<esc>
" wrap selection in console.log
vmap ,cl cconsole.log(<c-r>"<esc>
]],
  false
)

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
      opts = {
        get_bufnrs = function()
          return vim.api.nvim_list_bufs()
        end,
      },
    },
    { name = "path" },
  },
}
