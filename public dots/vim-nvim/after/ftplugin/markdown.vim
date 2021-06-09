set colorcolumn=101
setlocal spell
" setlocal textwidth=100
" call matchadd('ColorColumn', '\%101v', 100)
set autoindent
set linebreak
set conceallevel=2
" arrows
iabbrev >> →
iabbrev << ←
iabbrev ^^ ↑
iabbrev VV ↓

" eunuch map
nmap <buffer><silent><localleader>rn :Rename<space>

" add selected as todoist text
nmap <buffer><localleader>1 :!todoist add "" -N ""<left><left><left><left><left><left><left>


