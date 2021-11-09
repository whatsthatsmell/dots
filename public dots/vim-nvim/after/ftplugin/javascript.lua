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
" lsp mappings and all the goodness

"Signs
sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=
sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=
sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=

" TODO: share these across languages
nnoremap <silent><buffer> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent><buffer> grn   <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> gd   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> gr    <cmd>lua require'telescope.builtin'.lsp_references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> 1gD    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> ge    <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
nnoremap <silent><localleader>f  <cmd>lua vim.lsp.buf.formatting()<CR>
" Goto previous/next diagnostic warning/error
nnoremap <silent> g[ <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> g] <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

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
