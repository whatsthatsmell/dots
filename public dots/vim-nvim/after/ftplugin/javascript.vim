setlocal linebreak
setlocal exrc
" call matchadd('ColorColumn', '\%81v', 100)
set colorcolumn=81

let g:CheatSheetFrameworks = {
                \ 'javascript' : ['node'],
                \}

" Cheatsheet do cheat Buffer with K
nnoremap <script> <silent> <localleader>K
			\ :call cheat#cheat("", getcurpos()[1], getcurpos()[1], 0, 0, '!')<CR>
vnoremap <script> <silent> <localleader>K
			\ :call cheat#cheat("", -1, -1, 2, 0, '!')<CR>


" ale settings
" below for use if I get nvim lsp working how I need it to
" let b:ale_completion_enabled = 0
" let g:ale_disable_lsp = 1

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\  'javascript': glob('.eslintrc*', '.;') != '' ? [ 'eslint' ] : [ 'standard' ],
\   'yaml': ['prettier'],
\   'json': ['jq'],
\}

let g:ale_linters = {
\  'javascript': glob('.eslintrc*', '.;') != '' ? [ 'eslint', 'tsserver' ] : [ 'standard', 'tsserver' ],
\}

" ale maps
nmap <buffer><silent><localleader>n <Plug>(ale_next_wrap)
nmap <buffer><silent><localleader>p <Plug>(ale_previous_wrap)

" vim-javascript
let g:javascript_plugin_jsdoc = 1

" sync syntax on large-ish file
nmap <silent><localleader>st :syntax sync fromstart<cr>
" retab - fix existing after expandtab
nmap <silent>,rt :retab<cr>
" execute visual selection in node REPL
vmap <silent><localleader>1 :w !node -p<cr>
" wrap selection in JSON.stringify(*)
vmap ,js cJSON.stringify(<c-r>"<esc>
" wrap selection in console.log
vmap ,cl cconsole.log(<c-r>"<esc>
