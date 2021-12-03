-- lua-dev for Neovim and Lua everywhere
local lspconfig = require "lspconfig"
local luadev = require("lua-dev").setup {
  lspconfig = {
    cmd = {
      "/Users/joel/vim-dev/sources/lua-language-server/bin/macOS/lua-language-server",
      "-E",
      "/Users/joel/vim-dev/sources/lua-language-server/main.lua",
    },
    settings = {
      Lua = {
        diagnostics = {
          globals = { "use" },
        },
        workspace = {
          preloadFileSize = 350,
        },
      },
    },
  },
}

-- sumneko/lua-language-server 2.5.1
lspconfig.sumneko_lua.setup(luadev)

-- nvim-web-devicons: https://www.nerdfonts.com/cheat-sheet →     
require("nvim-web-devicons").setup {
  override = {
    zsh = { icon = "", color = "#428850", name = "Zsh" },
    lua = { icon = "", color = "#4E99DF", name = "Lua" },
    md = { icon = "", color = "#6BD02B", name = "Md" },
    [".gitignore"] = { icon = "", color = "#F14E32", name = "GitIgnore" },
  },
  default = true,
}

-- Search/Replace visual b/c inccommand preview doesn't show all (PRs in flight on Neovim)
-- tsserver - JavaScript lsp config
require("lspconfig").tsserver.setup {
  on_attach = function(client)
    require("lsp_signature").on_attach {
      bind = true, -- This is mandatory, otherwise border config won't get registered.
      doc_lines = 2, -- will show 2 lines of comment/doc(if there are more than 2 lines in doc, will be truncated)
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
      -- using eslint lsp directly now, see below
      eslint_enable_code_actions = false,
      eslint_enable_disable_comments = false,
      eslint_bin = "eslint",
      eslint_config_fallback = nil,
      eslint_enable_diagnostics = false,

      -- TODO: try out update imports on file move
      update_imports_on_move = true,
      require_confirmation_on_move = false,
      watch_dir = nil,
    }
    -- required to fix code action ranges
    ts_utils.setup_client(client)
    -- disable tsserver formatting
    client.resolved_capabilities.document_formatting = false
  end,
}

-- more lsps
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
capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- `eslint` lang server setup through lspconfig
-- vscode-langservers-extracted@3.0.2 → https://github.com/hrsh7th/vscode-langservers-extracted
nvim_lsp.eslint.setup {
  on_attach = function(client)
    -- neovim's LSP client does not currently support dynamic capabilities registration, so we need to set
    -- the resolved capabilities of the eslint server ourselves!
    client.resolved_capabilities.document_formatting = true
  end,
  settings = {
    format = { enable = true },
  },
}

-- Enable rust_analyzer
-- rust-analyzer 8dd06ece2 2021-12-03 dev
nvim_lsp.rust_analyzer.setup {
  capabilities = capabilities,
  settings = {
    ["rust-analyzer"] = {
      cargo = { loadOutDirsFromCheck = true },
      procMacro = { enable = true },
    },
  },
}
-- rust-tools config: https://github.com/simrat39/rust-tools.nvim
-- You want this if you're a Rust developer.
require("rust-tools").setup {}

-- GitSigns
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
  numhl = true,
}

-- treesitter
require "joel.treesitter"

-- LSP signs default
vim.fn.sign_define(
  "DiagnosticSignError",
  { texthl = "DiagnosticSignError", text = "", numhl = "DiagnosticSignError" }
)
vim.fn.sign_define(
  "DiagnosticSignWarning",
  { texthl = "DiagnosticSignWarning", text = "", numhl = "DiagnosticSignWarning" }
)
vim.fn.sign_define("DiagnosticSignHint", { texthl = "DiagnosticSignHint", text = "", numhl = "DiagnosticSignHint" })
vim.fn.sign_define("DiagnosticSignInfo", { texthl = "DiagnosticSignInfo", text = "", numhl = "DiagnosticSignInfo" })

-- LSP Enable diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = false,
  underline = true,
  signs = true,
  update_in_insert = false,
  severity_sort = true,
})

local pop_opts = { border = "rounded", max_width = 80 }
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, pop_opts)
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, pop_opts)
