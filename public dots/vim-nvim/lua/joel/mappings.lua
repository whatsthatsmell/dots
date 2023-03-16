local key_map = vim.api.nvim_set_keymap
-- @TODOUA: use 0.7's *vim.keymap.set()* API for inline funcs as appropriate
-- FML!
vim.keymap.set("n", "<leader>fml", "<cmd>CellularAutomaton make_it_rain<CR>")

-- Note: Redirect Vim command output to buffer:
-- Example: `:redir > vim.output | highlight | redir END`

-- ** Key Mappings ***
-- *Telescope-related maps at telescope/mappings (for now)

-- *Quickly surround Words*
-- Filetype specific quick surrounds in FTPs
-- vS to surround selection with argument
-- cs'" will change single to double quotes. Flip or change surroundings as needed.
-- ds{surrounding} to remove surroundings
-- Surround word under cursor w/ backticks (required vim-surround)
key_map("n", "<leader>`", "ysiW`", { noremap = false })
-- Surround word under cursor w/ double quotes (required vim-surround)
key_map("n", '<leader>"', 'ysiW"', { noremap = false })
-- Surround word under cursor w/ single quotes (required vim-surround)
key_map("n", "<leader>'", "ysiW'", { noremap = false })
-- copy plus register contents to "c reqister
key_map("n", "<space>c", [[<cmd>let @c=@+<CR>]], { noremap = true })
-- paste from "c
key_map("n", "<space>p", '"cp', { noremap = true })
-- REPLACE: cut inner word to "r & replace with last yanked (including system)
-- Or, visually select and p
key_map("n", ",r", '"rdiwhp', { noremap = true })
-- DELETE: with y,d or c{motion} & it wont replace "0
key_map("n", "_", '"_', { noremap = true })
-- paste last thing yanked(not system copied), not deleted
key_map("n", ",p", '"0p', { noremap = true })
key_map("n", ",P", '"0P', { noremap = true })

-- increment/decrement numberwidth by 2
-- :set nuw +=2
-- :set nuw -=2

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

-- Yank Current File Name - path
key_map("n", "<leader>fp", ":lua require('joel.funcs').yank_current_file_name()<CR>", {
  noremap = true,
  silent = true,
})

-- temp location for user_command for file path yank
vim.api.nvim_create_user_command("FP", "lua require('joel.funcs').yank_current_file_name()", {})

-- Create tasks in todoist using current Visual selection
-- default: create task in 'Neovim' project with 'Neovim' label
key_map("v", "<leader>t", [[<Cmd>lua require'joel.funcs'.create_todoist_task()<CR>]], { noremap = false })
-- create Personal task in todoist
-- @TODOUA: make more robust → a picker for proj, label etc.
key_map(
  "v",
  "<leader>tp",
  [[<Cmd>lua require'joel.funcs'.create_todoist_task({proj_id = 2283751657, label_id = 'Other'})<CR>]],
  { noremap = false }
)

-- create work other task in todoist
-- @TODOUA: make more robust → a picker for proj, label etc.
-- key_map(
--   "v",
--   "<leader>tp",
--   [[<Cmd>lua require'joel.funcs'.create_todoist_task({proj_id = 2277745348, label_id = 'Other'})<CR>]],
--   { noremap = false }
-- )

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

-- a very useful command
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

-- **Buffer Stuff****
-- <C-6> is toggle current and alt(last viewed)
-- Go to next buffer - Skip Terminal buffers in specified splits (settings aug: UnlistSplitTerms )
-- ]b -- unimpaired
-- go to previous buffer - skip terminal buffers in splits (settings aug: UnlistSplitTerms )
-- [b

-- delete current buffer - But, don't close split/window
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
key_map("n", "<leader>gr", ":Gread<Return>", { noremap = true, silent = false })
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
-- save some strokes (not worth losing left/right motion repeat)
-- key_map("v", ";", ":", { noremap = true })
-- key_map("n", ";", ":", { noremap = true })

-- move to first or after last char from insert to insert
key_map("i", "<C-a>", "<Esc>I", { noremap = false })
key_map("i", "<C-e>", "<Esc>A", { noremap = false })

-- no Help when I fat finger F1
key_map("n", "<F1>", "<Esc>", { noremap = false })
key_map("i", "<F1>", "<Esc>", { noremap = false })

-- open split below, short → focus
key_map("n", ",_", ":below 12sp<CR><C-w><down>", { noremap = true, silent = true })

-- open split above, short → focus
key_map("n", ",-", ":above 12sp<CR><C-w><up>", { noremap = true, silent = true })

-- open 47 col LEFT vertical split → new file - convenience
key_map("n", ",vl", ":above 47vne<CR>", { noremap = true, silent = true })
-- *** ...Right → :[N]vne {new_file_name - optional} → New file in right vert split in CWD ***

-- ** Terminal Open Maps** - See <leader>tx for close terminal
-- open 2 vertically split terminals
key_map(
  "n",
  ",\\",
  [[<Cmd>70vsp <bar>terminal<CR>:set winfixheight<CR>:let b:isSplit=1<CR>:sp<bar>terminal<CR>:let b:isSplit=1<CR>]],
  { noremap = true, silent = true }
)

-- open new Neovim Terminal in vsplit or split
key_map("n", "<leader>tv", [[<Cmd>vsp <bar>terminal<CR>]], { noremap = false, silent = true })

-- open short terminal at the bottom of the buffer
key_map("n", "<leader>t", [[<Cmd>11sp <bar>terminal<CR>]], { noremap = false, silent = true })

-- open terminal in new tab
key_map("n", "<C-t>", [[<Cmd>tabnew <bar>terminal<CR>]], { noremap = false, silent = true })
-- ** End Terminal open maps

-- open lazygit in vert split - custom lazygit config uses ctrl-x as menu close
key_map("n", "<space>lg", [[<Cmd>135vsp <bar>terminal lazygit<CR>]], { noremap = true, silent = true })

-- yank all in buffer
key_map("n", "<leader>a", ":%y<cr>", { noremap = false, silent = true })

-- expands to dir of current file in cmd mode
key_map("c", "%%", [[getcmdtype() == ':' ? expand('%:h').'/' : '%%']], { noremap = true, expr = true })

-- Move between Vimdows
key_map("n", "<up>", "<C-w><up>", { noremap = false })
key_map("n", "<down>", "<C-w><down>", { noremap = false })
key_map("n", "<left>", "<C-w><left>", { noremap = false })
key_map("n", "<right>", "<C-w><right>", { noremap = false })

-- Resize Splits
-- CTRL-W <	   decrease current window width N columns
-- CTRL-W >	   increase current window width N columns
-- CTRL-W +	   increase current window height N lines
-- CTRL-W -	   decrease current window height N lines
-- CTRL-W =	   make all windows the same height & width

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
-- change cwd for window to file's git working dir
key_map("n", "<leader>gd", ":Glcd<cr>", { noremap = true, silent = true })
-- toggle foldcolumn - Toggles are usually leader ,t + one-letter identifier
key_map("n", ",tf", ":lua require'joel.settings'.toggle_fold_col()<CR>", { noremap = true, silent = true })
-- toggle colorizer: will be toggled on by default for appropriate fts
key_map("n", ",tc", ":ColorToggle<CR>", { noremap = false, silent = true })
-- toggle IndentBlankline → `:set list` manually as needed
key_map("n", ",ti", ":IndentBlanklineToggle<CR>", { noremap = true, silent = true })
-- toggle NVim IDE Workspace - left panel
key_map("n", ",tw", ":Workspace LeftPanelToggle<CR>", { noremap = true, silent = true })
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

-- Copilot settings and accept map: <ctrl-j> instead of <tab> due to conflict with nvim-cmp
-- @TODOUA: Integrate with cmp and fully Luatize via https://github.com/zbirenbaum/copilot.lua AND...
-- @TODOUA: https://github.com/zbirenbaum/copilot-cmp
-- key_map("i", "<C-J>", [[copilot#Accept("\<CR>")]], { noremap = false, expr = true, script = true })

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

-- Backward in jumplist - great for after 'jumping to definition'
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

-- HighStr maps
-- @TODOUA: check on ability to persist HLs
-- https://github.com/Pocco81/HighStr.nvim#-to-do
vim.api.nvim_set_keymap("v", "<C-h>", ":<c-u>HSHighlight 2<CR>", {
  noremap = true,
  silent = true,
})

-- -- Reference
-- vim.api.nvim_set_keymap(
--     "v",
--     "<F4>",
--     ":<c-u>HSRmHighlight<CR>",
--     {
--         noremap = true,
--         silent = true
--     }
-- )
--
-- vim.api.nvim_set_keymap(
--     "v",
--     "<F4>",
--     ":<c-u>HSRmHighlight rm_all<CR>",
--     {
--         noremap = true,
--         silent = true
--     }
-- )

-- quick diff since last write
key_map("n", "<leader>c", ":w !diff % -<cr>", { noremap = true })

-- Join lines and restore cursor location
key_map("n", "J", "mjJ`j", { noremap = true })

-- open icon/symbol/Emoji/NerdFont picker
-- https://github.com/ziontee113/icon-picker.nvim#available-commands
key_map("n", ",i", ":PickEverything<CR>", { noremap = true, silent = true })
