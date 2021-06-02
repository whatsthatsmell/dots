" source the file - 
nmap <silent><localleader>1 :luafile%<cr>
" format with https://github.com/andrejlevkovitch/vim-lua-format
nnoremap <buffer><leader>f :call LuaFormat()<cr>
