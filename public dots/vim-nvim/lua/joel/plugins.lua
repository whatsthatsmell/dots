-- allows `hererocks` to install on Mac
-- https://github.com/wbthomason/packer.nvim/issues/180#issuecomment-871634199
-- Still some weirdness that needs further testing around rock installs (which, env, version)
-- vim.fn.setenv("MACOSX_DEPLOYMENT_TARGET", "10.15")
-- Plugins via Packer
return require("packer").startup {
  function(use, use_rocks)
    use "editorconfig/editorconfig-vim"
    use "tpope/vim-surround"
    use "tpope/vim-fugitive"
    use "tpope/vim-repeat"
    use "antoinemadec/FixCursorHold.nvim"
    use "ellisonleao/glow.nvim"
    use {
      "lewis6991/spellsitter.nvim",
      config = function()
        require("spellsitter").setup()
      end,
    }
    use {
      "numToStr/Comment.nvim",
      config = function()
        require("Comment").setup()
      end,
    }
    use "tpope/vim-eunuch"
    use "tpope/vim-unimpaired"
    use "tpope/vim-abolish"
    use "pbrisbin/vim-mkdir"
    use "vim-test/vim-test"
    use "mbbill/undotree"
    use "ruanyl/coverage.vim"
    use "moll/vim-node"
    use "rust-lang/rust.vim"
    use "wbthomason/packer.nvim"
    use "neovim/nvim-lspconfig"
    -- Telescope plugins
    -- using local telescope branch, see below
    -- use 'nvim-telescope/telescope.nvim'
    use "nvim-telescope/telescope-github.nvim"
    use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }
    use "jvgrootveld/telescope-zoxide"
    use "andymass/vim-matchup"
    use "windwp/nvim-autopairs"
    use "nvim-lua/lsp_extensions.nvim"
    use "p00f/nvim-ts-rainbow"
    use "nvim-lua/popup.nvim"
    use "nvim-lua/lsp-status.nvim"
    use "folke/lua-dev.nvim"
    use "onsails/lspkind-nvim"
    use "ray-x/lsp_signature.nvim"
    use {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
    }
    use "nvim-treesitter/nvim-treesitter-refactor"
    use "nvim-treesitter/playground"
    use "nvim-treesitter/nvim-treesitter-textobjects"
    use "David-Kunz/treesitter-unit"
    use "jose-elias-alvarez/nvim-lsp-ts-utils"
    use "simrat39/rust-tools.nvim"
    use "chrisbra/Colorizer"
    use "nvim-lua/plenary.nvim"
    use "kyazdani42/nvim-web-devicons"
    use "lukas-reineke/indent-blankline.nvim"
    use "rcarriga/nvim-notify"
    use { "iamcco/markdown-preview.nvim", run = "cd app && yarn install" }

    -- nvim-cmp
    use {
      "hrsh7th/nvim-cmp",
      requires = {
        { "hrsh7th/cmp-buffer" },
        { "hrsh7th/cmp-nvim-lsp" },
        { "hrsh7th/cmp-path" },
        { "hrsh7th/cmp-nvim-lua" },
        { "ray-x/cmp-treesitter" },
        { "hrsh7th/nvim-cmp" },
        { "hrsh7th/cmp-vsnip" },
        { "hrsh7th/vim-vsnip" },
        { "Saecki/crates.nvim" },
        { "f3fora/cmp-spell" },
        -- { "hrsh7th/cmp-cmdline" },
        { "tamago324/cmp-zsh" },
      },
      config = function()
        require "joel.completion"
      end,
    }

    use {
      "~/vim-dev/plugins/galaxyline.nvim",
      -- branch = "main",
      config = function()
        require "joel.statusline"
      end,
      requires = { "kyazdani42/nvim-web-devicons" },
    }
    -- use '~/vim-dev/plugins/fzf-gh.vim'

    use {
      "lewis6991/gitsigns.nvim",
      requires = { "nvim-lua/plenary.nvim" },
    }

    -- load repos
    use "cljoly/telescope-repo.nvim"

    -- Local plugins
    use "~/vim-dev/plugins/codesmell_dark.vim"
    use "~/vim-dev/plugins/telescope.nvim"
    -- local - updated to support worktrees
    -- loading the plugin, the author fixed the worktree issue
    -- use "~/vim-dev/plugins/telescope-repo.nvim"

    -- Lua Rocks 🎸
    -- don't forget env setting at top if uncommenting
    -- use_rocks "rapidjson"
  end,
  config = {
    display = {
      open_fn = require("packer.util").float,
    },
  },
}
