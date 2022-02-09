-- Telescope 🔭 - setup and customized pickers
require "joel.telescope.mappings"
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local utils = require "telescope.utils"

-- https://github.com/nvim-telescope/telescope.nvim/issues/1048
local telescope_custom_actions = {}

function telescope_custom_actions._multiopen(prompt_bufnr, open_cmd)
  local picker = action_state.get_current_picker(prompt_bufnr)
  local num_selections = #picker:get_multi_selection()
  if not num_selections or num_selections <= 1 then
    actions.add_selection(prompt_bufnr)
  end
  actions.send_selected_to_qflist(prompt_bufnr)
  vim.cmd("cfdo " .. open_cmd)
end

function telescope_custom_actions.multi_selection_open(prompt_bufnr)
  telescope_custom_actions._multiopen(prompt_bufnr, "edit")
end

-- @TODOUA: create a git history keyword search picker
-- @TODOUA: add action to commits pickers to yank commit hash

require("telescope").setup {
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case", -- this is default
    },
    file_browser = {
      hidden = true,
    },
    ["ui-select"] = {
      require("telescope.themes").get_cursor(),
    },
    bookmarks = {
      selected_browser = "brave",
      url_open_command = "open",
    },
    command_palette = {
      {
        "File",
        { "Yank Current File Name", ":lua require('joel.funcs').yank_current_file_name()" },
        { "Write Current Buffer", ":w" },
        { "Write All Buffers", ":wa" },
        { "Quit", ":qa" },
        { "File Browser", ":lua require'telescope'.extensions.file_browser.file_browser()", 1 },
        { "Search for Word", ":lua require('telescope.builtin').live_grep()", 1 },
        { "Project Files", ":lua require'joel.telescope'.project_files()", 1 },
      },
      {
        "Git(Hub)",
        { " Issues", "lua require'joel.telescope'.gh_issues()", 1 },
        { " Pulls", "lua require'joel.telescope'.gh_prs()", 1 },
        { " Status", "lua require'telescope.builtin'.git_status()", 1 },
        { " Diff Split Vertical", ":Gvdiffsplit!", 1 },
        { " Log", "lua require'telescope.builtin'.git_commits()", 1 },
        {
          " File History",
          ":lua require'telescope.builtin'.git_bcommits({prompt_title = '  ', results_title='Git File Commits'})",
          1,
        },
      },
      {
        "Terminal",
        { "Vertical Right", ":vsp | terminal", 1 },
      },
      {
        "Notes",
        { "Browse Notes", "lua require'joel.telescope'.browse_notes()", 1 },
        { "Find Notes", "lua require'joel.telescope'.find_notes()", 1 },
        { "Search/Grep Notes", "lua require'joel.telescope'.grep_notes()", 1 },
      },
      {
        "Toggle",
        { "cursor line", ":set cursorline!" },
        { "cursor column", ":set cursorcolumn!" },
        { "spell checker", ":set spell!" },
        { "relative number", ":set relativenumber!" },
        { "search highlighting", ":set hlsearch!" },
        { "Colorizer", ":ColorToggle" },
        { "Fold Column", ":lua require'joel.settings'.toggle_fold_col()" },
      },
      {
        "Neovim",
        { "checkhealth", ":checkhealth" },
        { "commands", ":lua require('telescope.builtin').commands()" },
        { "command history", ":lua require('telescope.builtin').command_history()" },
        { "registers", ":lua require('telescope.builtin').registers()" },
        { "options", ":lua require('telescope.builtin').vim_options()" },
        { "keymaps", ":lua require('telescope.builtin').keymaps()" },
        { "buffers", ":Telescope buffers" },
        { "search history", ":lua require('telescope.builtin').search_history()" },
        { "Search TODOS", ":lua require'joel.telescope'.search_todos()" },
      },
    },
  },
  defaults = {
    preview = {
      timeout = 500,
      msg_bg_fillchar = "",
    },
    multi_icon = " ",
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--hidden",
    },
    prompt_prefix = "❯ ",
    selection_caret = "❯ ",
    sorting_strategy = "ascending",
    color_devicons = true,
    layout_config = {
      prompt_position = "bottom",
      horizontal = {
        width_padding = 0.04,
        height_padding = 0.1,
        preview_width = 0.6,
      },
      vertical = {
        width_padding = 0.05,
        height_padding = 1,
        preview_height = 0.5,
      },
    },

    -- using custom temp multi-select maps
    -- https://github.com/nvim-telescope/telescope.nvim/issues/1048
    mappings = {
      n = {
        ["<Del>"] = actions.close,
        ["<C-A>"] = telescope_custom_actions.multi_selection_open,
      },
      i = {
        ["<esc>"] = actions.close,
        ["<C-A>"] = telescope_custom_actions.multi_selection_open,
      },
    },
    dynamic_preview_title = true,
    winblend = 4,
  },
}

-- 🔭 Extensions --
-- https://github.com/nvim-telescope/telescope-file-browser.nvim
require("telescope").load_extension "file_browser"
-- https://github.com/nvim-telescope/telescope-ui-select.nvim
require("telescope").load_extension "ui-select"
-- https://github.com/nvim-telescope/telescope-fzf-native.nvim#telescope-fzf-nativenvim
require("telescope").load_extension "fzf"
-- https://github.com/LinArcX/telescope-command-palette.nvim
require("telescope").load_extension "command_palette"
-- https://github.com/dhruvmanila/telescope-bookmarks.nvim
-- <space>b
require("telescope").load_extension "bookmarks"

-- https://github.com/jvgrootveld/telescope-zoxide
-- <leader>z
require("telescope").load_extension "zoxide"

-- https://github.com/cljoly/telescope-repo.nvim
-- <leader>rl
require("telescope").load_extension "repo"

-- https://github.com/AckslD/nvim-neoclip.lua
-- <C-n>
require("telescope").load_extension "neoclip"

-- GitHub CLI → local version
require("telescope").load_extension "gh"

-- my telescopic customizations
local M = {}

-- requires repo extension
function M.repo_list()
  local opts = {}
  opts.prompt_title = " Repos"
  require("telescope").extensions.repo.list(opts)
end

-- requires GitHub extension
function M.gh_issues()
  local opts = {}
  opts.prompt_title = " Issues"
  require("telescope").extensions.gh.issues(opts)
end

function M.gh_prs()
  local opts = {}
  opts.prompt_title = " Pull Requests"
  require("telescope").extensions.gh.pull_request(opts)
end
-- end github functions

-- grep_string pre-filtered from grep_prompt
local function grep_filtered(opts)
  opts = opts or {}
  require("telescope.builtin").grep_string {
    path_display = { "smart" },
    search = opts.filter_word or "",
  }
end

-- open vim.ui.input dressing prompt for initial filter
function M.grep_prompt()
  vim.ui.input({ prompt = "Rg " }, function(input)
    grep_filtered { filter_word = input }
  end)
end

-- search Neovim related todos
function M.search_todos()
  require("telescope.builtin").grep_string {
    prompt_title = " Search TODOUAs",
    prompt_prefix = " ",
    results_title = "Neovim TODOUAs",
    path_display = { "smart" },
    search = "TODOUA",
  }
end

-- grep Neovim source using cword
function M.grep_nvim_src()
  require("telescope.builtin").grep_string {
    results_title = "Neovim Source Code",
    path_display = { "smart" },
    search_dirs = {
      "~/vim-dev/sources/neovim/runtime/lua/vim/",
      "~/vim-dev/sources/neovim/src/nvim/",
    },
  }
end

M.project_files = function()
  local _, ret, stderr = utils.get_os_command_output {
    "git",
    "rev-parse",
    "--is-inside-work-tree",
  }

  local gopts = {}
  local fopts = {}

  gopts.prompt_title = " Find"
  gopts.prompt_prefix = "  "
  gopts.results_title = " Repo Files"

  fopts.hidden = true
  fopts.file_ignore_patterns = {
    ".vim/",
    ".local/",
    ".cache/",
    "Downloads/",
    ".git/",
    "Dropbox/.*",
    "Library/.*",
    ".rustup/.*",
    "Movies/",
    ".cargo/registry/",
  }

  if ret == 0 then
    require("telescope.builtin").git_files(gopts)
  else
    fopts.results_title = "CWD: " .. vim.fn.getcwd()
    require("telescope.builtin").find_files(fopts)
  end
end

-- @TODOUA: break up notes and configs
function M.grep_notes()
  local opts = {}
  opts.hidden = true
  opts.search_dirs = {
    "~/notes/",
  }
  opts.prompt_prefix = "   "
  opts.prompt_title = " Grep Notes"
  opts.path_display = { "smart" }
  require("telescope.builtin").live_grep(opts)
end

function M.find_notes()
  require("telescope.builtin").find_files {
    prompt_title = " Find Notes",
    path_display = { "smart" },
    cwd = "~/notes/",
    layout_strategy = "horizontal",
    layout_config = { preview_width = 0.65, width = 0.75 },
  }
end

function M.browse_notes()
  require("telescope").extensions.file_browser.file_browser {
    prompt_title = " Browse Notes",
    prompt_prefix = " ﮷ ",
    cwd = "~/notes/",
    layout_strategy = "horizontal",
    layout_config = { preview_width = 0.65, width = 0.75 },
  }
end

function M.find_configs()
  require("telescope.builtin").find_files {
    prompt_title = " NVim & Term Config Find",
    results_title = "Config Files Results",
    path_display = { "smart" },
    search_dirs = {
      "~/.oh-my-zsh/custom",
      "~/.config/nvim",
      "~/.config/alacritty",
    },
    -- cwd = "~/.config/nvim/",
    layout_strategy = "horizontal",
    layout_config = { preview_width = 0.65, width = 0.75 },
  }
end

function M.nvim_config()
  require("telescope").extensions.file_browser.file_browser {
    prompt_title = " NVim Config Browse",
    cwd = "~/.config/nvim/",
    layout_strategy = "horizontal",
    layout_config = { preview_width = 0.65, width = 0.75 },
  }
end

function M.file_explorer()
  require("telescope").extensions.file_browser.file_browser {
    prompt_title = " File Browser",
    path_display = { "smart" },
    cwd = "~",
    layout_strategy = "horizontal",
    layout_config = { preview_width = 0.65, width = 0.75 },
  }
end

return M
