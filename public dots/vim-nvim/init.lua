-- Always on bleeding edge Neovim from https://git.io/NeovimHEAD

-- *** Neovim Config Luatized *** --
require "joel.plugins"

-- plugins config/setup
require "joel.config"

-- Telescope 🔭
require "joel.telescope"

-- mappings (telescope-related maps loaded via telescope mod)
require "joel.mappings"

-- completion
require "joel.completion"

-- settings(options)
require "joel.settings"

-- globals like P() & DN()
require "joel.globals"

-- ** Key Mappings
-- see mappings.lua and telescope/mappings
-- @TODOUA: Finish refactoring & migrating below to mappings/settings to Lua!
vim.cmd [[
" Duplicate a selection
" Visual mode: D
vmap D y'>p
" Join lines and restore cursor location
nnoremap J mjJ`j

" back in jumplist - great for after 'jumping to definition'
nmap <silent> <leader><bs> <C-o>
" forward in jumplist
nmap <silent> <leader><space> <C-i>

" ** Built-in Term settings**
" open new neovim terminal in vsplit or split
command! -nargs=* T split | terminal <args>
nmap <silent> <leader>t :T<cr>
command! -nargs=* VT vsplit | terminal <args>
nmap <silent> <leader>tv :VT<cr>

" -- this all needs to become one function call --
" -- yank path out of terminal
command! -nargs=* NCD call chansend(b:terminal_job_id, "yp\<cr>")
nmap <silent><leader>D :NCD<cr>
" -- change lcd to term dir (copied from above :NCD)
nmap <silent><leader>F :lcd<c-r>+<cr>
" ---
" end term settings ***

" diff since last write
nnoremap <leader>c :w !diff % -<CR>
" full featured diff
command! DiffOrig let g:diffline = line('.') | vert new | set bt=nofile | r # | 0d_ | diffthis | :exe "norm! ".g:diffline."G" | wincmd p | diffthis | wincmd p
nnoremap <Leader>do :DiffOrig<cr>
" end diffing, delete scratch(or diff2) buffer & go back to location
nnoremap <silent> <leader>dc :bd<cr>:diffoff<cr>:exe "norm! ".g:diffline."G"<cr>
" diff 2 or more windows/splits, end with \dc or just :diffoff to keep file2
nnoremap <leader>dw :windo diffthis<cr>
]]
