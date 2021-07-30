-- ** Key Mappings **
-- @TODUA: Should plugin specific maps go in lua modules for the given plugin?

-- toggle search highlights with cursorline & cursorcolumn
-- See augroup nvim-incsearch-cursorline for symmetry
vim.api.nvim_set_keymap(
  "n",
  "<Leader>\\",
  ":set hlsearch! cursorline! cursorcolumn!<CR>",
  { noremap = true, silent = true }
)
-- turn off hlsearch, cursorline & cursorcolumn - @TODUA: fix these 2
vim.api.nvim_set_keymap(
  "n",
  "<Leader>/",
  ":set nohlsearch nocursorline nocursorcolumn<CR>",
  { noremap = true, silent = true }
)
-- write only if changed
vim.api.nvim_set_keymap("n", "<Leader>w", ":up<CR>", { noremap = true })
-- quit (or close window)
vim.api.nvim_set_keymap("n", "<Leader>q", ":q<CR>", { noremap = true, silent = true })
-- toggle hunk line highlight
vim.api.nvim_set_keymap(
  "n",
  "<Leader>hh",
  [[<Cmd>lua require'gitsigns'.toggle_linehl()<CR>]],
  { noremap = true, silent = true }
)
-- toggle hunk line Num highlight
vim.api.nvim_set_keymap(
  "n",
  "<Leader>hn",
  [[<Cmd>lua require'gitsigns'.toggle_numhl()<CR>]],
  { noremap = true, silent = true }
)
-- use ZQ for :q! (quit & discard changes)
-- Discard all changed buffers & quit
vim.api.nvim_set_keymap("n", "<Leader>Q", ":qall!<CR>", { noremap = true, silent = true })
-- write all and quit
vim.api.nvim_set_keymap("n", "<Leader>W", ":wqall<CR>", { noremap = true, silent = true })
-- Buffer stuff - <C-6> is toggle current and alt(last viewed)
-- go to next buffer
vim.api.nvim_set_keymap("n", "<Leader><right>", ":bn<CR>", { noremap = true, silent = true })
-- go to prev buffer
vim.api.nvim_set_keymap("n", "<Leader><left>", ":bp<CR>", { noremap = true, silent = true })
-- needed bd! for toggleterm - todo?
-- delete current buffer - don't close split
vim.api.nvim_set_keymap("n", ",d", ":b#<bar>bd#<CR>", { noremap = false, silent = true })
-- delete current buffer - will close split - :q to close split
vim.api.nvim_set_keymap("n", "<Leader>x", ":bd<CR>", { noremap = true, silent = true })
-- TELESCOPE keymaps  --
-- find files with names that contain cursor word
vim.api.nvim_set_keymap(
  "n",
  ",f",
  [[<Cmd>lua require'telescope.builtin'.find_files({find_command={'fd', vim.fn.expand('<cword>')}})<CR>]],
  { noremap = true, silent = true }
)
-- open available commands & run it
vim.api.nvim_set_keymap(
  "n",
  ",c",
  [[<Cmd>lua require'telescope.builtin'.commands()<CR>]],
  { noremap = true, silent = true }
)
-- show LSP diagnostics for all open buffers
vim.api.nvim_set_keymap(
  "n",
  "<space>d",
  [[<Cmd>lua require'telescope.builtin'.lsp_workspace_diagnostics()<CR>]],
  { noremap = true, silent = true }
)
-- commands - Lua API in the works: https://github.com/neovim/neovim/pull/12378
-- git_branches
vim.api.nvim_set_keymap(
  "n",
  "<leader>gc",
  [[<Cmd>lua require'telescope.builtin'.git_branches()<CR>]],
  { noremap = true, silent = true }
)
-- git_status - <tab> to toggle staging
vim.api.nvim_set_keymap(
  "n",
  "gs",
  [[<Cmd>lua require'telescope.builtin'.git_status()<CR>]],
  { noremap = true, silent = true }
)
-- Telescope oldfiles
vim.api.nvim_set_keymap(
  "n",
  "<space>o",
  [[<Cmd>lua require'telescope.builtin'.oldfiles()<CR>]],
  { noremap = true, silent = true }
)
-- live grep slowness: https://github.com/nvim-telescope/telescope.nvim/issues/392
vim.api.nvim_set_keymap(
  "n",
  ",g",
  [[<Cmd>lua require'telescope.builtin'.live_grep()<CR>]],
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  ",k",
  [[<Cmd>lua require'telescope.builtin'.keymaps()<CR>]],
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  ",b",
  [[<Cmd>lua require'telescope.builtin'.buffers()<CR>]],
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  ",h",
  [[<Cmd>lua require'telescope.builtin'.help_tags()<CR>]],
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>fm",
  [[<Cmd>lua require'telescope.builtin'.marks()<CR>]],
  { noremap = true, silent = true }
)
-- grep word under cursor
vim.api.nvim_set_keymap(
  "n",
  "<leader>g",
  [[<Cmd>lua require'telescope.builtin'.grep_string()<CR>]],
  { noremap = true, silent = true }
)
-- find files with gitfiles & fallback on find_files
vim.api.nvim_set_keymap(
  "n",
  ",<space>",
  [[<Cmd>lua require'joel.telescope'.project_files()<CR>]],
  { noremap = true, silent = true }
)
-- browse, explore and create notes
vim.api.nvim_set_keymap(
  "n",
  ",n",
  [[<Cmd>lua require'joel.telescope'.browse_notes()<CR>]],
  { noremap = true, silent = true }
)
-- find notes
vim.api.nvim_set_keymap(
  "n",
  "<leader>n",
  [[<Cmd>lua require'joel.telescope'.find_notes()<CR>]],
  { noremap = true, silent = true }
)
-- search notes
vim.api.nvim_set_keymap(
  "n",
  "<space>n",
  [[<Cmd>lua require'joel.telescope'.grep_notes()<CR>]],
  { noremap = true, silent = true }
)
-- Explore files starting at $HOME
vim.api.nvim_set_keymap(
  "n",
  ",e",
  [[<Cmd>lua require'joel.telescope'.file_explorer()<CR>]],
  { noremap = true, silent = true }
)
-- Find files in popular dirs
vim.api.nvim_set_keymap(
  "n",
  "<space>e",
  [[<Cmd>lua require'joel.telescope'.find_files()<CR>]],
  { noremap = true, silent = true }
)
-- greg for a string
vim.api.nvim_set_keymap(
  "n",
  "<space>g",
  [[<Cmd>lua require'joel.telescope'.grep_prompt()<CR>]],
  { noremap = true, silent = true }
)
-- find or create neovim configs
vim.api.nvim_set_keymap(
  "n",
  "<leader>nc",
  [[<Cmd>lua require'joel.telescope'.nvim_config()<CR>]],
  { noremap = true, silent = true }
)
-- github issues
vim.api.nvim_set_keymap(
  "n",
  "<leader>is",
  [[<Cmd>lua require'joel.telescope'.gh_issues()<CR>]],
  { noremap = true, silent = true }
)
-- github PRs - keep using my fzf-gh until I (or they) PR telescope
-- @TODUA: "nnoremap <silent> <leader>pr :lua require'joel.telescope'.gh_prs()<cr>

-- open file in directory of current file
vim.api.nvim_set_keymap("n", "<leader>e", ":e %:h/", { noremap = false, silent = false })
vim.api.nvim_set_keymap("n", "<leader>v", ":vs %:h/", { noremap = false, silent = false })

-- open quickfix / close
vim.api.nvim_set_keymap("n", "<leader>co", ":cope<cr>", { noremap = false, silent = true })
vim.api.nvim_set_keymap("n", "<leader>cl", ":cclose<cr>", { noremap = false, silent = true })
-- open location list - close manually
vim.api.nvim_set_keymap("n", "<leader>lo", ":lope<cr>", { noremap = false, silent = true })
-- sessions
-- new session
vim.api.nvim_set_keymap("n", "<leader>ss", ":mksession ~/vim-sessions/", { noremap = false, silent = false })
-- overwrite current session (this is probably not idiomatic)
vim.api.nvim_set_keymap(
  "n",
  "<leader>os",
  ':wa<Bar>exe "mksession! " . v:this_session',
  { noremap = false, silent = false }
)
-- save some strokes (best mapping ever)
vim.api.nvim_set_keymap("v", ";", ":", { noremap = true })
vim.api.nvim_set_keymap("n", ";", ":", { noremap = true })

-- no Help when I fat finger F1
vim.api.nvim_set_keymap("n", "<F1>", "<Esc>", { noremap = false })
vim.api.nvim_set_keymap("i", "<F1>", "<Esc>", { noremap = false })

-- open 2 vertically split terminals
-- nnoremap <silent> ,\ :60vsp <bar>terminal<cr>:sp<bar>terminal<cr>
vim.api.nvim_set_keymap(
  "n",
  ",\\",
  [[<Cmd>60vsp <bar>terminal<CR>:sp<bar>terminal<CR>]],
  { noremap = true, silent = true }
)
-- Colorizer Toggle
vim.api.nvim_set_keymap("n", "<space>c", [[<Cmd>ColorizerToggle<CR>]], { noremap = true, silent = true })
