local key_map = vim.api.nvim_set_keymap
-- TELESCOPE keymaps  --
-- Search through your Neovim related todos
key_map("n", "<leader>st", ":lua require'joel.telescope'.search_todos()<CR>", { noremap = true, silent = true })

-- search Brave bookmarks & go
key_map(
  "n",
  "<space>b",
  [[<Cmd>lua require('telescope').extensions.bookmarks.bookmarks()<CR>]],
  { noremap = true, silent = true }
)

-- open zoxide list
key_map(
  "n",
  "<leader>z",
  ":lua require'telescope'.extensions.zoxide.list{results_title='Z Directories', prompt_title='Z Prompt'}<CR>",
  { noremap = true, silent = true }
)

-- telescope-repo
key_map("n", "<leader>rl", [[<Cmd>lua require'joel.telescope'.repo_list()<CR>]], { noremap = true, silent = true })

-- telescope notify history
key_map(
  "n",
  "<leader>nh",
  [[<Cmd>lua require('telescope').extensions.notify.notify({results_title='Notification History', prompt_title='Search Messages'})<CR>]],
  { noremap = true, silent = true }
)

-- show LSP implementations
key_map(
  "n",
  "<leader>ti",
  [[<Cmd>lua require'telescope.builtin'.lsp_implementations()<CR>]],
  { noremap = true, silent = true }
)

-- show LSP definitions
key_map(
  "n",
  "<leader>td",
  [[<Cmd>lua require'telescope.builtin'.lsp_definitions({layout_config = { preview_width = 0.50, width = 0.92 }, path_display = { "shorten" }, results_title='Definitions'})<CR>]],
  { noremap = true, silent = true }
)

-- commands - Lua API in the works: https://github.com/neovim/neovim/pull/12378
-- git_branches
key_map(
  "n",
  "<leader>gc",
  [[<Cmd>lua require'telescope.builtin'.git_branches()<CR>]],
  { noremap = true, silent = true }
)
-- git_commits (log)
key_map("n", "gl", [[<Cmd>lua require'telescope.builtin'.git_commits()<CR>]], { noremap = true, silent = true })
-- git_status - <tab> to toggle staging
key_map("n", "gs", [[<Cmd>lua require'telescope.builtin'.git_status()<CR>]], { noremap = true, silent = true })
-- ** the Telescope comma maps **
-- find files with names that contain cursor word
key_map(
  "n",
  ",f",
  [[<Cmd>lua require'telescope.builtin'.find_files({find_command={'fd', vim.fn.expand('<cword>')}})<CR>]],
  { noremap = true, silent = true }
)
-- show LSP diagnostics for all open buffers
key_map(
  "n",
  ",d",
  [[<Cmd>lua require'telescope.builtin'.lsp_workspace_diagnostics()<CR>]],
  { noremap = true, silent = true }
)
-- open available commands & run it
key_map(
  "n",
  ",c",
  [[<Cmd>lua require'telescope.builtin'.commands({results_title='Commands Results'})<CR>]],
  { noremap = true, silent = true }
)
-- Telescope oldfiles
key_map(
  "n",
  ",o",
  [[<Cmd>lua require'telescope.builtin'.oldfiles({results_title='Recent-ish Files'})<CR>]],
  { noremap = true, silent = true }
)
-- Telescopic version of FZF's :Lines
key_map(
  "n",
  ",l",
  [[<Cmd>lua require('telescope.builtin').live_grep({grep_open_files=true})<CR>]],
  { noremap = true, silent = true }
)
key_map("n", ",g", [[<Cmd>lua require'telescope.builtin'.live_grep()<CR>]], { noremap = true, silent = true })
key_map(
  "n",
  ",k",
  [[<Cmd>lua require'telescope.builtin'.keymaps({results_title='Key Maps Results'})<CR>]],
  { noremap = true, silent = true }
)
key_map(
  "n",
  ",b",
  [[<Cmd>lua require'telescope.builtin'.buffers({prompt_title = 'Find Buffer', results_title='Buffers', layout_strategy = 'vertical', layout_config = { width = 0.40, height = 0.55 }})<CR>]],
  { noremap = true, silent = true }
)
key_map(
  "n",
  ",h",
  [[<Cmd>lua require'telescope.builtin'.help_tags({results_title='Help Results'})<CR>]],
  { noremap = true, silent = true }
)
key_map(
  "n",
  ",m",
  [[<Cmd>lua require'telescope.builtin'.marks({results_title='Marks Results'})<CR>]],
  { noremap = true, silent = true }
)
-- find files with gitfiles & fallback on find_files
key_map("n", ",<space>", [[<Cmd>lua require'joel.telescope'.project_files()<CR>]], { noremap = true, silent = true })
-- browse, explore and create notes
key_map("n", ",n", [[<Cmd>lua require'joel.telescope'.browse_notes()<CR>]], { noremap = true, silent = true })
-- Explore files starting at $HOME
key_map("n", ",e", [[<Cmd>lua require'joel.telescope'.file_explorer()<CR>]], { noremap = true, silent = true })
-- Browse files from cwd - File Browser
key_map("n", ",fb", [[<Cmd>lua require'telescope.builtin'.file_browser()<CR>]], { noremap = true, silent = true })
-- End Telescope comma maps

-- grep word under cursor
key_map("n", "<leader>g", [[<Cmd>lua require'telescope.builtin'.grep_string()<CR>]], { noremap = true, silent = true })
-- grep word under cursor - case-sensitive (exact word) - made for use with Replace All - see <leader>ra
key_map(
  "n",
  "<leader>G",
  [[<Cmd>lua require'telescope.builtin'.grep_string({word_match='-w'})<CR>]],
  { noremap = true, silent = true }
)

-- find notes
key_map("n", "<leader>n", [[<Cmd>lua require'joel.telescope'.find_notes()<CR>]], { noremap = true, silent = true })
-- search notes
key_map("n", "<space>n", [[<Cmd>lua require'joel.telescope'.grep_notes()<CR>]], { noremap = true, silent = true })
-- Find files in config dirs
key_map("n", "<space>e", [[<Cmd>lua require'joel.telescope'.find_configs()<CR>]], { noremap = true, silent = true })
-- greg for a string
key_map("n", "<space>g", [[<Cmd>lua require'joel.telescope'.grep_prompt()<CR>]], { noremap = true, silent = true })
-- find or create neovim configs
key_map("n", "<leader>nc", [[<Cmd>lua require'joel.telescope'.nvim_config()<CR>]], { noremap = true, silent = true })

-- Github issues
key_map("n", "<leader>is", [[<Cmd>lua require'joel.telescope'.gh_issues()<CR>]], { noremap = true, silent = true })
-- github PRs
key_map("n", "<leader>pr", [[<Cmd>lua require'joel.telescope'.gh_prs()<CR>]], { noremap = true, silent = true })

-- grep the Neovim source code with word under cursor → cword - just z to Neovim source for other actions
key_map("n", "<leader>ns", [[<Cmd>lua require'joel.telescope'.grep_nvim_src()<CR>]], { noremap = true, silent = true })
-- End Telescope maps
