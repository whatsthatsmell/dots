setlocal shortmess+=c
" treesitter folding
setlocal foldmethod=expr
setlocal foldexpr=nvim_treesitter#foldexpr()
" Enable type inlay hints
autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *
\ lua require'lsp_extensions'.inlay_hints{ prefix = '', highlight = "Comment", enabled = {"TypeHint", "ChainingHint", "ParameterHint"} }
" Show diagnostic popup on cursor hold
autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics({focusable = false})
sign define LspDiagnosticsSignHint text=ⓗ texthl=LspDiagnosticsSignHint linehl= numhl=
sign define LspDiagnosticsSignWarn text=⚠︎ texthl=LspDiagnosticsSignWarn linehl= numhl=
sign define LspDiagnosticsSignError text=! texthl=LspDiagnosticsSignError linehl= numhl=
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
" -- end my snippets
let g:completion_enable_auto_paren = 1
" open the braces ***
" working with nvim-autopairs and compe!
" inoremap <buffer> {<cr> {<cr>}<c-o><s-o>
" wrap selection in Some(*)
vmap ,sm cSome(<c-r>"<esc>
" grep for functions and move function sig to top of window
nnoremap <silent><buffer>,f :Rg<Space>fn<Space><CR>
" surround (W)ord with angle brackets
nmap <localleader>ab ysiW>
" mappings
nnoremap <silent><buffer> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent><localleader>=  <cmd>lua vim.lsp.buf.formatting()<CR>
" Goto previous/next diagnostic warning/error
nnoremap <silent> g[ <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> g] <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
" lua vim.api.nvim_buf_set_option(0, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

" Don't need ALE for Rust anymore but still use some features 
" and mappings out of habit from other languages.
let g:ale_completion_enabled = 0
let g:ale_linters = {
\ 'rust': ['analyzer'],
\}

let g:ale_fixers = {
 \   'rust': ['rustfmt'],
\}

" rustfmt/vim-rust settings
let g:rustfmt_autosave = 1

" local mappings
noremap <silent><localleader>cb :Cbuild<cr>
noremap <silent><localleader>cc :Ccheck<cr>
noremap <silent><localleader>ct :Ctest<cr>
noremap <silent><localleader>cr :Crun<cr>
