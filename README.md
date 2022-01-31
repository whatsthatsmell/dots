![Neovim version](https://img.shields.io/badge/Neovim-0.7.x-57A143?style=plastic&logo=neovim)
![Lua](https://img.shields.io/badge/lua-%232C2D72.svg?style=plastic&logo=lua&logoColor=white)
![YouTubeSubs](https://img.shields.io/youtube/channel/subscribers/UC4S7Fm5x-WXRCWP6MjK6k2A?style=social)

### NeoNews:
- [Neovim 0.6.1 has released](https://github.com/neovim/neovim/releases/tag/v0.6.1)
### RustyNews:
- [Rust 1.58.1 Stable Released](https://blog.rust-lang.org/2022/01/20/Rust-1.58.1.html) *_you should use nightly though_
# Public version of Code Smell dotfiles

## Current Setup 
_Last Updated: 31-Jan-2022 or more recently._
- **[Neovim](https://neovim.io/)** - _Important Note_: these Dotfiles target bleeding edge Neovim APIs. I try to update these runtime files as soon as the Neovim team pushes changes (including & especially breaking) to [their master branch](https://git.io/NeovimHEAD) and I pull the latest. 
  - I usually pull the latest a few times per week or if I see that a particularly juicy PR has landed. I do test Neovim feature branches. But, only code that works with `Neovim → master` will be pushed to this repo. [Neovim 0.6.1](https://github.com/neovim/neovim/releases/tag/v0.6.1) should work with most of what you see here. 
  - However, a lot of API changes are coming out of Neovim on the 0.6 track (master). So, I'd recommend using [Neovim Nightly](https://github.com/neovim/neovim/releases/tag/nightly) to use all the goodness in these Dotfiles. Or, [building from source](https://github.com/neovim/neovim#install-from-source) - [Code Smell video instructions](https://youtu.be/wep2_b_QU7Q). It's unlikely that I am more than a day or 2 behind. 
  - The Neovim [commit](https://github.com/neovim/neovim/commit/2a58e62145d64245e23825ca717aecf8eaaaddad) that I am on: `NVIM v0.7.0-dev+985-g2a58e6214`
	- Theme: [codesmell_dark](https://github.com/whatsthatsmell/codesmell_dark.vim)
	  - `Telescope`, `nvim-cmp`, `GitSigns`, many other plugins and builtins are colored from this theme using `Treesitter 🌲` 
	- Config: [Lua](https://neovim.io/doc/user/lua.html)
	- Package Management: [Packer](https://github.com/wbthomason/packer.nvim)
	- Featuring: `Telescope 🔭`, `gitsigns`, `nvim-cmp`, `Treesitter` and all the LSP goodness
- **[Rust](https://www.rust-lang.org/)** 🦀⚙
	- [compiler](https://rustup.rs/): `rustc 1.60.0-nightly (08df8b81d 2022-01-30)`
  - [rust-analyzer](https://rust-analyzer.github.io/manual.html#nvim-lsp): `rust-analyzer 0808ade4e 2022-01-31 dev` 
- [Alacritty](https://github.com/alacritty/alacritty) and 2 [iTerm Hotkey Windows](https://www.iterm2.com/)
    - Zsh Theme: [code-smell.zsh-theme](https://github.com/whatsthatsmell/dots/blob/master/public%20dots/zsh/code-smell.zsh-theme)
- Zsh  
    - [Oh My Zsh](https://ohmyz.sh/) - _For now_

_I update my private Dotfiles on a regular basis. They're in a private repo. However, I try to keep these up-to-date. Use Git's history to look at files as they were in the past. If you are looking for a file that is not here anymore, please look through the Git history. [Call me out in the comments](https://www.youtube.com/CodeSmell) if you see something that isn't in this repo._

Another awesome feature from [gitsigns](https://github.com/lewis6991/gitsigns.nvim/commit/584e1abfb9a4bc7f42409c4164f99028b57330b2) and a map for it:
```lua
-- toggle Virtual deleted lines
key_map("n", ",td", [[<Cmd>lua require'gitsigns'.toggle_deleted()<CR>]], { noremap = true, silent = true })
```

https://git.io/CodeSmell
