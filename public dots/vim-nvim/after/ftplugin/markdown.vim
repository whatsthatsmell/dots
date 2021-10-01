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

augroup PersistMarkdownFolds
	autocmd!
  autocmd BufWinLeave *.md mkview
  autocmd BufWinEnter *.md silent! loadview
augroup end

autocmd FileType markdown lua require'cmp'.setup.buffer {
\   sources = {
\     { name = 'vsnip' },
\     { name = 'spell' },
\     {
\      name = 'buffer',
\      opts = {
\        get_bufnrs = function()
\          return vim.api.nvim_list_bufs()
\        end,
\      },
\    },
\    { name = 'path' },
\   },
\ }

" snippets for markdown - TODO: change autoselect next completion?
let b:vsnip_snippet_dir = expand('~/.config/nvim/snippets/')
