-- rustc 1.60.0-nightly (5e57faa78 2022-01-19)
-- rust-analyzer df5340386 2022-01-20 dev

-- treesitter folding
vim.opt_local.foldmethod = "expr"
vim.opt_local.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt_local.foldnestmax = 3
vim.opt_local.foldlevel = 1

-- @TODOUA: kill or refactor this exec block
vim.api.nvim_exec(
  [[
setlocal shortmess+=c
" wrap selection in Some(*)
vmap ,sm cSome(<c-r>"<esc>
" grep for functions and move function sig to top of window
nnoremap <silent><buffer>,f :Rg<Space>fn<Space><CR>
" surround (W)ord with angle brackets
nmap <localleader>ab ysiW>

" rustfmt/vim-rust settings
let g:rustfmt_autosave = 1

" local mappings
noremap <silent><localleader>cb :Cbuild<cr>
noremap <silent><localleader>cc :Ccheck<cr>
noremap <silent><localleader>ct :Ctest<cr>
noremap <silent><localleader>cr :Crun<cr>

]],
  false
)

-- snippets dir- vsnip. Need to try LuaSnip
vim.b.vsnip_snippet_dir = vim.fn.expand "~/.config/nvim/snippets/"

-- rust-tools -- REMOVED FOR NOW: https://github.com/simrat39/rust-tools.nvim
-- Command:
-- RustRunnables
-- vim.api.nvim_buf_set_keymap(
--   0,
--   "n",
--   "<space>rr",
--   [[<cmd>lua require('rust-tools.runnables').runnables()<cr>
-- ]],
--   { noremap = true, silent = true }
-- )

-- @TODOUA: check to see if rust-tools selects is handling close (nil)
-- Meantime, close runnable & debuggable pickers manually :close!

-- LSP maps
-- turn on inlay_hints → only Chaining hints work as of now 14-Jan-2022
-- Bringing back rust-tools ASAP
vim.api.nvim_buf_set_keymap(
  0,
  "n",
  ",ih",
  [[<cmd>lua require'lsp_extensions'.inlay_hints{ prefix = ' ', highlight = 'Comment', enabled = {"TypeHint", "ChainingHint", "ParameterHint"} }
<CR>
]],
  { noremap = true, silent = true }
)

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

-- Show diagnostic popup on cursor hold
vim.api.nvim_exec(
  [[
augroup RustLineDiagnostics
   autocmd!
   autocmd CursorHold * lua vim.diagnostic.open_float(0, {focusable = false, scope = 'line'})
augroup end
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
        get_bufnrs = function()
          return vim.api.nvim_list_bufs()
        end,
      },
    },
    { name = "path" },
  },
}

vim.api.nvim_exec(
  [[
" rainbow color HLs
hi rainbowcol1 guifg=#91D2A3
hi rainbowcol2 guifg=#3791D4
hi rainbowcol3 guifg=#8182EB
hi rainbowcol4 guifg=#BCCEA3
hi rainbowcol6 guifg=#1B9C36
]],
  false
)

-- @TODOUA: bring back rust-tools once it catches up with upstream changes
-- Enable type inlay hints
-- Not executing on Buf*Enter because they are not ready then. CursorMoved is fine for now.
-- vim.api.nvim_exec(
--   [[
-- augroup RustInlayHints
--   autocmd!
--   autocmd CursorMoved,InsertLeave,BufWritePost * :lua require'lsp_extensions'.inlay_hints{ prefix = '=>', highlight = "Comment", enabled = {"TypeHint", "ChainingHint", "ParameterHint"} }
-- augroup end
-- ]],
--   false
-- )
