-- Telescope 🔭 - setup and customized pickers
require "joel.telescope.mappings"
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local utils = require "telescope.utils"
local custom_actions = {}
function custom_actions._multiopen(prompt_bufnr, open_cmd)
  local picker = action_state.get_current_picker(prompt_bufnr)
  local num_selections = #picker:get_multi_selection()
  if num_selections > 1 then
    local cwd = picker.cwd
    if cwd == nil then
      cwd = ""
    else
      cwd = string.format("%s/", cwd)
    end
    vim.cmd "bw!"
    for _, entry in ipairs(picker:get_multi_selection()) do
      vim.cmd(string.format("%s %s%s", open_cmd, cwd, entry.value))
    end
    vim.cmd "stopinsert"
  else
    if open_cmd == "vsplit" then
      actions.file_vsplit(prompt_bufnr)
    elseif open_cmd == "split" then
      actions.file_split(prompt_bufnr)
    elseif open_cmd == "tabe" then
      actions.file_tab(prompt_bufnr)
    else
      actions.select_default(prompt_bufnr)
    end
  end
end
function custom_actions.multi_selection_open_vsplit(prompt_bufnr)
  custom_actions._multiopen(prompt_bufnr, "vsplit")
end
function custom_actions.multi_selection_open_split(prompt_bufnr)
  custom_actions._multiopen(prompt_bufnr, "split")
end
function custom_actions.multi_selection_open_tab(prompt_bufnr)
  custom_actions._multiopen(prompt_bufnr, "tabe")
end
function custom_actions.multi_selection_open(prompt_bufnr)
  custom_actions._multiopen(prompt_bufnr, "edit")
end

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
    -- ["ui-select"] = {
    --   require("telescope.themes").get_cursor(),
    -- },
    bookmarks = {
      selected_browser = "brave",

      url_open_command = "open",
    },
  },
  defaults = {
    preview = {
      timeout = 500,
      msg_bg_fillchar = "",
    },
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
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<tab>"] = actions.toggle_selection + actions.move_selection_next,
        ["<s-tab>"] = actions.toggle_selection + actions.move_selection_previous,
        ["<cr>"] = custom_actions.multi_selection_open,
        ["<c-v>"] = custom_actions.multi_selection_open_vsplit,
        ["<c-s>"] = custom_actions.multi_selection_open_split,
        ["<c-t>"] = custom_actions.multi_selection_open_tab,
      },
      n = {
        ["<Del>"] = actions.close,
        ["<esc>"] = actions.close,
        ["<tab>"] = actions.toggle_selection + actions.move_selection_next,
        ["<s-tab>"] = actions.toggle_selection + actions.move_selection_previous,
        ["<cr>"] = custom_actions.multi_selection_open,
        ["<c-v>"] = custom_actions.multi_selection_open_vsplit,
        ["<c-s>"] = custom_actions.multi_selection_open_split,
        ["<c-t>"] = custom_actions.multi_selection_open_tab,
      },
    },
    dynamic_preview_title = true,
    winblend = 3,
  },
}

-- 🔭 Extensions --
-- https://github.com/nvim-telescope/telescope-file-browser.nvim
require("telescope").load_extension "file_browser"
-- https://github.com/nvim-telescope/telescope-ui-select.nvim
-- require("telescope").load_extension "ui-select"
-- https://github.com/nvim-telescope/telescope-fzf-native.nvim#telescope-fzf-nativenvim
require("telescope").load_extension "fzf"

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
