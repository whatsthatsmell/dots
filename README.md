![Neovim version](https://img.shields.io/badge/Neovim-0.6.x-57A143?style=plastic&logo=neovim)
![Lua](https://img.shields.io/badge/lua-%232C2D72.svg?style=plastic&logo=lua&logoColor=white)
## Public version of Code Smell dotfiles
### News:
**[virtual vim conf live October 29th/30th](https://www.vimconf.live/) is almost here. Click the link to see the agenda and register. It's free! Tons of scheduled goodness!**

### Current Setup 
_(Last Updated 20-Oct-2021 or more recently. I always forget to update this. Look at the GitHub dates 😃):_
- [Neovim](https://neovim.io/) - _Important Note_: these dotfiles target bleeding edge Neovim APIs. I try to update these runtime files as soon as the Neovim team pushes changes (including & especially breaking) to [their master branch](https://github.com/neovim/neovim/commits/master) and I pull the latest. 
  - I usually pull the latest a few times per week or if I see that a particularly juicy PR has landed. I do test Neovim feature branches. But, only code that works with `Neovim → master` will be pushed to this repo. Neovim 0.5 should work with most of what you see here. 
  - However, a lot of API changes are coming out of Neovim on the 0.6 track (master). So, I'd recommend using [Neovim Nightly](https://github.com/neovim/neovim/releases/tag/nightly) to use all the goodness in these dotfiles. Or, [building from source](https://github.com/neovim/neovim#install-from-source) - [Code Smell video instructions](https://youtu.be/wep2_b_QU7Q). It's unlikely that I am more than a day or 2 behind. 
  - I will do my best to indicate the Neovim commit that I am on. Expect to start seeing something like `NVIM v0.6.0-dev+493-g035d82e0d` here or within the commit message or in a source file comment. 
	- Theme: [codesmell_dark](https://github.com/whatsthatsmell/codesmell_dark.vim)
	- Config: Lua
	- Package Management: Packer
	- Notable Plugins: `Telescope 🔭`, `gitsigns` and `nvim-cmp`
- [Alacritty](https://github.com/alacritty/alacritty) and an [iTerm Hotkey Window](https://www.iterm2.com/)
    - Zsh Theme: [code-smell.zsh-theme](https://github.com/whatsthatsmell/dots/blob/master/public%20dots/zsh/code-smell.zsh-theme)
- Zsh  
    - [Oh My Zsh](https://ohmyz.sh/) - _Phasing it out_

_I update my dot files on a fairly regular basis. Usually small changes. They're in a private repo. However, I try to keep _these_ up-to-date. Use Git's history to look at files as they were in the past. If you are looking for a file that is not here anymore, please look through the Git history. [Call me out in the comments](https://www.youtube.com/CodeSmell) if you see something that isn't in this repo._

The Neovim command that you need if you love to work on your configs (you know you do) is:
```lua
-- The greatest neovim command ever (other than :Telescope).
-- https://github.com/nvim-treesitter/playground#show-treesitter-and-syntax-highlight-groups-under-the-cursor
vim.api.nvim_set_keymap("n", ",t", ":TSHighlightCapturesUnderCursor<CR>", { noremap = true, silent = true })
```

https://git.io/CodeSmell
