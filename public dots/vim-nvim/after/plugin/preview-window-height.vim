" Trying to hack previewheight
" set previewheight=15

" au BufEnter ?* call PreviewHeightWorkAround()

" function! PreviewHeightWorkAround()
"   if &previewwindow
"     exec 'setlocal winheight='.&previewheight
"   endif
" endfunction

" augroup PreviewAutocmds
"   autocmd!
"   autocmd WinEnter * if &previewwindow | set nonumber | endif
" augroup END
