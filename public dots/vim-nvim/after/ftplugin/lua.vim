let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'lua': ['luafmt'],
\}
" source the file - 
nmap <silent><localleader>1 :luafile%<cr>
" format with luafmt via ALE
nmap <buffer><leader>f <Plug>(ale_fix)
" enable ALE
:ALEEnable
