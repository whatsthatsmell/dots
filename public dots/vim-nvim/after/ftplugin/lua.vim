setlocal textwidth=120
setlocal shiftwidth=2
setlocal colorcolumn=121
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
autocmd CursorHold * silent! lua vim.diagnostic.show_line_diagnostics({focusable = false})

" Goto previous/next diagnostic warning/error
nnoremap <silent> g[ <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> g] <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=
sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=
sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=
" @TODUA: use stylua in projects like telescope etc.
" format with https://github.com/andrejlevkovitch/vim-lua-format
" @TODUA: make silent and remove plugin
" nnoremap <buffer><leader>f :call LuaFormat()<cr>
" nmap <buffer><leader>f <Plug>(ale_fix)
" let g:ale_disable_lsp = 1
" let g:ale_completion_enabled = 0
" let g:ale_fixers = {
" \   '*': ['remove_trailing_lines', 'trim_whitespace'],
" \   'lua': ['stylua']
" \}
