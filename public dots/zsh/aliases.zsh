# Custom ZSH Aliases
alias -s txt=nvim
alias -s vim=nvim
alias -s zsh=nvim
alias -s zshrc=nvim
alias -s {c,h}=nvim
alias -s {js,json}=nvim
alias -s {md,MD}=nvim
alias -s {rs,toml}=nvim
alias -s yml=nvim
alias -s lua=nvim
alias arec='asciinema rec'
alias c='cargo'
alias cfg='cd ~/.config'
alias cfg='cd ~/.config'
# TODO: move cliclick aliases to functions with options for preset locations
# ... and don't hardcode them, make them work with any size
# cliclick aliases - like a phone pad - MacOS specific - 2560x1440
# 7 8 9
# 4 5 6
# 1 2 3
# click upper-right (should click notification banners)
alias ck='cliclick "c:2525,30"' #legacy
alias ck9='cliclick "c:2525,30"' #alfred: ctrl-alt-shift-n
# click in window top-right but closer to middle
alias ckm='cliclick "c:2005,95"'
# click top middle - will hide menu
alias ck8='cliclick "c:1300,95"'
# like ck8 but just move with no click
alias cm='cliclick "m:1300,95"' #alfred: ctrl-alt-shift-m
# click top left
alias ck7='cliclick "c:150,75"'
# click middle right
alias ck6='cliclick "c:2285,495"'
# click middle middle
alias ck5='cliclick "c:1200,680"'
# click middle left
alias ck4='cliclick "c:200,595"'
# click bottom right in window
alias ckr='cliclick "c:2525,1395"' #legacy
alias ck3='cliclick "c:2525,1395"'
# click bottom middle in window - dock will unhide
alias ck2='cliclick "c:1200,2095"'
# click bottom left in window
alias ck1='cliclick "c:180,1895"'
# -- end cliclick aliases
alias cnv='cd ~/.config/nvim'
alias cov='open coverage/index.html'
alias cpnotes='cp -R  ~/notes/ ~/Dropbox/notes'
alias cprs='rsync -a ~/rusty ~/Dropbox/tech --exclude rust-sources'
alias cpwd='pwd|pbcopy'
alias dots='zsh ~/dotfiles/index.txt'
alias dud='du -d 1 -h'
alias esl='node_modules/.bin/eslint .'
alias exaf='exa -allFI "node_modules|.git|coverage"'
alias xg='exa -a --long --git --group-directories-first --no-permissions --no-user --icons -FI "node_modules|.git|coverage|.DS_Store|.vscode"'
alias exg='exa -a --long --git --group-directories-first --no-permissions --no-user --icons -FI "node_modules|.git|coverage|.DS_Store|.vscode"'
alias exag='exa -a --long --git --group-directories-first --no-permissions --no-user --icons -FI "node_modules|.git|coverage|.DS_Store|.vscode"'
alias exal='exa -allI "node_modules|.git|coverage"'
alias xl='exa -allI "node_modules|.git|coverage"'
alias exat='exa -aTI "node_modules|.git|coverage"'
alias gCal='cd ~/oss/gCal'
alias gdotc='git -C ~/dotfiles commit -a -m'
alias gdots='git -C ~/dotfiles status'
alias ghil='gh issue list'
alias ghweb='gh repo view --web'
alias gijs='git init && echo "node_modules" >> .gitignore'
alias glf='git log --stat'
alias gld='git log -p --stat'
alias glprs='git log -p --reverse --stat'
alias glps='git log -p --stat'
alias gt='git difftool --no-prompt' #delta
alias gwtl='git worktree list'
alias gyhc='git rev-parse HEAD | pbcopy'
alias hack='history -75 | rg'
alias jlc='jest --config=jest.local.js'
alias ldot='exa -ld .*'
alias mdc='make distclean'
alias mj4='make CMAKE_BUILD_TYPE=RelWithDebInfo -j4'
alias smi='sudo make install'
alias mp='multipass'
alias mpl='multipass list'
# not using multipass much, using `mps` in work-related alias
# alias mps='multipass shell'
alias ng='npm init -y && git init && echo "node_modules" >> .gitignore'
alias nij='node inspect node_modules/.bin/jest --runInBand'
alias nn='nnn -eiH'
alias note='nvim -c "lcd ~/notes/" -c "lua require\"joel.telescope\".browse_notes()"'
alias nv='nvim -c "lua require\"joel.telescope\".project_files()"'
alias nun='nvim -u NONE'
alias nvc='cd ~/.config/nvim && nvim ~/.config/nvim/init.lua'
alias ppwd='pbpaste'
alias rdb='rust-lldb'
alias rdc='rustup doc --core'
alias rds='rustup doc --std'
alias ru='rustup'
alias rud='rustup doc'
alias rus='rustup show'
alias ruu='rustup update'
alias ta='todoist add'
alias tl1='tree -L 1'
alias triage='nvim ~/notes/rust/triage-template'
alias v='nvim'
alias vac='nvim ~/.config/alacritty/alacritty.yml'
alias vc='nvim ~/.config/nvim/init.lua'
alias vd='nvim -d'
alias vdp='cd ~/vim-dev/plugins'
alias vdro='nvim -d -R'
alias vp='pbpaste | nvim'
alias vsl='nvim -S ~/vim-sessions/latest.vim'
alias vt='nvim +terminal'
# open nvim with norelativenumber set
alias vnr='nvim -c "set nornu"'
alias yp='pwd|pbcopy'
