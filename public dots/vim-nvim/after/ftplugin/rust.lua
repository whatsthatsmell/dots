vim.api.nvim_exec(
  [[
setlocal shortmess+=c
" treesitter folding
setlocal foldmethod=expr
setlocal foldexpr=nvim_treesitter#foldexpr()
setlocal foldnestmax=3
setlocal foldlevel=1

"Signs
sign define DiagnosticSignHint text=ⓗ  texthl=DiagnosticSignHint linehl= numhl=
sign define DiagnosticSignWarning text= texthl=DiagnosticSignWarning linehl= numhl=
sign define DiagnosticSignError text=! texthl=DiagnosticSignError linehl= numhl=
" my snippets
iabbrev <buffer> w18 #![warn(rust_2018_idioms)]
" this is pd and ppd with rust-analyzer Magic Completions
" iabbrev <buffer> epl  eprintln!("{:#?}",);<left><left>
iabbrev <buffer> pln  println!("{}", );<left><left>
" -- testing
iabbrev <buffer> #t #[test]<c-o>o<left>
iabbrev <buffer> #p #[should_panic(expected = "")]<left><left><left>
iabbrev <buffer> #b #[bench]<c-o>o<left>
iabbrev <buffer> #i #[ignore]<c-o>o<left>

" snippets for Rust - TODO: change autoselect next completion?
let b:vsnip_snippet_dir = expand('~/.config/nvim/snippets/')
" -- end snippets
let g:completion_enable_auto_paren = 1
" open the braces ***
" inoremap <buffer> {<cr> {<cr>}<c-o><s-o>
" wrap selection in Some(*)
vmap ,sm cSome(<c-r>"<esc>
" grep for functions and move function sig to top of window
nnoremap <silent><buffer>,f :Rg<Space>fn<Space><CR>
" surround (W)ord with angle brackets
nmap <localleader>ab ysiW>
" mappings share these across languages
nnoremap <silent><buffer> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
" moving back and forth between declaration and impls
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
	" Also use :Telescope lsp_implementations
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent><localleader>=  <cmd>lua vim.lsp.buf.formatting()<CR>
" Goto previous/next diagnostic warning/error
nnoremap <silent> g[ <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> g] <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
" lua vim.api.nvim_buf_set_option(0, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

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
      opts = {
        get_bufnrs = function()
          return vim.api.nvim_list_bufs()
        end,
      },
    },
    { name = "path" },
  },
}

-- ** Letting rust-tools handle the below:
-- Get error at first to to RA loading and: https://github.com/neovim/neovim/pull/15926
-- @TODOUA: 11-Oct-2021 ← revist
-- Enable type inlay hints
-- vim.api.nvim_exec(
--   [[
-- augroup RustInlayHints
--   autocmd!
--   autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost * :lua require'lsp_extensions'.inlay_hints{ prefix = '=>', highlight = "Comment", enabled = {"TypeHint", "ChainingHint", "ParameterHint"} }
-- augroup end
-- ]],
--   false
-- )
