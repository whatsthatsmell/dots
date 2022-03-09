" LSP maps for C
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
" nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent><localleader>f  <cmd>lua vim.lsp.buf.formatting()<CR>

" monofile
" run
nnoremap <buffer><silent><localleader>cr :!./%:r<cr>
" compile
nnoremap <buffer><silent><localleader>cc :make %:r<cr>

" open the braces
" inoremap <buffer> {<cr> {<cr>}<c-o>O<tab>
inoremap <buffer> {<cr> {<cr>}<c-o><s-o>
