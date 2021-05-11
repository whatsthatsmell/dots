function s:open_in_normal_window() abort
  let f = findfile(expand('<cfile>'))
  if !empty(f) && has_key(nvim_win_get_config(win_getid()), 'anchor')
    FloatermHide
    execute 'e ' . f
  endif
endfunction

nnoremap <silent><buffer> gf :call <SID>open_in_normal_window()<CR>
