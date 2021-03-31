# create new rust proj, move in to it & open main/lib & toml
cn() {
  cargo new $1
  cd $1
  mkdir tests
  cp ../lib_tmpl.rs src/lib.rs
  nvim src/main.rs src/lib.rs Cargo.toml
}

cnl() {
  cargo new $1 --lib
  cd $1
  mkdir tests
  nvim src/lib.rs Cargo.toml
}

# rust doc find:  rustup doc get result or search
rdf() {
	local query
	query=$1
  rustup doc $1 || (echo "Searching..." && open "https://doc.rust-lang.org/std/?search=$query")
}

# screenshot
sc() {
	screencapture -x ~/Screenshots/$1
}
# -- gh cli goodness --
# select and go to gh issue on web
ghi() {
  local item
  item=$(gh issue list | fzf | awk '{print $1}')
  gh issue view $item --web
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
	ps eww -o command | tr ' ' '\n'
}

# see node processes
nodes() {
	#	ps -aef | Rg 'node' --colors 'match:fg:magenta'
	ps wup $(pgrep -x node)
}

#get last 10 reddit post titles from $1 subreddit
reddit() {
curl -s -A 'commandline reader' "https://www.reddit.com/r/$1/new.json?limit=10" \
  | jq '.data.children| .[] | .data.title' \
}

# get JSON response from route and make it pretty
csjq() {
	curl -s $1 | jq
}

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

# for `vg` grep- find-in-file(s)
fif() {
	if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
	rg --ignore-case --files-with-matches --no-messages "$1" | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 6 '$1' || rg --ignore-case --pretty --context 6 '$1' {}" --preview-window=right:60% --multi --select-1 --exit-0
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

# find a file and open it fzf → fd → Vim -- no args, looks in cwd
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

# TEMP TRIAL of f() and fm()
# Use fd and fzf to get the args to a command.
# Works only with zsh
# Examples:
# f mv # To move files. You can write the destination after selecting the files.
# f 'echo Selected:'
# f 'echo Selected music:' --extention mp3
# fm rm # To rm files in current directory
f() {
    sels=( "${(@f)$(fd "${fd_default[@]}" "${@:2}"| fzf)}" )
    test -n "$sels" && print -z -- "$1 ${sels[@]:q:q}"
}

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

# fco_p(review) - checkout git branch/tag, w/ preview showing commits between the tag/branch & HEAD
fco() {
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

