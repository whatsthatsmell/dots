# custom aliases
alias -s {js,json}=nvim
alias -s {c,h}=nvim
alias -s {rs,toml}=nvim
alias -s zsh=nvim
alias -s vim=nvim
alias -s txt=nvim
alias -s {md,MD}=nvim
alias c='cargo'
alias vft='floaterm'
alias vdp='cd ~/vim-dev/plugins'
# https://github.com/sachaos/todoist#keybind
alias gyhc='git rev-parse HEAD | pbcopy'
alias ta='todoist add'
alias rdc='rustup doc --core'
alias rds='rustup doc --std'
alias rud='rustup doc'
alias ru='rustup'
alias ruu='rustup update'
alias rus='rustup show'
alias rdb='rust-lldb'
alias mp='multipass'
alias mps='multipass shell'
alias mpl='multipass list'
alias dud='du -d 1 -h'
alias ldot='exa -ld .*'
alias yp='pwd|pbcopy'
alias vt='nvim +terminal'
alias vd='nvim -d'
alias vdro='nvim -d -R'
alias triage='nvim ~/notes/rust/triage-template'
alias cpwd='pwd|pbcopy'
alias ppwd='pbpaste'
alias vp='pbpaste | nvim'
alias v='nvim'
alias vsl='nvim -S ~/vim-sessions/latest.vim'
alias gCal='cd ~/oss/gCal'
alias cfg='cd ~/.config'
alias cfg='cd ~/.config'
alias cnv='cd ~/.config/nvim'
alias gijs='git init && echo "node_modules" >> .gitignore'
alias ng='npm init -y && git init && echo "node_modules" >> .gitignore'
alias hack='history -75 | rg'
alias dots='zsh ~/dotfiles/index.txt'
# todo: make gdot* for cs/dots
alias gdotc='git -C ~/dotfiles commit -a -m'
alias gdots='git -C ~/dotfiles status'
alias glprs='git log -p --reverse --stat'
alias glps='git log -p --stat'
alias cpnotes='cp -R  ~/notes/ ~/Dropbox/notes'
alias cprs='rsync -a ~/rusty ~/Dropbox/tech --exclude rust-sources'
alias nij='node inspect node_modules/.bin/jest --runInBand'
alias jlc='jest --config=jest.local.js'
alias ghil='gh issue list'
alias exat='exa -aTI "node_modules|.git|coverage"'
alias exal='exa -allI "node_modules|.git|coverage"'
alias exaf='exa -allFI "node_modules|.git|coverage"'
alias vc='nvim ~/.config/nvim/init.vim'

# RIP .vimrc
nvc() { echo 'RIP .vimrc - use the alias: vc' }

alias gt='git difftool --no-prompt' #delta
alias tl1='tree -L 1'
alias cov='open coverage/index.html'
alias note='nvim ~/notes/'
alias arec='asciinema rec'
