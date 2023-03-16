require("nvim-lsp-installer").setup {}
require("neodev").setup {}

local lspconfig = require "lspconfig"

lspconfig.lua_ls.setup {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "use" },
      },
      workspace = {
        preloadFileSize = 350,
      },
      completion = {
        callSnippet = "Replace",
      },
    },
  },
}

-- GitSigns
-- @TODOUA: https://github.com/lewis6991/gitsigns.nvim/commit/e272fcfc99003caada48bbcea7a6f95966799ceb
require("gitsigns").setup {
  signs = {
    add = {
      hl = "DiffAdd",
      text = "│",
      numhl = "GitSignsAddNr",
    },
    change = {
      hl = "DiffChange",
      text = "",
      numhl = "GitSignsChangeNr",
    },
    delete = {
      hl = "DiffDelete",
      text = "_",
      show_count = true,
      numhl = "GitSignsDeleteNr",
    },
    topdelete = {
      hl = "DiffDelete",
      text = "‾",
      show_count = true,
      numhl = "GitSignsDeleteNr",
    },
    changedelete = {
      hl = "DiffChange",
      text = "~",
      show_count = true,
      numhl = "GitSignsChangeNr",
    },
  },
  count_chars = {
    [1] = "",
    [2] = "₂",
    [3] = "₃",
    [4] = "₄",
    [5] = "₅",
    [6] = "₆",
    [7] = "₇",
    [8] = "₈",
    [9] = "₉",
    ["+"] = "",
  },
  numhl = true,
  -- word_diff = true,
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map("n", "]c", "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", { expr = true })
    map("n", "[c", "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", { expr = true })

    -- Actions
    map({ "n", "v" }, "<leader>hs", gs.stage_hunk)
    map({ "n", "v" }, "<leader>hr", gs.reset_hunk)
    map("n", "<leader>hS", gs.stage_buffer)
    map("n", "<leader>hu", gs.undo_stage_hunk)
    map("n", "<leader>hR", gs.reset_buffer)
    map("n", "<leader>hp", gs.preview_hunk)
    map("n", "<leader>hb", function() gs.blame_line { full = true } end)
    map("n", ",tb", gs.toggle_current_line_blame)
    map("n", "<leader>hd", gs.diffthis)
    map("n", "<leader>hD", function() gs.diffthis "~" end)
    map("n", ",td", function()
      gs.toggle_deleted()
      gs.toggle_word_diff()
    end)
    map("n", "<leader>hn", gs.toggle_numhl)
    map("n", "<leader>hh", gs.toggle_linehl)

    -- Hunk Text Object
    map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
  end,
}

-- nvim-ide: default components
local bookmarks = require "ide.components.bookmarks"
local branches = require "ide.components.branches"
local bufferlist = require "ide.components.bufferlist"
local callhierarchy = require "ide.components.callhierarchy"
local changes = require "ide.components.changes"
local commits = require "ide.components.commits"
local explorer = require "ide.components.explorer"
local outline = require "ide.components.outline"
local terminal = require "ide.components.terminal"
local terminalbrowser = require "ide.components.terminal.terminalbrowser"
local timeline = require "ide.components.timeline"

require("ide").setup {
  -- The global icon set to use.
  -- values: "nerd", "codicon", "default"
  icon_set = "nerd",
  -- Set the log level for nvim-ide's log. Log can be accessed with
  -- 'Workspace OpenLog'. Values are 'debug', 'warn', 'info', 'error'
  log_level = "info",
  -- Component specific configurations and default config overrides.
  components = {
    -- The global keymap is applied to all Components before construction.
    -- It allows common keymaps such as "hide" to be overridden, without having
    -- to make an override entry for all Components.
    --
    -- If a more specific keymap override is defined for a specific Component
    -- this takes precedence.
    global_keymaps = {
      -- example, change all Component's hide keymap to "h"
      -- hide = h
    },
    -- example, prefer "x" for hide only for Explorer component.
    Explorer = {
      show_file_permissions = false,
    },
  },
  -- default panel groups to display on left and right.
  panels = {
    left = "explorer",
    right = "git",
  },
  -- panels defined by groups of components, user is free to redefine the defaults
  -- and/or add additional.
  panel_groups = {
    explorer = {
      outline.Name,
      bufferlist.Name,
      explorer.Name,
      bookmarks.Name,
      callhierarchy.Name,
      terminalbrowser.Name,
    },
    terminal = { terminal.Name },
    git = { changes.Name, commits.Name, timeline.Name, branches.Name },
  },
  -- workspaces config
  workspaces = {
    -- which panels to open by default, one of: 'left', 'right', 'both', 'none'
    auto_open = "none",
  },
  -- default panel sizes for the different positions
  panel_sizes = {
    left = 30,
    right = 30,
    bottom = 20,
  },
}

-- require("tokyonight").setup {
--   style = "night",
--   on_colors = function(colors)
--     colors.bg = "#020203"
--     colors.bg_dark = "#010101"
--     colors.bg_visual = "#2d3f6f"
--   end,
--   on_highlights = function(hl, c)
--     hl.gitsignsadd = {
--       fg = c.teal,
--     }
--     hl.gitsignschange = {
--       fg = "#e0e049",
--     }
--     hl.DiffAdd = {
--       bg = c.bg_dark,
--     }
--     hl.DiffChange = {
--       bg = c.bg_dark,
--     }
--     hl.String = {
--       fg = "#FBE7D5",
--       style = {
--         italic = true,
--       },
--     }
--     hl["@parameter"] = { fg = c.blue5 }
--   end,
-- }

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

-- <leader>gy
require("gitlinker").setup()

-- Dressing up the vim.ui
-- https://github.com/stevearc/dressing.nvim
-- @TODOUA: resist temptation to go crazy with this!
require("dressing").setup {
  input = {
    -- Default prompt string
    default_prompt = "➤ ",

    -- When true, <Esc> will close the modal
    insert_only = true,

    -- These are passed to nvim_open_win
    anchor = "SW",
    relative = "cursor",
    border = "rounded",

    -- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
    prefer_width = 40,
    max_width = nil,
    min_width = 20,

    -- see :help dressing_get_config
    get_config = nil,
  },
  select = {
    -- Priority list of preferred vim.select implementations
    backend = { "telescope", "builtin" },

    -- Options for built-in selector
    builtin = {
      -- These are passed to nvim_open_win
      anchor = "NW",
      relative = "cursor",
      border = "rounded",

      -- Window options
      win_options = {

        winblend = 10,
      },

      -- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
      width = nil,
      max_width = 0.8,
      min_width = 40,
      height = nil,
      max_height = 0.9,
      min_height = 10,
    },

    -- see :help dressing_get_config
    get_config = nil,
  },
}

-- Search/Replace visual b/c inccommand preview doesn't show all (PRs in flight on Neovim)
-- tsserver - JavaScript LSP config
require("lspconfig").tsserver.setup {
  on_attach = function(client)
    require("lsp_signature").on_attach {
      bind = true, -- This is mandatory, otherwise border config won't get registered.
      doc_lines = 2, -- will show 2 lines of comment/doc(if there are more than 2 lines in doc, will be truncated)
      -- set to 0 if you DO NOT want any API comments be shown
      -- This setting only take effect in insert mode, it does not affect signature help in normal
      -- mode, 10 by default

      floating_window = true, -- show hint in a floating window, set to false for virtual text only mode
      hint_enable = true,
      hint_prefix = "🌟 ",
      hint_scheme = "String",
      use_lspsaga = false,
      hi_parameter = "PmenuSel", -- hl-search
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
    client.server_capabilities.document_formatting = false
  end,
}

-- more lsps
require("lspconfig").graphql.setup {}
require("lspconfig").clangd.setup {}
-- VimL (full circle!)
require("lspconfig").vimls.setup {}
-- nvim-autopairs
require("nvim-autopairs").setup { check_ts = true }
-- nvim_lsp object
local nvim_lsp = require "lspconfig"

-- snippet support
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- `eslint` lang server setup through lspconfig
-- vscode-langservers-extracted@4.2.1 → https://github.com/hrsh7th/vscode-langservers-extracted
nvim_lsp.eslint.setup {
  on_attach = function(client)
    -- neovim's LSP client does not currently support dynamic capabilities registration, so we need to set
    -- the resolved/server capabilities of the eslint server ourselves!
    client.server_capabilities.document_formatting = true
  end,
  settings = {
    format = { enable = true },
  },
}

-- Enabling through rust-tools!
-- Enable rust_analyzer
-- rust-analyzer (27239fbb5 2023-02-21)
-- nvim_lsp.rust_analyzer.setup {
--   capabilities = capabilities,
--   settings = {
--     ["rust-analyzer"] = {
--       -- cargo = { loadOutDirsFromCheck = true },
--       -- procMacro = { enable = true },
--       -- hoverActions = { references = true },
--     },
--   },
-- }

-- rust-tools config: https://github.com/simrat39/rust-tools.nvim
-- @TODOUA: selects on *abbles require manual close with no select
-- ... not handling nil in select telescope or otherwise
require("rust-tools").setup {
  tools = {
    inlay_hints = {
      -- prefix for parameter hints
      parameter_hints_prefix = " ",

      -- prefix for all the other hints (type, chaining)
      other_hints_prefix = " ",
    },
    server = {
      -- @TODOUA: See if this is even available
      on_attach = function(client, bufnr) client.server_capabilities.semanticTokensProvider = nil end,
    },
  },
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

local border_style = {
  { "╭", "FloatBorder" },
  { "─", "FloatBorder" },
  { "╮", "FloatBorder" },
  { "│", "FloatBorder" },
  { "╯", "FloatBorder" },
  { "─", "FloatBorder" },
  { "╰", "FloatBorder" },
  { "│", "FloatBorder" },
}

local pop_opts = { border = border_style }
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, pop_opts)
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, pop_opts)
