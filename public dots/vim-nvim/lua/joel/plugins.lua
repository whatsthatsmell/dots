-- @TODUA: migrate the rest of legacy plugin config
vim.cmd([[
call plug#begin('~/.vim/plugged')
" Plugins
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-abolish'
Plug 'pbrisbin/vim-mkdir'
Plug 'vim-test/vim-test'
Plug 'mbbill/undotree'
Plug 'ruanyl/coverage.vim'
Plug 'moll/vim-node'
Plug 'rust-lang/rust.vim'
Plug 'junegunn/vim-peekaboo'
Plug 'chrisbra/Colorizer'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
Plug 'voldikss/vim-floaterm'
call plug#end()
]])

return require("packer").startup(function()
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use 'neovim/nvim-lspconfig'
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-telescope/telescope-github.nvim'
    use 'nvim-telescope/telescope-fzy-native.nvim'
    use 'andymass/vim-matchup'
    use 'windwp/nvim-autopairs'
    use 'nvim-lua/lsp_extensions.nvim'
    use 'p00f/nvim-ts-rainbow'
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/lsp-status.nvim'
    use 'folke/lua-dev.nvim'
    use 'andrejlevkovitch/vim-lua-format'
    use 'tamago324/compe-zsh'
    -- trying lsp_signature
    use 'ray-x/lsp_signature.nvim'
    -- trying nvim-spectre
    -- use 'windwp/nvim-spectre' (not yet)
    -- use 'mfussenegger/nvim-dap'

    use {
        'glepnir/galaxyline.nvim',
        branch = 'main',
        config = function() require 'joel.statusline' end,
        requires = {'kyazdani42/nvim-web-devicons'}
    }
    use {
        'w0rp/ale',
        ft = {'javascript'},
        cmd = 'ALEEnable',
        config = 'vim.cmd[[ALEEnable]]'
    }

    -- @TODUA: move to completion.lua
    use {
        'hrsh7th/nvim-compe',
        requires = {{'hrsh7th/vim-vsnip'}},
        config = function()
            require'compe'.setup {
                enabled = true,
                autocomplete = true,
                debug = false,
                min_length = 1,
                preselect = 'enable',
                throttle_time = 80,
                source_timeout = 200,
                incomplete_delay = 400,
                max_abbr_width = 100,
                max_kind_width = 100,
                max_menu_width = 100,
                documentation = true,
                source = {
                    buffer = true,
                    calc = true,
                    nvim_lsp = true,
                    nvim_lua = true,
                    path = true,
                    snippets_nvim = true,
                    spell = true,
                    tags = true,
                    treesitter = true,
                    vsnip = true,
                    zsh = true
                }
            }
        end
    }

    -- Local plugins
    use '~/vim-dev/plugins/codesmell_dark.vim'
    use '~/vim-dev/plugins/fzf-gh.vim'

    -- some setups
    use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install'}

    use {
        'lewis6991/gitsigns.nvim',
        requires = {'nvim-lua/plenary.nvim'},
        config = function()
            require('gitsigns').setup {
                signs = {
                    add = {
                        hl = 'DiffAdd',
                        text = '│',
                        numhl = 'GitSignsAddNr'
                    },
                    change = {
                        hl = 'DiffChange',
                        text = '│',
                        numhl = 'GitSignsChangeNr'
                    },
                    delete = {
                        hl = 'DiffDelete',
                        text = '_',
                        numhl = 'GitSignsDeleteNr'
                    },
                    topdelete = {
                        hl = 'DiffDelete',
                        text = '‾',
                        numhl = 'GitSignsDeleteNr'
                    },
                    changedelete = {
                        hl = 'DiffChange',
                        text = '~',
                        numhl = 'GitSignsChangeNr'
                    }
                }
            }
        end
    }

    require'nvim-web-devicons'.setup {
        override = {zsh = {icon = '', color = '#428850', name = 'Zsh'}},
        default = true
    }

    -- search/replace visual b/c inccommand preview doesn't show all (PRs in flight on Neovim)
    -- require('spectre').setup()

    require'lspconfig'.tsserver.setup({
        on_attach = function()
            -- signature completion - not in scope for compe
            require'lsp_signature'.on_attach({
                bind = true, -- This is mandatory, otherwise border config won't get registered.
                -- If you want to hook lspsaga or other signature handler, pls set to false
                doc_lines = 2, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
                -- set to 0 if you DO NOT want any API comments be shown
                -- This setting only take effect in insert mode, it does not affect signature help in normal
                -- mode, 10 by default

                floating_window = true, -- show hint in a floating window, set to false for virtual text only mode
                hint_enable = true, -- virtual hint enable
                hint_prefix = "🌟 ", -- Panda for parameter
                hint_scheme = "String",
                use_lspsaga = false, -- set to true if you want to use lspsaga popup
                hi_parameter = "Search", -- how your parameter will be highlight
                max_height = 12, -- max height of signature floating_window, if content is more than max_height, you can scroll down
                -- to view the hiding contents
                max_width = 120, -- max_width of signature floating_window, line will be wrapped if exceed max_width
                handler_opts = {
                    border = "single" -- double, single, shadow, none
                },
                extra_trigger_chars = {} -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
            })
        end
    })
    require'lspconfig'.graphql.setup {}
    require'lspconfig'.clangd.setup {}
    -- VimL (full circle!)
    require'lspconfig'.vimls.setup {}
    -- nvim-autopairs
    require('nvim-autopairs').setup()
    -- nvim_lsp object
    local nvim_lsp = require 'lspconfig'

    -- snippet support
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    -- Enable rust_analyzer
    nvim_lsp.rust_analyzer.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
            ['rust-analyzer'] = {
                cargo = {loadOutDirsFromCheck = true},
                procMacro = {enable = true}
            }
        }
    })
end)
