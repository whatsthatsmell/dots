vim.opt_local.textwidth = 120
vim.opt_local.shiftwidth = 2
vim.opt_local.colorcolumn = "121"
vim.api.nvim_exec(
  [[

setlocal formatoptions-=o
" source the file - 
nmap <silent><localleader>1 :luafile%<cr>
highlight clear ALEErrorSign
highlight clear ALEWarningSign
let g:ale_sign_error = ""
let g:ale_sign_warning = "裂"
" lsp mappings and all the goodness
" Enable type inlay hints
autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *
\ lua require'lsp_extensions'.inlay_hints{ prefix = '', highlight = "Comment", enabled = {"TypeHint", "ChainingHint", "ParameterHint"} }
" Show diagnostic popup on cursor hold but don't steal cursor
autocmd CursorHold * lua vim.diagnostic.show_line_diagnostics({focusable = false})

" snippets for Lua - TODO: change autoselect next completion?
let b:vsnip_snippet_dir = expand('~/.config/nvim/snippets/')

" Goto previous/next diagnostic warning/error
nnoremap <silent> g[ <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> g] <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
"signs defined
sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=
sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=
sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=
]],
  false
)

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
