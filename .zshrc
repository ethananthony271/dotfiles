# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Gruvbox Colorscheme
source ~/.config/zsh/gruvbox.zsh

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in zsh plugins
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
zinit light softmoth/zsh-vim-mode
zinit light zsh-users/zsh-completions
zinit light Aloxaf/fzf-tab

# ZSH Vim Mode Configuration
MODE_CURSOR_VIINS="steady bar"
MODE_CURSOR_REPLACE="steady underline"
MODE_CURSOR_VICMD="steady block"
MODE_CURSOR_SEARCH="steady underline"
MODE_CURSOR_VISUAL="steady block"
MODE_CURSOR_VLINE="steady block"

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

# Keybindings
bindkey '^f' autosuggest-accept
bindkey '^k' history-search-backward
bindkey '^p' history-search-backward
bindkey '^j' history-search-forward
bindkey '^[w' kill-region

# History
HISTSIZE=5000
SAVEHIST=$HISTSIZE
HISTFILE=~/.config/zsh/.zsh_history
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Aliases
alias sudo='sudo '

alias ls='eza --group-directories-first'
alias la='eza -a --long --header --git --hyperlink --group-directories-first'
alias lt='eza --hyperlink --tree --group-directories-first --level=3'

alias ga='git add '
alias gs='git status '
alias gd='git diff '
alias gc='git commit -m '
alias gb='git branch '
alias go='git checkout '
alias gp='git push '
alias gm='git merge '
alias gf='git fetch '
alias gz='lazygit'

alias z='zellij'
alias za='zellij attach'
alias zd='zellij delete-session'
alias zD='zellij delete-all-sessions'
alias zk='zellij kill-session'
alias zK='zellij kill-all-sessions'
alias zp='zellij list-aliases'
alias zl='zellij list-sessions'
alias zl='zellij list-sessions'
alias zr='zellij run'
alias ze='zellij run'

alias cat='bat --theme gruvbox-dark '

alias p='python3 '
alias h='fc -ln 1 | fzf | wl-copy'
alias v='nvim'
alias c='clear'
alias q='exit'
alias m='neomutt'
alias d='yazi'
alias n='ncmpcpp'
alias f='fzf --preview "bat --color=always {}"'

alias btl='bluetoothctl'

alias yt-dlp-a='yt-dlp --config-locations ~/.config/yt-dlp/albumconfig.conf '
alias convert='/usr/local/bin/convert_files.sh '

kitty-reload() {
  kill -SIGUSR1 $(pidof kitty)
}

# PATH
path+=('/home/ea/.local/bin')
export PATH

export EDITOR=nvim
export VISUAL=nvim

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
