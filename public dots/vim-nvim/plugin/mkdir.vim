" https://github.com/pbrisbin/vim-mkdir/blob/master/plugin/mkdir.vim
if exists("g:mkdir_loaded")
  finish
endif

let g:mkdir_loaded = 1

function s:Mkdir()
  let dir = expand('%:p:h')

  if dir =~ '://'
    return
  endif

  if !isdirectory(dir)
    call mkdir(dir, 'p')
    echom 'Created new directory: '.dir
  endif
endfunction

autocmd BufWritePre * call s:Mkdir()
