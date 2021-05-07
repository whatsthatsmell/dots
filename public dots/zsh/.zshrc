# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
# -- run to get rid of large old sys logs
# sudo rm /private/var/log/asl/*.asl

# Path to your oh-my-zsh installation.
export ZSH="/Users/joel/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# @TODO: Switch to my custom theme
ZSH_THEME="agnoster"
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

# use FZF with todoist cli
source $(brew --prefix)/share/zsh/site-functions/_todoist_fzf
# shell completion for todoist CLI
# PROG=todoist source "$GOPATH/src/github.com/urfave/cli/autocomplete/zsh_autocomplete"
# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions cargo)

source $ZSH/oh-my-zsh.sh

# Change prompt
prompt_dir () {
  prompt_segment blue $CURRENT_FG '%2~'
}
# Context: user@hostname (who am I and where am I)
prompt_context() { }

# User configuration
export MANPAGER='nvim +Man!'
export BAT_PAGER="less -R"
export DELTA_PAGER="less -R"
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

# Apply the command to CTRL-T
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS='--height 64% --layout=reverse --border'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source ~/.iterm2_shell_integration.zsh
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
# bindkey -r '^T'
bindkey '^P' fzf-file-widget
export PATH="/usr/local/opt/llvm/bin:$PATH"
