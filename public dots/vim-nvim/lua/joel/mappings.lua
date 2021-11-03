local key_map = vim.api.nvim_set_keymap
-- ** Key Mappings **
-- *Telescope-related maps at telescope/mappings (for now)

-- Surround word under cursor w/ backticks (required vim-surround)
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
-- quick temp solution for running main cliclick cmd
-- @TODOUA: do this up right with a plenary job
key_map("n", ",ck", [[:!cliclick "c:2525,30"<CR>]], { noremap = true })
-- Yank Current File Name
-- nnoremap <leader>fp :!ls %:p <bar> pbcopy<cr>
key_map("n", "<leader>fp", ":lua require('joel.funcs').yank_current_file_name()<CR>", {
  noremap = true,
  silent = true,
})

-- clear nvim-notify notifications history
key_map(
  "n",
  "<leader>cn",
  ":lua require('joel.funcs').clear_notification_history()<CR>",
  { noremap = true, silent = true }
)

-- Open File Name under cursor in vert split
key_map("n", "<leader>gf", ":vs <cfile><CR>", { noremap = false, silent = true })

-- treesitter-unit maps
key_map("x", "iu", ':lua require"treesitter-unit".select()<CR>', { noremap = true })
key_map("x", "au", ':lua require"treesitter-unit".select(true)<CR>', { noremap = true })
key_map("o", "iu", ':<c-u>lua require"treesitter-unit".select()<CR>', { noremap = true })
key_map("o", "au", ':<c-u>lua require"treesitter-unit".select(true)<CR>', { noremap = true })
-- For reference, no map:
-- :lua require"treesitter-unit".toggle_highlighting(higroup?)

-- turn off hlsearch, cursorline & cursorcolumn - @TODOUA: fix these 2
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

-- @TODOUA: figure out the semantics of <space> vs <leader>
--- ',' comma seems to have a pattern as a leader

-- *Buffer Stuff****
--- <C-6> is toggle current and alt(last viewed)
--- Go to next buffer - Skip Terminal buffers
key_map(
  "n",
  "<Leader><right>",
  "[[<Cmd>lua require'joel.buffers'.goto_next_buffer()<CR>]]",
  { noremap = true, silent = true }
)
-- go to prev buffer - skip terminal buffers
key_map(
  "n",
  "<Leader><left>",
  [[<Cmd>lua require'joel.buffers'.goto_prev_buffer()<CR>]],
  { noremap = true, silent = true }
)

-- delete current buffer - don't close split/window
-- Mnemonic: 'delete buffer' - db
key_map(
  "n",
  "<space>db",
  [[<Cmd>lua require'joel.buffers'.close_current_buffer()<CR>]],
  { noremap = false, silent = true }
)

-- Unload buffer: terminal or modified unwritten - :q is fine to close in split
-- use :bd![N] for a buffer other than current
-- Mnemonic: 'terminal close' - tx
key_map(
  "n",
  "<leader>tx",
  [[<Cmd>lua require'joel.buffers'.unload_current_buffer()<CR>]],
  { noremap = true, silent = true }
)

-- Close current buffer - WILL close split - :q to close split
key_map("n", "<Leader>x", ":bd<CR>", { noremap = true, silent = true })

-- Fugitive maps
key_map("n", "<leader>gb", ":Git blame<Return>", { noremap = true, silent = false })
key_map("n", "<leader>gp", ":G push origin ", { noremap = false })

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
  [[<Cmd>70vsp <bar>terminal<CR>:set winfixheight<CR>:sp<bar>terminal<CR>]],
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
key_map("n", "<leader>sr", ":%s/<C-R><C-W>//gI<left><left><left>", { noremap = false })
-- Replace word under cursor on Line (case-sensitive)
key_map("n", "<leader>sl", ":s/<C-R><C-W>//gI<left><left><left>", { noremap = false })
-- ** Project-wide renaming with Telescope (optional) ** --
-- Replace <cword> in all files listed in quickfix list:
-- Step 0: Skip steps 1 & 2 if you populate your quickfix list another way
-- Step 1. Use Telescope's grep_string({word_match='-w'}) - <leader>Q below
-- Step 2. In Telescope `Normal` mode, type <C-Q> (default for sending all to qf)
-- Step 3. Run this mapping, fill in new word and press <CR> (!Don't do this without VCS!!)
-- Mnemonic: Replace All - case-sensitive - ignore errors about files not having the word
-- -- (you will get LSP errors if you jack something up, that's a good thing)
-- With Telescope you can also only send selected files to the qf. See  Telescope docs.
-- There are plugins or combinations of plugins that can do this. But, this is the 'magic'
-- This can also be leveraged to open your multi-selected files in Telescope (for now: https://git.io/telescope807)
key_map(
  "n",
  "<leader>ra",
  ":cfdo %s/<C-R><C-W>//geI<bar>update<left><left><left><left><left><left><left><left><left><left><left>",
  { noremap = false }
)

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
