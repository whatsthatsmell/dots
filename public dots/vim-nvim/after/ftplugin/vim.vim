" source the file - 
nmap <silent><localleader>1 :so%<cr>
setlocal colorcolumn=
nmap ,ch :ColorHighlight<cr>
nmap ,cc :ColorClear<cr>
autocmd FileType vim lua require'cmp'.setup.buffer {
\   sources = {
\     { name = 'nvim_lsp' },
\     { name = 'treesitter' },
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
