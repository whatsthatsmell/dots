" Use <silent> so ":call quickfixed#older()" isn't output to the command line
nnoremap <silent> <buffer> <Left> :call quickfixed#older()<CR>
nnoremap <silent> <buffer> <Right> :call quickfixed#newer()<CR>
