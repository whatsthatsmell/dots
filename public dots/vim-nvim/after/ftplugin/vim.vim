" source the file - 
nmap <silent><localleader>1 :so%<cr>
setlocal colorcolumn=
autocmd FileType vim lua require'cmp'.setup.buffer {
\   sources = {
\     { name = 'nvim_lsp' },
\     { name = 'treesitter' },
\     {
\      name = 'buffer',
\      option = {
\        get_bufnrs = function()
\          return vim.api.nvim_list_bufs()
\        end,
\      },
\    },
\    { name = 'path' },
\   },
\ }
