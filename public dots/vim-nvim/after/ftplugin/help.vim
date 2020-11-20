" next help tag
nnoremap <silent><buffer> zl
  \ :call search('<Bar>[^ <Bar>]\+<Bar>\<Bar>''[A-Za-z0-9_-]\{2,}''')<cr>
" previous help tag
nnoremap <silent><buffer> zh
 \ :call search('<Bar>[^ <Bar>]\+<Bar>\<Bar>''[A-Za-z0-9_-]\{2,}''','b')<cr>
" follow tag
nnoremap <buffer> <CR> <C-]>
" back to tag
nnoremap <buffer> <BS> <C-T>
