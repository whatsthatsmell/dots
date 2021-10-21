# -- run to get rid of large old sys logs
# sudo rm /private/var/log/asl/*.asl

# Path to your oh-my-zsh installation.
export ZSH="/Users/joel/.oh-my-zsh"

ZSH_THEME="code-smell"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=7"
# Bat Theme
export BAT_THEME="ansi"
# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Load tab completion
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

  autoload -Uz compinit
#  compinit
fi
# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# TODO: Move to theme file ------->
# TODO: Save locally & source: https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/git.zsh
# Move this to functions file
# Formats string for current git commit short SHA
function git_prompt_short_sha_with_icon() {
  local SHA
  SHA=$(__git_prompt_git rev-parse --short HEAD 2> /dev/null) && echo " $ZSH_THEME_GIT_PROMPT_SHA_BEFORE$SHA$ZSH_THEME_GIT_PROMPT_SHA_AFTER"
}

RPROMPT='$FG[238]$(git_prompt_short_sha_with_icon)%{$reset_color%}'
# Move above to theme file -----------

# User configuration
export MANPAGER='nvim +Man!'
export BAT_PAGER="less -R"
export DELTA_PAGER="less -RS"
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
export EDITOR='nvim'
# fi
# jq - change colors to show better in gruvbox lite
export JQ_COLORS="1;30:1;31:1;32:0;37:0;32:1;30:1;30"
# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# aliases
# alias zshconfig="nvim ~/.zshrc"
# alias ohmyzsh="nvim ~/.oh-my-zsh"
bindkey -v
autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line
bindkey "ç" fzf-cd-widget
bindkey "^F" fzf-cd-widget
# bindkey "^[a" beginning-of-line
# bindkey "^[e" end-of-line
[ -f "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env" ] && source "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env"
# Setting rg as the default source for fzf
# export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'

# use fd instead of rg for file search, rg author says so!
export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_COMPLETION_OPTS='--border --info=inline'
# Use fd (https://github.com/sharkdp/fd) instead of the default find
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

# try out using `exa -T (exa's tree)` with fzf preview on cd **<tab>
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf "$@" --preview 'exa -aT -L=1 {}' ;;
    *)            fzf "$@" ;;
  esac
}
# Apply the command to CTRL-T
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS='--height 64% --layout=reverse --border'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source ~/.iterm2_shell_integration.zsh
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init --path)"
fi
# bindkey -r '^T'
bindkey '^P' fzf-file-widget
export PATH="/usr/local/opt/llvm/bin:$PATH"

# alias for making lls
alias luamake=/Users/joel/vim-dev/sources/lua-language-server/3rd/luamake/luamake

# nnn stuff
export NNN_PLUG="z:autojump;"
export NNN_FIFO="/tmp/nnn.fifo"
# kick-off zoxide
eval "$(zoxide init zsh)"
