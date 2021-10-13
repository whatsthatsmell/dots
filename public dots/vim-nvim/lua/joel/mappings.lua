local key_map = vim.api.nvim_set_keymap
-- ** Key Mappings **
-- surround word under cursor w/ backticks (required vim-surround)
key_map("n", "<leader>`", "ysiW`", { noremap = false })
-- REPLACE: delete inner word & replace with last yanked (including system)
key_map("n", ",r", '"_diwhp', { noremap = true })
-- DELETE: with y,d or c{motion} & it wont replace "0
key_map("n", "_", '"_', { noremap = true })
-- paste last thing yanked(not system copied), not deleted
key_map("n", ",p", '"0p', { noremap = true })
key_map("n", ",P", '"0P', { noremap = true })
-- toggle search highlights with cursorline & cursorcolumn
-- See augroup nvim-incsearch-cursorline for symmetry
key_map("n", "<Leader>\\", ":set hlsearch! cursorline! cursorcolumn!<CR>", { noremap = true, silent = true })

-- treesitter-unit maps
key_map("x", "iu", ':lua require"treesitter-unit".select()<CR>', { noremap = true })
key_map("x", "au", ':lua require"treesitter-unit".select(true)<CR>', { noremap = true })
key_map("o", "iu", ':<c-u>lua require"treesitter-unit".select()<CR>', { noremap = true })
key_map("o", "au", ':<c-u>lua require"treesitter-unit".select(true)<CR>', { noremap = true })
-- For reference, no map:
-- :lua require"treesitter-unit".toggle_highlighting(higroup?)

-- turn off hlsearch, cursorline & cursorcolumn - @TODUA: fix these 2
key_map("n", "<Leader>/", ":set nohlsearch nocursorline nocursorcolumn<CR>", { noremap = true, silent = true })

-- one of the greatest commands ever
key_map("n", "<space>t", ":TSHighlightCapturesUnderCursor<CR>", { noremap = true, silent = true })

-- write only if changed
key_map("n", "<Leader>w", ":up<CR>", { noremap = true })
-- quit (or close window)
key_map("n", "<Leader>q", ":q<CR>", { noremap = true, silent = true })

-- GitSigns maps
-- toggle hunk line highlight
key_map("n", "<Leader>hh", [[<Cmd>lua require'gitsigns'.toggle_linehl()<CR>]], { noremap = true, silent = true })
-- toggle hunk line Num highlight
key_map("n", "<Leader>hn", [[<Cmd>lua require'gitsigns'.toggle_numhl()<CR>]], { noremap = true, silent = true })

-- use ZQ for :q! (quit & discard changes)
-- Discard all changed buffers & quit
key_map("n", "<Leader>Q", ":qall!<CR>", { noremap = true, silent = true })
-- write all and quit
key_map("n", "<Leader>W", ":wqall<CR>", { noremap = true, silent = true })
-- Buffer stuff - <C-6> is toggle current and alt(last viewed)
-- go to next buffer
key_map("n", "<Leader><right>", ":bn<CR>", { noremap = true, silent = true })
-- go to prev buffer
key_map("n", "<Leader><left>", ":bp<CR>", { noremap = true, silent = true })
-- needed bd! for toggleterm - todo?
-- delete current buffer - don't close split
key_map("n", "<space>db", ":b#<bar>bd#<CR>", { noremap = false, silent = true })
-- delete current buffer - will close split - :q to close split
key_map("n", "<Leader>x", ":bd<CR>", { noremap = true, silent = true })

-- Fugitive maps
key_map("n", "<leader>gb", ":Git blame<Return>", { noremap = true, silent = false })
key_map("n", "<leader>gp", ":G push origin ", { noremap = false })

-- TELESCOPE keymaps  --
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
  [[<Cmd>lua require'telescope.builtin'.buffers({results_title='Buffers'})<CR>]],
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
-- End Telescope comma maps

-- grep word under cursor
key_map("n", "<leader>g", [[<Cmd>lua require'telescope.builtin'.grep_string()<CR>]], { noremap = true, silent = true })
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
-- github issues
key_map("n", "<leader>is", [[<Cmd>lua require'joel.telescope'.gh_issues()<CR>]], { noremap = true, silent = true })
-- End Telescope maps

-- github PRs - keep using my fzf-gh until I (or they) PR telescope
-- @TODUA: "nnoremap <silent> <leader>pr :lua require'joel.telescope'.gh_prs()<cr>

-- open file in directory of current file
key_map("n", "<leader>e", ":e %:h/", { noremap = false, silent = false })
key_map("n", "<leader>v", ":vs %:h/", { noremap = false, silent = false })

-- open quickfix / close
key_map("n", "<leader>co", ":cope<cr>", { noremap = false, silent = true })
key_map("n", "<leader>cl", ":cclose<cr>", { noremap = false, silent = true })
-- open location list - close manually
key_map("n", "<leader>lo", ":lope<cr>", { noremap = false, silent = true })
-- sessions
-- new session
key_map("n", "<leader>ss", ":mksession ~/vim-sessions/", { noremap = false, silent = false })
-- overwrite current session (this is probably not idiomatic)
key_map("n", "<leader>os", ':wa<Bar>exe "mksession! " . v:this_session', { noremap = false, silent = false })
-- save some strokes (best mapping ever)
key_map("v", ";", ":", { noremap = true })
key_map("n", ";", ":", { noremap = true })

-- no Help when I fat finger F1
key_map("n", "<F1>", "<Esc>", { noremap = false })
key_map("i", "<F1>", "<Esc>", { noremap = false })

-- open 2 vertically split terminals
key_map(
  "n",
  ",\\",
  [[<Cmd>60vsp <bar>terminal<CR>:set winfixheight<CR>:sp<bar>terminal<CR>]],
  { noremap = true, silent = true }
)
-- open split below, slightly smaller
key_map("n", ",-", ":23sp<CR><C-w><down>", { noremap = true, silent = true })
-- Colorizer Toggle
key_map("n", "<space>c", [[<Cmd>ColorizerToggle<CR>]], { noremap = true, silent = true })

-- yank all in buffer
key_map("n", "<leader>a", ":%y<cr>", { noremap = false, silent = true })

-- expands to dir of current file in cmd mode
key_map("c", "%%", [[getcmdtype() == ':' ? expand('%:h').'/' : '%%']], { noremap = true, expr = true })

-- Move between Vimdows
key_map("n", "<up>", "<C-w><up>", { noremap = false })
key_map("n", "<down>", "<C-w><down>", { noremap = false })
key_map("n", "<left>", "<C-w><left>", { noremap = false })
key_map("n", "<right>", "<C-w><right>", { noremap = false })

-- Replace word under cursor in Buffer (case-sensitive)
-- nmap <leader>sr :%s/<C-R><C-W>//gI<left><left><left>
key_map("n", "<leader>sr", ":%s/<C-R><C-W>//gI<left><left><left>", { noremap = false })
-- Replace word under cursor on Line (case-sensitive)
-- nmap <leader>sl :s/<C-R><C-W>//gI<left><left><left>
key_map("n", "<leader>sl", ":s/<C-R><C-W>//gI<left><left><left>", { noremap = false })

-- run packer sync
key_map("n", "<leader>ps", [[<Cmd>PackerSync<CR>]], { noremap = true, silent = true })

-- change dir for window to file's dir
key_map("n", "<leader>cd", ":lcd %:p:h<cr>", { noremap = true, silent = true })
-- change dir for window to file's git working dir
key_map("n", "<leader>gd", ":Glcd<cr>", { noremap = true, silent = true })
-- toggle foldcolumn
key_map("n", ",tf", ":lua require'joel.settings'.toggle_fold_col()<CR>", { noremap = true, silent = true })

-- toggle IndentBlankline with set line! - both off by default
key_map("n", ",ti", ":IndentBlanklineToggle<CR>:set list!<CR>", { noremap = true, silent = true })

-- toggle colorizer: will be toggled on by default for appropriate fts
key_map("n", ",ct", ":ColorToggle<CR>", { noremap = false, silent = true })

-- markdown preview
key_map("n", ",md", "<Plug>MarkdownPreview", { noremap = false })

-- open URI link under cursor in browser or terminal
key_map("n", "gx", ":lua require'joel.settings'.open_uri()<CR>", { noremap = true, silent = true })
