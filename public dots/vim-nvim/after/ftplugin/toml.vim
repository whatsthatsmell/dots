autocmd FileType toml lua require('cmp').setup.buffer { sources = { { name = 'crates' } } }
