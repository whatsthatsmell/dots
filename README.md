![Neovim](https://img.shields.io/badge/editor-Neovim-green?logo=neovim&style=plastic)
## Public version of Code Smell dotfiles
Current Setup (Last Updated 06-Aug-2021 or more recently. I always forget to update this. Look at the GitHub dates 😃): 
- [Neovim](https://neovim.io/)
	- Theme: [codesmell_dark](https://github.com/whatsthatsmell/codesmell_dark.vim)
	- Config: Lua
	- Package Management: Packer
	- Notable Plugins: `Telescope 🔭`, `gitsigns` and `nvim-compe`
- [Alacritty](https://github.com/alacritty/alacritty) and an [iTerm Hotkey Window](https://www.iterm2.com/)
    - Theme: Custom, see alacritty and iTerm configs
- Zsh  
    - [Oh My Zsh](https://ohmyz.sh/) - _Phasing it out_

_I update my dot files on a fairly regular basis. Usually small changes. They're in a private repo. However, I try to keep these up-to-date. Use Git's history to look at files as they were in the past. I try not to remove files from this repo even if I don't use them anymore. [Call me out in the comments](https://www.youtube.com/c/CodeSmell) if you see something that isn't in this repo._

The Neovim command that you need if you love to work on your configs (you know you do) is:
```lua
-- The greatest neovim command ever (other than :Telescope).
-- https://github.com/nvim-treesitter/playground#show-treesitter-and-syntax-highlight-groups-under-the-cursor
vim.api.nvim_set_keymap("n", ",t", ":TSHighlightCapturesUnderCursor<CR>", { noremap = true, silent = true })
```
