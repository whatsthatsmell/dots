setlocal textwidth=120
setlocal shiftwidth=2
setlocal colorcolumn=121
setlocal formatoptions-=o
" source the file - 
nmap <silent><localleader>1 :luafile%<cr>
highlight clear ALEErrorSign
highlight clear ALEWarningSign
let g:ale_sign_error = ""
let g:ale_sign_warning = ""
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
