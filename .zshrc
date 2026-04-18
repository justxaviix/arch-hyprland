# ── Zinit ─────────────────────────────────────────────────────────────────────
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
source "${ZINIT_HOME}/zinit.zsh"

# ── Plugins ───────────────────────────────────────────────────────────────────
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light Aloxaf/fzf-tab

# ── Completions ───────────────────────────────────────────────────────────────
autoload -Uz compinit
compinit

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# ── History ───────────────────────────────────────────────────────────────────
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY

# ── Key bindings ──────────────────────────────────────────────────────────────
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# ── Environment ───────────────────────────────────────────────────────────────
export EDITOR=nvim
export VISUAL=nvim
export XDG_SESSION_TYPE=wayland
export MOZ_ENABLE_WAYLAND=1
export QT_QPA_PLATFORM=wayland

# ── Aliases — Navigation ──────────────────────────────────────────────────────
alias ..='cd ..'
alias ...='cd ../'
alias ls='ls --color=auto'
alias ll='ls -lah --color=auto'
alias la='ls -A --color=auto'
alias grep='grep --color=auto'

# ── Aliases — System ──────────────────────────────────────────────────────────
alias update='sudo pacman -Syu'
alias install='sudo pacman -S'
alias remove='sudo pacman -Rns'
alias search='pacman -Ss'
alias yupdate='yay -Syu'
alias df='df -h'
alias free='free -h'
alias top='btop'

# ── Aliases — Rice ────────────────────────────────────────────────────────────
alias hconf='$EDITOR ~/.config/hypr/hyprland.conf'
alias hrel='hyprctl reload'
alias wbar='pkill waybar; waybar &'
alias wallpaper='~/.config/hypr/scripts/set-wallpaper.sh'
alias ff='fastfetch'

# ── Aliases — Git ─────────────────────────────────────────────────────────────
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline --graph --decorate'

# ── fzf ───────────────────────────────────────────────────────────────────────
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border=rounded'

# ── Zoxide (smarter cd) ───────────────────────────────────────────────────────
eval "$(zoxide init --cmd cd zsh)"

# ── Starship prompt ───────────────────────────────────────────────────────────
eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/.config/starship/starship.toml
alias dots='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
