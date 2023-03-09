-- install packer automatically on new system
-- https://github.com/wbthomason/packer.nvim#bootstrapping
local fn = vim.fn
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
end

-- sync plugins on write/save
vim.api.nvim_create_augroup("SyncPackerPlugins", {})
vim.api.nvim_create_autocmd(
  "BufWritePost",
  { command = "source <afile> | PackerSync", pattern = "plugins.lua", group = "SyncPackerPlugins" }
)

-- Plugins via Packer
return require("packer").startup {
  function(use)
    -- @TODOUA: try https://github.com/tmux-plugins/vim-tmux
    use {
      "ruifm/gitlinker.nvim",
      requires = "nvim-lua/plenary.nvim",
    }
    -- tpope
    -- use "tpope/vim-surround"
    use "tpope/vim-fugitive"
    use "tpope/vim-repeat"
    use "tpope/vim-eunuch"
    use "tpope/vim-unimpaired"
    use "tpope/vim-abolish"
    -- use "vimpostor/vim-tpipeline"
    use "lewis6991/impatient.nvim"
    use "editorconfig/editorconfig-vim"
    -- markdown plugins
    use { "ellisonleao/glow.nvim", config = function() require("glow").setup() end }
    use { "iamcco/markdown-preview.nvim", run = "cd app && yarn install" }
    -- json pathing
    use { "mogelbrod/vim-jsonpath", cmd = "JsonPath" }

    use {
      "luukvbaal/stabilize.nvim",
      config = function() require("stabilize").setup() end,
    }

    use {
      "kylechui/nvim-surround",
      config = function() require("nvim-surround").setup {} end,
    }

    use { "stevearc/dressing.nvim" }

    use {
      "ziontee113/icon-picker.nvim",
      cmd = "PickEverything",
      config = function() require "icon-picker" end,
    }

    use {
      "numToStr/Comment.nvim",
      config = function() require("Comment").setup() end,
    }

    -- use "elihunter173/dirbuf.nvim"
    -- doing mkdir locally
    -- use "pbrisbin/vim-mkdir"
    -- use "vim-test/vim-test"

    -- mongo-nvim - install when needed. Fairly buggy as of 05-May-2022. Great potential.
    -- @TODOUA: Make this an opt plugin
    -- @TODOUA: Setup command maps: https://github.com/thibthib18/mongo-nvim#%EF%B8%8F--config
    -- @TODOUA: Setup proper list_document_key table: https://github.com/thibthib18/mongo-nvim#list_document_key
    -- @TODOUA: Setup making connection_string env var
    -- use {
    --   "thibthib18/mongo-nvim",
    --   rocks = { "lua-mongo" },
    --   config = function()
    --     require("mongo-nvim").setup {
    --       -- connection string to your mongodb
    --       connection_string = "mongodb://127.0.0.1:27017",
    --       -- key to use for previewing/picking documents
    --       -- either a string or custom table of string or functions
    --       list_document_key = "_id",
    --       -- delete selected document in document_picker
    --       delete_document_mapping = nil, -- "<c-d>"
    --     }
    --   end,
    -- }

    use {
      "klen/nvim-test",
      config = function()
        require("nvim-test").setup {
          commands_create = true, -- create commands (TestFile, TestLast, ...)
          silent = false, -- less notifications
          run = true, -- run test commands
          term = "terminal", -- a terminal to run (terminal|toggleterm)
          termOpts = {
            direction = "vertical", -- terminal's direction (horizontal|vertical|float)
            width = 86, -- terminal's width (for vertical|float)
            height = 24, -- terminal's height (for horizontal|float)
            go_back = false, -- return focus to original window after executing
            stopinsert = false, -- exit from insert mode
          },
          runners = { -- setup test runners, only using for JS. Currently, doesn't add value to Rust workflow 17-Feb-2022
            javascript = "nvim-test.runners.jest",
            lua = "nvim-test.runners.busted",
            -- rust = "nvim-test.runners.cargo-test",
          },
        }
      end,
    }
    use {
      "mbbill/undotree",
      cmd = "UndotreeToggle",
      config = [[vim.g.undotree_SetFocusWhenToggle = 1]],
    }
    use "ruanyl/coverage.vim"
    use "moll/vim-node"
    use "rust-lang/rust.vim"
    use "wbthomason/packer.nvim"
    use {
      "williamboman/nvim-lsp-installer",
      "neovim/nvim-lspconfig",
    }
    -- 🔭Telescope
    use "nvim-telescope/telescope.nvim"
    -- Telescope Extensions
    use "cljoly/telescope-repo.nvim"
    use { "nvim-telescope/telescope-file-browser.nvim" }
    use { "nvim-telescope/telescope-ui-select.nvim" }
    use "dhruvmanila/telescope-bookmarks.nvim"
    use "nvim-telescope/telescope-github.nvim"
    -- Trying command palette
    use { "LinArcX/telescope-command-palette.nvim" }
    use {
      "AckslD/nvim-neoclip.lua",
      config = function() require("neoclip").setup() end,
    }
    use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }
    use "jvgrootveld/telescope-zoxide"

    use "andymass/vim-matchup"
    use "windwp/nvim-autopairs"
    use "nvim-lua/lsp_extensions.nvim"
    -- @TODOUA: update to ts-rainbow2 fork
    use "mrjones2014/nvim-ts-rainbow"
    use "nvim-lua/popup.nvim"
    use "nvim-lua/lsp-status.nvim"
    use "folke/neodev.nvim"
    use "onsails/lspkind-nvim"
    use "ray-x/lsp_signature.nvim"
    -- sitting
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

    use { "chrisbra/Colorizer", cmd = "ColorToggle" }
    --- Cool but buggy, check back later
    --- use { "uga-rosa/ccc.nvim" }
    use "nvim-lua/plenary.nvim"
    use "kyazdani42/nvim-web-devicons"
    use "lukas-reineke/indent-blankline.nvim"
    use "rcarriga/nvim-notify"

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
      config = function() require "joel.completion" end,
    }

    use {
      "nvim-lualine/lualine.nvim",
      config = function() require "joel.statusline" end,
      requires = { "kyazdani42/nvim-web-devicons", opt = true },
    }

    use "arkav/lualine-lsp-progress"
    use "eandrju/cellular-automaton.nvim"
    use {
      "lewis6991/gitsigns.nvim",
      requires = { "nvim-lua/plenary.nvim" },
    }

    use { "Pocco81/HighStr.nvim", cmd = "HSHighlight" }
    -- Also tried bluloco
    -- use "folke/tokyonight.nvim"
    -- copilot 😱
    -- @TODOUA: figure out why adding this plugin makes packer behave differently
    -- use { "github/copilot.vim" }

    -- mostly greyscale colorscheme
    -- use {
    --   "cranberry-clockworks/coal.nvim",
    -- }

    -- @TODOUA: Very cool but still buggy. Will revisit soon.
    -- use {
    --   "gaoDean/autolist.nvim",
    --   after = "packer.nvim",
    --   ft = { "markdown" },
    --   config = function()
    --     local autolist = require "autolist"
    --     autolist.setup()
    --     autolist.create_mapping_hook("i", "<CR>", autolist.new)
    --     autolist.create_mapping_hook("i", "<Tab>", autolist.indent)
    --     autolist.create_mapping_hook("i", "<S-Tab>", autolist.indent, "<C-D>")
    --     autolist.create_mapping_hook("n", "o", autolist.new)
    --     autolist.create_mapping_hook("n", "O", autolist.new_before)
    --     autolist.create_mapping_hook("n", ">>", autolist.indent)
    --     autolist.create_mapping_hook("n", "<<", autolist.indent)
    --     autolist.create_mapping_hook("n", "<C-r>", autolist.force_recalculate)
    --     autolist.create_mapping_hook("n", "<leader>x", autolist.invert_entry, "")
    --     vim.api.nvim_create_autocmd("TextChanged", {
    --       pattern = "*",
    --       callback = function() vim.cmd.normal { autolist.force_recalculate(nil, nil), bang = false } end,
    --     })
    --   end,
    -- }
    use {
      "ldelossa/nvim-ide",
    }
    -- Local plugins
    use "~/vim-dev/plugins/codesmell_dark.vim"
    -- use "~/vim-dev/plugins/telescope.nvim"
    -- when I need some diffent functionality, may put up a PR later
    -- use "~/vim-dev/plugins/telescope-github.nvim"

    -- setup config after cloning packer
    if PACKER_BOOTSTRAP then require("packer").sync() end
  end,
  config = {
    display = {
      open_fn = require("packer.util").float,
    },
  },
}
