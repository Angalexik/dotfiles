# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME=""

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

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

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    archlinux
    encode64
    extract
    pip
    sudo
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# User configuration

eval $(dircolors ~/.dir_colors)

autoload bashcompinit
bashcompinit

# zsh syntax highlighting
NORD8='cyan'
NORD9='blue'
NORD13='yellow'
NORD14='green'

typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[alias]="fg=$NORD8"
ZSH_HIGHLIGHT_STYLES[suffix-alias]="fg=$NORD8"
ZSH_HIGHLIGHT_STYLES[global-alias]="fg=$NORD8"
ZSH_HIGHLIGHT_STYLES[command]="fg=$NORD8"
ZSH_HIGHLIGHT_STYLES[precommand]="fg=$NORD8,underline"
ZSH_HIGHLIGHT_STYLES[builtin]="fg=$NORD8"
ZSH_HIGHLIGHT_STYLES[function]="fg=$NORD8"
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]="fg=$NORD14"
ZSH_HIGHLIGHT_STYLES[single-quoted-argument-unclosed]="fg=$NORD14"
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]="fg=$NORD14"
ZSH_HIGHLIGHT_STYLES[double-quoted-argument-unclosed]="fg=$NORD14"
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]="fg=$NORD13"
ZSH_HIGHLIGHT_STYLES[back-dolllar-quoted-argument]="fg=$NORD13"
ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]="none"
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter-unquoted]="none"
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter-quoted]="none"
ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]="none"
ZSH_HIGHLIGHT_STYLES[globbing]="none"
ZSH_HIGHLIGHT_STYLES[redirection]="fg=$NORD9"
ZSH_HIGHLIGHT_STYLES[reserved-word]="fg=$NORD9"

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8
export HISTSIZE=500000
export SAVEHIST=500000

# Preferred editor for local and remote sessions
export EDITOR='nvim'

export PATH=$PATH:/home/alex/.local/bin:/home/alex/.gem/ruby/2.7.0/bin:/home/alex/.cargo/bin
export GRUB_CMDLINE_LINUX="bluetooth.disable_ertm=1"

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
alias vi='nvim'
alias vim='nvim'
alias vimdiff='nvim -d'
alias nvimrc='nvim ~/.config/nvim/'
alias pyvenv='source .env/bin/activate'
alias pandemo='demopan -w "/home/alex/Mount/Games/Steam/steamapps/common/Team Fortress 2/tf/" --demos "/home/alex/Mount/Games/Steam/steamapps/common/Team Fortress 2/tf/demos"'
alias gradlew='./gradlew'
alias ipa='curl -s https://httpbin.org/ip | jq -r .origin'
alias mntsrv='sudo sshfs -o allow_other,IdentityFile=/home/alex/.ssh/id_ed25519 ubuntu@10.0.1.33:/mnt/knihovno /mnt/Alfons'
alias sudedit='sudoedit'
alias sudeodit='sudoedit'
alias lazyadm='lazygit --use-config-file "$HOME/.config/yadm/lazygit.yml,$HOME/.config/lazygit/config.yml" --work-tree ~ --git-dir ~/.local/share/yadm/repo.git'
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Enable starship prompt
eval "$(starship init zsh)"
# Enable thefuck
eval "$(thefuck --alias)"
