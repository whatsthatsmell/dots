setlocal linebreak
setlocal exrc
set colorcolumn=81
" treesitter folding
setlocal foldmethod=expr
setlocal foldexpr=nvim_treesitter#foldexpr()
setlocal foldnestmax=3
setlocal foldlevel=2
" setlocal omnifunc=v:lua.vim.lsp.omnifunc
" ale settings
let g:ale_completion_enabled = 0
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\  'javascript': glob('.eslintrc*', '.;') != '' ? [ 'eslint' ] : [ 'standard' ],
\   'yaml': ['prettier'],
\   'json': ['jq'],
\}

let g:ale_linters = {
\  'javascript': glob('.eslintrc*', '.;') != '' ? [ 'eslint', 'tsserver' ] : [ 'standard', 'tsserver' ],
\}

hi rainbowcol1 guifg=#4B4DA4
hi rainbowcol2 guifg=#C7C84A
hi rainbowcol3 guifg=#8182EB
hi rainbowcol4 guifg=#BCCEA3
hi rainbowcol6 guifg=#1B9C36

" this stopped working via compe/nvim-autopairs. So, it's back
inoremap <buffer> {<cr> {<cr>}<c-o><s-o>
" lsp mappings and all the goodness
" Enable type inlay hints
autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *
\ lua require'lsp_extensions'.inlay_hints{ prefix = '', highlight = "Comment", enabled = {"TypeHint", "ChainingHint", "ParameterHint"} }
" Show diagnostic popup on cursor hold
autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()
" show signature help on cursor holder (insert)
" autocmd CursorHoldI * silent! lua vim.lsp.buf.signature_help()
sign define LspDiagnosticsSignHint text= texthl=LspDiagnosticsSignHint linehl= numhl=
sign define LspDiagnosticsSignWarn text= texthl=LspDiagnosticsSignWarn linehl= numhl=
sign define LspDiagnosticsSignError text= texthl=LspDiagnosticsSignError linehl= numhl=
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
nnoremap <silent> ge    <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
nnoremap <silent><localleader>=  <cmd>lua vim.lsp.buf.formatting()<CR>
" Goto previous/next diagnostic warning/error
nnoremap <silent> g[ <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> g] <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

" ale maps etc.
" @TODO: finish killing ALE
nmap <buffer><silent><localleader>n <Plug>(ale_next_wrap)
nmap <buffer><silent><localleader>p <Plug>(ale_previous_wrap)
highlight clear ALEErrorSign
highlight clear ALEWarningSign
let g:ale_sign_error = ""
let g:ale_sign_warning = ""
nmap <buffer><leader>f <Plug>(ale_fix)
" nmap <buffer><silent> <leader>d <Plug>(ale_go_to_definition)
" nnoremap <buffer><silent> <leader>r :ALEFindReferences -relative<Return>
nnoremap <buffer><silent> <leader>rn :ALERename<Return>
let g:ale_completion_enabled = 0
let g:ale_completion_autoimport = 1

" abbreviations - see maps below for wrapping with these
inoreabbrev Ccl console.log()<Left><Left><Esc>
inoreabbrev Cclj console.log(JSON.stringify())<Left><Left><left><Esc>

" sync syntax on large-ish file
nmap <silent><localleader>st :syntax sync fromstart<cr>
" retab - fix existing after expandtab
nmap <silent>,rt :retab<cr>
" execute visual selection in node REPL
vmap <silent><localleader>1 :w !node -p<cr>
" wrap selection in JSON.stringify(*)
vmap ,js cJSON.stringify(<c-r>"<esc>
" wrap selection in console.log
vmap ,cl cconsole.log(<c-r>"<esc>
