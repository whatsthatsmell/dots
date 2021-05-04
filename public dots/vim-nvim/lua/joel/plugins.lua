return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
	use 'neovim/nvim-lspconfig'
	use 'nvim-telescope/telescope.nvim'
	use 'nvim-telescope/telescope-github.nvim'
  use 'andymass/vim-matchup'
	use 'windwp/nvim-autopairs'
	use 'nvim-lua/lsp_extensions.nvim'
	use 'p00f/nvim-ts-rainbow'
	use 'nvim-lua/popup.nvim'

  use {
    'w0rp/ale',
    ft = {'javascript'},
    cmd = 'ALEEnable',
    config = 'vim.cmd[[ALEEnable]]'
  }

  use {
    'hrsh7th/nvim-compe',
    requires = {{'hrsh7th/vim-vsnip'}},
		config = function() require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = true;
    calc = true;
    vsnip = true;
    nvim_lsp = true;
    nvim_lua = true;
    spell = true;
    tags = true;
    snippets_nvim = true;
    treesitter = true;
  };
}
end
	}

  -- Local plugins
  use '~/vim-dev/plugins/ci_dark.vim'
  use '~/vim-dev/plugins/fzf-gh.vim'

  use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install', cmd = 'MarkdownPreview'}


  use { 'glacambre/firenvim', run = function() vim.fn['firenvim#install'](0) end }

  use {
    'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' },
    config = function() require('gitsigns').setup {
      signs = {
        add          = {hl = 'DiffAdd'   , text = '│', numhl='GitSignsAddNr'},
        change       = {hl = 'DiffChange', text = '│', numhl='GitSignsChangeNr'},
        delete       = {hl = 'DiffDelete', text = '_', numhl='GitSignsDeleteNr'},
        topdelete    = {hl = 'DiffDelete', text = '‾', numhl='GitSignsDeleteNr'},
        changedelete = {hl = 'DiffChange', text = '~', numhl='GitSignsChangeNr'},
      },
		} end
	}


require'lspconfig'.tsserver.setup{}
require'lspconfig'.clangd.setup{}
-- VimL (full circle!)
require'lspconfig'.vimls.setup{}
-- treesitter

-- nvim-autopairs
require('nvim-autopairs').setup()
-- telescope
-- require('joel.telescope')
-- nvim_lsp object
local nvim_lsp = require'lspconfig'

-- setup compe

-- snippet support
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Enable rust_analyzer
nvim_lsp.rust_analyzer.setup({
		capabilities = capabilities,
    on_attach=on_attach,
    settings = {
        ["rust-analyzer"] = {
            cargo = {
                loadOutDirsFromCheck = true
            },
            procMacro = {
                enable = true
           },
        }
    }
})
 
end
)
