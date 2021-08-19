-- @TODOUA: Move Telescope keymaps into this module?!?
-- telescope - customized pickers
local actions = require "telescope.actions"
local utils = require "telescope.utils"
require("telescope").setup {
  defaults = {
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
    mappings = { n = { ["<Del>"] = actions.close } },
  },
}

-- github CLI
require("telescope").load_extension "gh"

require("telescope").load_extension "fzy_native"

local M = {}

-- requires github extension
function M.gh_issues()
  local opts = {}
  opts.prompt_title = " Issues"
  -- opts.author = '@me'
  require("telescope").extensions.gh.issues(opts)
end

-- @TODOUA: works for basic/default scenarios, file issue or PR
-- Use my fzf-gh for now for PRs
function M.gh_prs()
  local opts = {}
  opts.prompt_title = " Pull Requests"
  -- opts.author = 'joelpalmer'
  -- opts.search = 'is:open is:pr review-requested:@me'
  require("telescope").extensions.gh.pull_request(opts)
end
-- end github functions

function M.grep_prompt()
  require("telescope.builtin").grep_string {
    path_display = { "shorten" },
    search = vim.fn.input "Rg ",
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

  gopts.prompt_title = " Git Files"
  gopts.prompt_prefix = "  "
  gopts.results_title = "Project Files Results"

  fopts.hidden = true
  -- @TODOUA: see if TJ's stuff from his 16-Jul-2021 stream helps here
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
    require("telescope.builtin").find_files(fopts)
  end
end

-- find files in popular dirs
-- function M.find_files()
--     require('telescope.builtin').find_files {
--         prompt_title = ' Find Files',
--         shorten_path = false,
--         -- file_ignore_patterns = { "Dropbox/.*", "Library/.*", "code_smell/.*", ".rustup/.*", "Movies/" },
--         search_dirs = {
--             '~/.oh-my-zsh/custom/'
--         },
--         hidden = true,
--         cwd = '~',
--         width = .25,
--         layout_strategy = 'horizontal',
--         layout_config = {preview_width = 0.65}
--     }
-- end
-- @TODOUA: work HOME dot files into one of these
function M.grep_notes()
  local opts = {}
  opts.hidden = true
  -- opts.file_ignore_patterns = { 'thesaurus/'}
  opts.search_dirs = {
    "~/notes/",
    "~/.vim/",
    "~/dotfiles",
    "config/nvim",
    "~/vim-dev",
    "~/.oh-my-zsh/custom",
    "~/.config/alacritty",
  }
  opts.prompt_prefix = "   "
  opts.prompt_title = " Grep Notes"
  opts.path_display = { "shorten" }
  require("telescope.builtin").live_grep(opts)
end

function M.find_notes()
  require("telescope.builtin").find_files {
    prompt_title = " Find Notes",
    path_display = { "shorten" },
    cwd = "~/notes/",
    layout_strategy = "horizontal",
    layout_config = { preview_width = 0.65, width = 0.75 },
  }
end

function M.browse_notes()
  require("telescope.builtin").file_browser {
    prompt_title = " Browse Notes",
    prompt_prefix = " ﮷ ",
    cwd = "~/notes/",
    layout_strategy = "horizontal",
    layout_config = { preview_width = 0.65, width = 0.75 },
  }
end

function M.find_files()
  require("telescope.builtin").find_files {
    prompt_title = " NVim & Term Config Find",
    results_title = "Config Files Results",
    path_display = { "shorten" },
    search_dirs = {
      "~/.oh-my-zsh/custom/",
      "~/.config/nvim",
      "~/.config/alacritty",
    },
    cwd = "~/.config/nvim/",
    layout_strategy = "horizontal",
    layout_config = { preview_width = 0.65, width = 0.75 },
  }
end

function M.nvim_config()
  require("telescope.builtin").file_browser {
    prompt_title = " NVim Config Browse",
    cwd = "~/.config/nvim/",
    layout_strategy = "horizontal",
    layout_config = { preview_width = 0.65, width = 0.75 },
  }
end

function M.file_explorer()
  require("telescope.builtin").file_browser {
    prompt_title = " File Browser",
    path_display = { "shorten" },
    cwd = "~",
    layout_strategy = "horizontal",
    layout_config = { preview_width = 0.65, width = 0.75 },
  }
end

return M
