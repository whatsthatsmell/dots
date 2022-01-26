local key_map = vim.api.nvim_set_keymap
-- ** Key Mappings ***
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

-- Toggle search highlights with cursorline & cursorcolumn: crosshairs
-- See augroup nvim-incsearch-cursorline for symmetry
key_map("n", "<Leader>\\", [[<Cmd>lua require'joel.settings'.toggle_crosshairs()<CR>]], {
  noremap = true,
  silent = true,
})

-- Paste/Put ALL the Vim things in a new buffer!
-- @TODOUA: make `vim` a function param
key_map(
  "n",
  "<Leader>pv",
  [[<Cmd>new<bar>put =execute('lua print(vim.inspect(vim))')
<CR>]],
  {
    noremap = true,
    silent = true,
  }
)

-- cliclick maps - MacOS specific - 2560x1440
-- cliclick → CLICK system notification banner
key_map("n", ",cn", ":lua require('joel.funcs').click_banner_notification()<CR>", { noremap = true, silent = true })
-- cliclick -> MOVE pointer off top Mac sys menu - so the menu hides
key_map("n", ",cm", ":lua require('joel.funcs').move_pointer_off_menu()<CR>", { noremap = true, silent = true })

-- toggle bool word - true/false
key_map(
  "n",
  "gtb",
  ":lua require('joel.funcs').toggle_bool({word=vim.fn.expand('<cword>')})<CR>",
  { noremap = true, silent = true }
)

-- Yank Current File Name
key_map("n", "<leader>fp", ":lua require('joel.funcs').yank_current_file_name()<CR>", {
  noremap = true,
  silent = true,
})

-- Create tasks in todoist using current Visual selection
-- default: create task in 'Neovim' project with 'Neovim' label
key_map("v", "<leader>t", [[<Cmd>lua require'joel.funcs'.create_todoist_task()<CR>]], { noremap = false })
-- create work task in todoist
-- @TODOUA: make more robust → a picker for proj, label etc.
key_map(
  "v",
  "<leader>tw",
  [[<Cmd>lua require'joel.funcs'.create_todoist_task({proj_id = 2236720344, label_id = 2158924977})<CR>]],
  { noremap = false }
)

-- clear nvim-notify notifications history
key_map(
  "n",
  "<leader>cn",
  ":lua require('joel.funcs').clear_notification_history()<CR>",
  { noremap = true, silent = true }
)

-- current date time notify
key_map(
  "n",
  "<leader>dt",
  ":lua require('joel.funcs').notify_current_datetime()<CR>",
  { noremap = true, silent = true }
)

-- Open File Name under cursor in vert split
key_map("n", "<leader>gf", ":vs <cfile><CR>", { noremap = false, silent = true })

-- treesitter-unit select maps
key_map("x", "iu", ':lua require"treesitter-unit".select()<CR>', { noremap = true })
key_map("x", "au", ':lua require"treesitter-unit".select(true)<CR>', { noremap = true })
key_map("o", "iu", ':<c-u>lua require"treesitter-unit".select()<CR>', { noremap = true })
key_map("o", "au", ':<c-u>lua require"treesitter-unit".select(true)<CR>', { noremap = true })

-- one of the greatest commands ever
key_map("n", "<space>t", ":TSHighlightCapturesUnderCursor<CR>", { noremap = true, silent = true })

-- write only if changed
key_map("n", "<Leader>w", ":up<CR>", { noremap = true })
-- quit (or close window)
key_map("n", "<Leader>q", ":q<CR>", { noremap = true, silent = true })

-- Gitsigns maps
-- now in Gitsigns setup in config, see: https://github.com/lewis6991/gitsigns.nvim/commit/58e5d6d85e429bfc78fc425dff6d4053ed41753f

-- toggle neoclip - https://github.com/AckslD/nvim-neoclip.lua#startstop
key_map("n", ",tn", [[<Cmd>lua require('neoclip').toggle()<CR>]], { noremap = true, silent = true })

-- use ZQ for :q! (quit & discard changes)
-- Discard all changed buffers & quit
key_map("n", "<Leader>Q", ":qall!<CR>", { noremap = true, silent = true })
-- write all and quit
key_map("n", "<Leader>W", ":wqall<CR>", { noremap = true, silent = true })

-- @TODOUA: figure out the semantics of <space> vs <leader>
--- ',' comma seems to have a pattern as a leader

--  **Buffer Stuff****
--- <C-6> is toggle current and alt(last viewed)
--- Go to next buffer - Skip Terminal buffers in specified splits (settings aug: UnlistSplitTerms )
key_map("n", "<Leader><right>", [[<Cmd>bnext<CR>]], { noremap = true, silent = true })
-- go to previous buffer - skip terminal buffers in splits (settings aug: UnlistSplitTerms )
key_map("n", "<Leader><left>", [[<Cmd>bprevious<CR>]], { noremap = true, silent = true })

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
key_map("n", "<leader>gp", ":G push origin m", { noremap = false })
-- use telescope git_bcommits with vsp also
key_map("n", "<space>do", ":Gvdiffsplit!<cr>", { noremap = true, silent = true })

-- open file in directory of current file
key_map("n", "<leader>e", ":e %:h/", { noremap = false, silent = false })
key_map("n", "<leader>v", ":vs %:h/", { noremap = false, silent = false })
-- Note: use :Di(rbuf) to edit directory via a buffer

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

-- open split below, slightly smaller
key_map("n", ",-", ":23sp<CR><C-w><down>", { noremap = true, silent = true })

-- ** Terminal open maps** - see <leader>tx for close terminal
-- open 2 vertically split terminals
key_map(
  "n",
  ",\\",
  [[<Cmd>70vsp <bar>terminal<CR>:set winfixheight<CR>:let b:isSplit=1<CR>:sp<bar>terminal<CR>:let b:isSplit=1<CR>]],
  { noremap = true, silent = true }
)

-- open new Neovim Terminal in vsplit or split
key_map("n", "<leader>tv", [[<Cmd>vsp <bar>terminal<CR>]], { noremap = false, silent = true })

key_map("n", "<leader>t", [[<Cmd>sp <bar>terminal<CR>]], { noremap = false, silent = true })
-- ** end Terminal open maps

-- yank all in buffer
key_map("n", "<leader>a", ":%y<cr>", { noremap = false, silent = true })

-- expands to dir of current file in cmd mode
key_map("c", "%%", [[getcmdtype() == ':' ? expand('%:h').'/' : '%%']], { noremap = true, expr = true })

-- Move between Vimdows
key_map("n", "<up>", "<C-w><up>", { noremap = false })
key_map("n", "<down>", "<C-w><down>", { noremap = false })
key_map("n", "<left>", "<C-w><left>", { noremap = false })
key_map("n", "<right>", "<C-w><right>", { noremap = false })

-- resize vsplits
key_map("n", "<C-H>", ":vertical resize -2<CR>", { noremap = false })
key_map("n", "<C-L>", ":vertical resize +2<CR>", { noremap = false })

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
-- toggle foldcolumn - Toggles are usually leader ,t + one-letter identifier
key_map("n", ",tf", ":lua require'joel.settings'.toggle_fold_col()<CR>", { noremap = true, silent = true })
-- toggle colorizer: will be toggled on by default for appropriate fts
key_map("n", ",tc", ":ColorToggle<CR>", { noremap = false, silent = true })
-- toggle IndentBlankline → `:set list` manually as needed
key_map("n", ",ti", ":IndentBlanklineToggle<CR>", { noremap = true, silent = true })
-- toggle scope highlight
key_map("n", ",th", ":lua require'treesitter-unit'.toggle_highlighting()<CR>", { noremap = true, silent = true })

-- Use <Del> to Esc from (almost) all the things
-- Note: <Esc> does not exit terminal mode by default
key_map("n", "<Del>", "<Esc>", { noremap = true })
key_map("v", "<Del>", "<Esc>gV", { noremap = true })
key_map("o", "<Del>", "<Esc>", { noremap = true })
key_map("c", "<Del>", "<C-C><Esc>", { noremap = true })
key_map("i", "<Del>", "<Esc>`^", { noremap = true })
key_map("t", "<Del>", "<C-\\><C-n>", { noremap = true })
-- please iTerm hotkey windows
key_map("t", "<Esc>", "<C-\\><C-n>", { noremap = true })

-- vsnip jump through snippets with <Tab>
key_map("i", "<Tab>", [[vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>']], { noremap = false, expr = true })

key_map("s", "<Tab>", [[vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>']], { noremap = false, expr = true })

key_map(
  "i",
  "<S-Tab>",
  [[vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>']],
  { noremap = false, expr = true }
)

key_map(
  "s",
  "<S-Tab>",
  [[vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>']],
  { noremap = false, expr = true }
)

-- Back in jumplist - great for after 'jumping to definition'
-- these makes since with my keyboard → Kinesis Advantage 2
key_map("n", "<leader><bs>", "<C-o>", {
  noremap = false,
  silent = true,
})

-- Forward in jumplist
key_map("n", "<leader><space>", "<C-i>", {
  noremap = false,
  silent = true,
})

-- quick diff since last write
key_map("n", "<leader>c", ":w !diff % -<cr>", { noremap = true })

-- Join lines and restore cursor location
key_map("n", "J", "mjJ`j", { noremap = true })
