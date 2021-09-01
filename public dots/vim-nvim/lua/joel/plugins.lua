-- Plugins Plugins Plugins
return require("packer").startup(function()
  -- Packer can manage itself
  -- probably don't need this or vim-peekaboo
  use "editorconfig/editorconfig-vim"
  use "tpope/vim-surround"
  use "tpope/vim-fugitive"
  use "tpope/vim-repeat"
  use "tpope/vim-commentary"
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
  -- @TODOUA: don't forget to switch this out when nvim-cmp comes in
  use "tamago324/compe-zsh"
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
  use "kyazdani42/nvim-tree.lua"
  -- trying out ts-utils to see if it does add value
  use "jose-elias-alvarez/nvim-lsp-ts-utils"
  -- @TODUA: try 'https://github.com/simrat39/rust-tools.nvim'
  use "simrat39/rust-tools.nvim"
  use "norcalli/nvim-colorizer.lua"
  use "nvim-lua/plenary.nvim"
  use {
    "glepnir/galaxyline.nvim",
    branch = "main",
    config = function()
      require "joel.statusline"
    end,
    requires = { "kyazdani42/nvim-web-devicons" },
  }
  use {
    "w0rp/ale",
    ft = { "javascript", "lua" },
    cmd = "ALEEnable",
    config = "vim.cmd[[ALEEnable]]",
  }

  -- compe!
  use {
    "hrsh7th/nvim-compe",
    requires = { { "hrsh7th/vim-vsnip" } },
    config = function()
      require("compe").setup {
        enabled = true,
        autocomplete = true,
        debug = false,
        min_length = 1,
        preselect = "enable",
        throttle_time = 80,
        source_timeout = 200,
        incomplete_delay = 400,
        max_abbr_width = 100,
        max_kind_width = 100,
        max_menu_width = 100,
        documentation = {
          border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
        },
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
          zsh = true,
          -- gql_schema = true
        },
      }
    end,
  }

  -- Local plugins
  use "~/vim-dev/plugins/codesmell_dark.vim"
  use "~/vim-dev/plugins/telescope.nvim"
  -- use '~/vim-dev/plugins/fzf-gh.vim'

  -- some setups
  use { "iamcco/markdown-preview.nvim", run = "cd app && yarn install" }

  use {
    "lewis6991/gitsigns.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      require("gitsigns").setup {
        signs = {
          add = {
            hl = "DiffAdd",
            text = "│",
            numhl = "GitSignsAddNr",
          },
          change = {
            hl = "DiffChange",
            text = "│",
            numhl = "GitSignsChangeNr",
          },
          delete = {
            hl = "DiffDelete",
            text = "_",
            numhl = "GitSignsDeleteNr",
          },
          topdelete = {
            hl = "DiffDelete",
            text = "‾",
            numhl = "GitSignsDeleteNr",
          },
          changedelete = {
            hl = "DiffChange",
            text = "~",
            numhl = "GitSignsChangeNr",
          },
        },
      }
    end,
  }

  require("nvim-web-devicons").setup {
    override = {
      zsh = { icon = "", color = "#428850", name = "Zsh" },
      lua = { icon = "", color = "#4E99DF", name = "Lua" },
      md = { icon = "", color = "#6BD02B", name = "Md" },
      MD = { icon = "", color = "#6BD02B", name = "MD" },
      [".gitignore"] = { icon = "", color = "#F14E32", name = "GitIgnore" },
    },
    default = true,
  }

  require("lspkind").init {
    with_text = true,

    symbol_map = {
      Text = "",
      Method = "ƒ",
      Function = "ﬦ",
      Constructor = "",
      Variable = "",
      Class = "",
      Interface = "ﰮ",
      Module = "",
      Property = "",
      Unit = "",
      Value = "",
      Enum = "了",
      Keyword = "",
      Snippet = "﬌",
      Color = "",
      File = "",
      Folder = "",
      EnumMember = "",
      Constant = "",
      Struct = "",
    },
  }

  -- search/replace visual b/c inccommand preview doesn't show all (PRs in flight on Neovim)

  require("lspconfig").tsserver.setup {
    on_attach = function(client)
      -- signature completion - not in scope for compe
      -- @TODOUA: check on or try with rust-analyzer
      require("lsp_signature").on_attach {
        bind = true, -- This is mandatory, otherwise border config won't get registered.
        -- If you want to hook lspsaga or other signature handler, pls set to false
        doc_lines = 2, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated)
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
          border = "single", -- double, single, shadow, none
        },
        extra_trigger_chars = {}, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
      }

      local ts_utils = require "nvim-lsp-ts-utils"

      -- defaults
      ts_utils.setup {
        debug = false,
        disable_commands = false,
        enable_import_on_completion = false,
        import_all_timeout = 5000, -- ms

        -- eslint
        eslint_enable_code_actions = true,
        eslint_enable_disable_comments = true,
        eslint_bin = "eslint",
        eslint_config_fallback = nil,
        eslint_enable_diagnostics = false,

        -- TODO: try out update imports on file move
        update_imports_on_move = false,
        require_confirmation_on_move = false,
        watch_dir = nil,
      }
      -- required to fix code action ranges
      ts_utils.setup_client(client)
    end,
  }
  require("lspconfig").graphql.setup {}
  require("lspconfig").clangd.setup {}
  -- VimL (full circle!)
  require("lspconfig").vimls.setup {}
  -- nvim-autopairs
  require("nvim-autopairs").setup()
  -- nvim_lsp object
  local nvim_lsp = require "lspconfig"

  -- snippet support
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  -- Enable rust_analyzer
  nvim_lsp.rust_analyzer.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      ["rust-analyzer"] = {
        cargo = { loadOutDirsFromCheck = true },
        procMacro = { enable = true },
      },
    },
  }
  -- rust-tools config: https://github.com/simrat39/rust-tools.nvim
  require("rust-tools").setup {}
end)
