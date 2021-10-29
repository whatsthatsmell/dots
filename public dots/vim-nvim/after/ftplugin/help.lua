vim.api.nvim_exec(
  [[
" next help tag
nnoremap <silent><buffer> zl :call search('<Bar>[^ <Bar>]\+<Bar>\<Bar>''[A-Za-z0-9_-]\{2,}''')<cr>
" previous help tag
nnoremap <silent><buffer> zh :call search('<Bar>[^ <Bar>]\+<Bar>\<Bar>''[A-Za-z0-9_-]\{2,}''','b')<cr>
" follow tag
nnoremap <buffer> <CR> <C-]>
" back to tag
nnoremap <buffer> <BS> <C-T>
]],
  false
)

-- toggle buflisted for help files
vim.api.nvim_buf_set_keymap(
  0,
  "n",
  "<space>bl",
  ":lua vim.api.nvim_buf_set_option(0, 'buflisted', not vim.api.nvim_buf_get_option(0, 'buflisted'))<CR>",
  { noremap = false, silent = true }
)
