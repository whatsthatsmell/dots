![Neovim version](https://img.shields.io/badge/Neovim-0.6.x-57A143?style=plastic&logo=neovim)
![Lua](https://img.shields.io/badge/lua-%232C2D72.svg?style=plastic&logo=lua&logoColor=white)
### NeoNews:
- [Neovim 0.6 release stream TODAY (11/30/21 at 17:00 UTC/12:00 pm EST)](https://neovim.discourse.group/t/neovim-0-6-release-stream-11-30-21-at-17-00-utc-12-00-pm-est/1535)
- 🔭 [Telescope's `builtin.file_browser` will be removed December 19th](https://github.com/nvim-telescope/telescope.nvim/issues/1470#issuecomment-974147513)
# Public version of Code Smell dotfiles

## Current Setup 
_Last Updated: 30-Nov-2021 or more recently._
- [Neovim](https://neovim.io/) - _Important Note_: these Dotfiles target bleeding edge Neovim APIs. I try to update these runtime files as soon as the Neovim team pushes changes (including & especially breaking) to [their master branch](https://git.io/NeovimHEAD) and I pull the latest. 
  - I usually pull the latest a few times per week or if I see that a particularly juicy PR has landed. I do test Neovim feature branches. But, only code that works with `Neovim → master` will be pushed to this repo. [Neovim 0.5.1](https://github.com/neovim/neovim/releases/tag/v0.5.1) should work with most of what you see here. 
  - However, a lot of API changes are coming out of Neovim on the 0.6 track (master). So, I'd recommend using [Neovim Nightly](https://github.com/neovim/neovim/releases/tag/nightly) to use all the goodness in these Dotfiles. Or, [building from source](https://github.com/neovim/neovim#install-from-source) - [Code Smell video instructions](https://youtu.be/wep2_b_QU7Q). It's unlikely that I am more than a day or 2 behind. 
  - The Neovim commit that I am on: `NVIM v0.6.0-dev+647-gb16b7021e`
	- Theme: [codesmell_dark](https://github.com/whatsthatsmell/codesmell_dark.vim)
	  - `Telescope`, `nvim-cmp`, `GitSigns`, many other plugins and builtins are colored from this theme using `Treesitter 🌲` 
	- Config: [Lua](https://neovim.io/doc/user/lua.html)
	- Package Management: [Packer](https://github.com/wbthomason/packer.nvim)
	- Featuring: `Telescope 🔭`, `gitsigns`, `nvim-cmp`, `Treesitter` and all the LSP goodness
- [Alacritty](https://github.com/alacritty/alacritty) and 2 [iTerm Hotkey Windows](https://www.iterm2.com/)
    - Zsh Theme: [code-smell.zsh-theme](https://github.com/whatsthatsmell/dots/blob/master/public%20dots/zsh/code-smell.zsh-theme)
- Zsh  
    - [Oh My Zsh](https://ohmyz.sh/) - _For now_

_I update my private Dotfiles on a regular basis. They're in a private repo. However, I try to keep these up-to-date. Use Git's history to look at files as they were in the past. If you are looking for a file that is not here anymore, please look through the Git history. [Call me out in the comments](https://www.youtube.com/CodeSmell) if you see something that isn't in this repo._

The `gitsigns` map that will make your life better:
```lua
-- toogle virtual current line blame → <leader>hb for Full line blame
key_map("n", ",tb", [[<Cmd>lua require'gitsigns'.toggle_current_line_blame()<CR>]], { noremap = true, silent = true })
```

https://git.io/CodeSmell
