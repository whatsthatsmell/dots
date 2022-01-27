# ZSH Functions

# get trackpad battery % - not currently using but leaving for others for now.
# tpb() {
#   BATTLVL=$(ioreg -r -l -n AppleHSBluetoothDevice | rg '"BatteryPercent" = |^  \|   "Bluetooth Product Name" = ' | sed 's/  |   "Bluetooth Product Name" = "Magic Trackpad 2"/  \| Trackpad:/' | sed 's/  |   |       "BatteryPercent" = / /')
#   BATTRPT=${BATTLVL//[$'\t\r\n|']/} # Strips all instances of tab, newline, return.
#   echo $BATTRPT%
# }

# zd - use zoxide & FZF to find and go to directory
# Not sure why zoxide query -i with FZF doesn't CD
zd() {
  local dir
  dir=$(zoxide query -l | fzf )
  cde $dir
}

# CD into {dir} and then exag
cde() {
  cd $1
  exag
}

# create new rust bin proj, move in to it then open src/main.rs & toml
cn() {
  cargo new $1
  cd $1
  nvim src/main.rs Cargo.toml
}

# create new rust lib proj, move in to it then open src/lib.rs & toml
cnl() {
  cargo new $1 --lib
  cd $1
  nvim src/lib.rs Cargo.toml
}

# rust doc find:  rustup doc get result or search
rdf() {
  local query
  query=$1
  rustup doc $1 || (echo "Searching..." && open "https://doc.rust-lang.org/std/?search=$query")
}

# search the cargo docs
cargodocs() {
  open "https://doc.rust-lang.org/cargo/index.html?search=$1"
}

# set Active Browser Tab: @titleText → finds tab with title that contains the text
abt() {
  osascript ~/dotfiles/osascripts/tabact.scpt $1
}

# screenshot
sc() {
  screencapture -x ~/Screenshots/$1
}

# --- Github CLI goodness ---
# select and go to gh issue on web
ghi() {
  local item
  item=$(gh issue list | fzf | awk '{print $1}')
  gh issue view $item --web
}

# Rerun a Github workflow
ghrr() {
  local runid
  runid=$(gh run list | fzf | cut -f7)
  if [[ -n $runid ]]
  then
    gh run rerun $runid
  fi
}

# select a PR and approve it after a short sleep
ghprsa() {
  local prid
  prid=$(gh pr list -L100 | fzf | cut -f1)
  if [[ -n $prid ]]
  then
    sleep 635 && gh pr review $prid --approve
  fi
}

# select from all PRs and view in vim
ghprl() {
  local prid
  prid=$(gh pr list -L100 | fzf | cut -f1)
  if [[ -n $prid ]]
  then
    gh pr view $prid | nvim -R -c 'set ft=markdown' -c 'norm! zt' -
  fi
}

# select from all PRs and comment (mainly used for dependabot)
ghprc() {
  local prid
  prid=$(gh pr list -L100 | fzf | cut -f1)
  if [[ -n $prid ]]
  then
    gh pr comment $prid -e 
  fi
}

# select from PRs needing my review and view in vim
ghprr() {
  local prid
  prid=$(gh pr list -L100 --search "is:open is:pr review-requested:@me" | fzf | cut -f1)
  if [[ -n $prid ]]
  then
    gh pr view $prid | nvim -R -c 'set ft=markdown' -c 'norm! zt' -
  fi
}

# view GH issue in Vim
ghiv() {
  gh issue view $1 | nvim -R -c 'set ft=markdown' -c 'norm! 8jzt' -
}

# view GH issue in browser
ghib() {
  gh issue view --web $1
}

# end gh cli goodness --

# create file, add to repo and open
tgav() {
  touch $1
  git add $1
  nvim $1
}

# take, npm init and git init and ignore node_modules
tng() {
  take $1 && npm init -y && git init && echo "node_modules" >> .gitignore
}

# see environment variables
envs() {
 # ps eww -o command | tr ' ' '\n'
 printenv | fzf
}

# see node processes
nodes() {
  #	ps -aef | Rg 'node' --colors 'match:fg:magenta'
  ps wup $(pgrep -x node)
}

# get 12 newest or hottest posts from @subreddit & open selection in browser
# ex: > reddit neovim new
# @subreddit - Required (should default to `neovim` )
# @filter - new(default) | hot | or any listing filter: https://www.reddit.com/dev/api/#GET_hot - Optional
reddit() {
  local filter=${2:-new}
  local json
  local url
  # TODO: get a preview with `selftext`-->`\t\(.data.selftext[:30])`
  # TODO: make `limit` a variable
  # Note: Using SauceCodePro reddit icon in list items. Remove or replace as needed.
  json=$(curl -s -A 'Reddit Post Picker' "https://www.reddit.com/r/$1/$filter.json?limit=12" | jq -r '.data.children| .[] | " \(.data.title)\t\(.data.permalink)"')
  url=$(echo "$json" | fzf --delimiter='\t' --with-nth=1 | cut -f2)
  if [[ -n $url ]]; then
    open "https://www.reddit.com$url"
  fi
}

# Shorten Github URL with vanity (url, vanity code) - saves to clipboard! - MacOS - use `pbcopy` equiv for your OS
ghurl() {
  curl -i -s https://git.io -F "url=$1" -F "code=$2" | rg "Location" | cut -f 2 -d " " | pbcopy
}

# get JSON response from route and make it pretty
csjq() {
  curl -s $1 | jq
}

# changing dirs conditionally
# cdf - cd into the directory of the selected file
cdf() {
  local file
  local dir
  file=$(fzf +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
}

# find all git repos, select one and CD to its parent dir
cdg() {
  local file
  local dir
  file=$(fd -H -g .git | fzf) && dir=$(dirname "$file") && cd "$dir"
}

# look up Git worktrees and CD to selected! This was the best idea ever - 
td() {
  local wtdir
  wtdir=$(git worktree list | fzf | awk '{print $1}')
  if [[ -n $wtdir ]]; then
    cd "$wtdir"
  fi
}

# https://github.com/jesseduffield/lazygit#changing-directory-on-exit
lg()
{
    export LAZYGIT_NEW_DIR_FILE=~/.lazygit/newdir

    lazygit "$@"

    if [ -f $LAZYGIT_NEW_DIR_FILE ]; then
            cd "$(cat $LAZYGIT_NEW_DIR_FILE)"
            rm -f $LAZYGIT_NEW_DIR_FILE > /dev/null
    fi
}

# [WIP] find vim-related help. Works but context is not helping. The query is not shown in preview. Only returns path. 
fvh() {
  rg "$1" --ignore-case --files-with-matches --no-messages ~/notes/ ~/dotfiles/ ~/.vim/ ~/.config/nvim/ /usr/local/Caskroom/neovim-nightly/latest/nvim-osx64/share/nvim/runtime/doc/ ~/vim-dev/ | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 6 '$1' || rg --ignore-case --pretty --context 6 '$1' {}" --preview-window=up:50% --multi --select-1 --exit-0
}

# for `vg` grep- find-in-file(s)
fif() {
  if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
  rg --ignore-case --files-with-matches --no-messages "$1" | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 6 '$1' || rg --ignore-case --pretty --context 6 '$1' {}" --preview-window=right:60% --multi --select-1 --exit-0
}

# search for local Vim help using fvh
vh() {
  local file
  file=$(fvh $1)
  if [[ -n $file ]]
  then
    nvim $file -c /$1 -c 'norm! n zz'
  fi
}

# find in files - open in Vim - go to 1st search result
# vim - grep - takes a query to grep
vg() {
  local file
  file=$(fif $1)
  if [[ -n $file ]]
  then
    nvim $file -c /$1 -c 'norm! n zz'
  fi
}

# find a file and open it fzf → fd → Vim -- no args, looks in cwd - rg to highlight etc
vf() {
  IFS=$'\n' files=($(fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 6 '$1' || rg --ignore-case --pretty --context 6 '$1' {}" --preview-window=right:60%  --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-nvim} "${files[@]}"
}

# search notes and open it in nvim
vn() {
  local note
  note=$(fd . '/Users/joel/notes' | fzf)
  if [[ -n $note ]]
  then
    nvim $note
  fi
}

# list vim sessions and select one to open
vs() {
  local ses
  ses=$(fd . '/Users/joel/vim-sessions' | fzf)
  if [[ -n $ses ]]
  then
    nvim -S $ses
  fi
}

# todoist cli - list todos then show detail
# https://github.com/sachaos/todoist#keybind
todos() {
  local todo
  todo=$(todoist list | fzf | awk '{print $1}')
  if [[ -n $todo ]]
  then
    todoist show $todo
  fi
}

# find rust crate and install
rc() {
  local crate
  crate=$(cargo search $1 | fzf | awk '{print $1}')
  cargo install $crate
}

# find word by partial string and pbcopy
word() {
  rg $1 /usr/share/dict/words | fzf | pbcopy
}

# fkill - kill processes - list only the ones you can kill. 
fkill() {
  local pid 
  if [ "$UID" != "0" ]; then
    pid=$(ps -f -u $UID | sed 1d | fzf -m | awk '{print $2}')
  else
    pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
  fi  

  if [ "x$pid" != "x" ]
  then
    echo $pid | xargs kill -${1:-9}
  fi  
}

# TEMP TRIAL of f() and fm() ---
# Use fd and fzf to get the args to a command.
# Works only with zsh
# Examples:
# f mv # To move files. You can write the destination after selecting the files.
# f 'echo Selected:'
# f 'echo Selected music:' --extention mp3
# fm rm # To rm files in current directory
# @TODO: I am not using this & I need to or remove
f() {
  sels=( "${(@f)$(fd "${fd_default[@]}" "${@:2}"| fzf)}" )
  test -n "$sels" && print -z -- "$1 ${sels[@]:q:q}"
}

# @TODO: See above. Kill it? Use it?
# Like f, but not recursive.
fm() f "$@" --max-depth 1

# Deps - may not need these
alias fz="fzf-noempty --bind 'tab:toggle,shift-tab:toggle+beginning-of-line+kill-line,ctrl-j:toggle+beginning-of-line+kill-line,ctrl-t:top' --color=light -1 -m"
fzf-noempty () {
  local in="$(</dev/stdin)"
  test -z "$in" && (
  exit 130
  ) || {
    ec "$in" | fzf "$@"
  }
}

ec () {
  if [[ -n $ZSH_VERSION ]]
  then
    print -r -- "$@"
  else
    echo -E -- "$@"
  fi
}

# --- end trial

# fgco - checkout git branch/tag, w/ preview showing commits between the tag/branch & HEAD
fgco() {
  local tags branches target
  branches=$(
  git --no-pager branch --all \
    --format="%(if)%(HEAD)%(then)%(else)%(if:equals=HEAD)%(refname:strip=3)%(then)%(else)%1B[0;34;1mbranch%09%1B[m%(refname:short)%(end)%(end)" \
    | sed '/^$/d') || return
      tags=$(
      git --no-pager tag | awk '{print "\x1b[35;1mtag\x1b[m\t" $1}') || return
      target=$(
      (echo "$branches"; echo "$tags") |
        fzf --no-hscroll --no-multi -n 2 \
        --ansi --preview="git --no-pager log -150 --pretty=format:%s '..{2}'") || return
              git checkout $(awk '{print $2}' <<<"$target" )
}

# delete a branch, works like fgco!
fgdb() {
  local tags branches target
  branches=$(
  git --no-pager branch --all \
    --format="%(if)%(HEAD)%(then)%(else)%(if:equals=HEAD)%(refname:strip=3)%(then)%(else)%1B[0;34;1mbranch%09%1B[m%(refname:short)%(end)%(end)" \
    | sed '/^$/d') || return
      tags=$(
      git --no-pager tag | awk '{print "\x1b[35;1mtag\x1b[m\t" $1}') || return
      target=$(
      (echo "$branches"; echo "$tags") |
        fzf --no-hscroll --no-multi -n 2 \
        --ansi --preview="git --no-pager log -150 --pretty=format:%s '..{2}'") || return
              git branch -D $(awk '{print $2}' <<<"$target" )
}

# from the rga ripgrep-all README - integrating with FZF for PDF etc greppin'
rgaf() {
  RG_PREFIX="rga --files-with-matches"
  local file
  file="$(
  FZF_DEFAULT_COMMAND="$RG_PREFIX '$1'" \
    fzf --sort --preview="[[ ! -z {} ]] && rga --pretty --context 5 {q} {}" \
    --phony -q "$1" \
    --bind "change:reload:$RG_PREFIX {q}" \
    --preview-window="70%:wrap"
      )" &&
        # might want to convert to text and open the text file instead or as an option
              echo "opening $file" &&
                open "$file"
}

