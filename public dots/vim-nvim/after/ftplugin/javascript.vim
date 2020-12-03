set linebreak
" ale settings
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\  'javascript': glob('.eslintrc*', '.;') != '' ? [ 'eslint' ] : [ 'standard' ],
\   'yaml': ['prettier'],
\   'json': ['jq'],
\}

let g:ale_linters = {
\  'javascript': glob('.eslintrc*', '.;') != '' ? [ 'eslint', 'tsserver' ] : [ 'standard', 'tsserver' ],
\}

" vim-javascript
let g:javascript_plugin_jsdoc = 1

" sync syntax on large-ish file
nmap <silent><localleader>st :syntax sync fromstart<cr>

