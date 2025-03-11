export EDITOR=nvim

# ---- STARSHIP -----
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
eval "$(starship init zsh)"

export PATH="$(brew --prefix ruby)/bin:$PATH"

# ---- FZF -----
source <(fzf --zsh)

_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

alias fs='nvim $(fzf --preview="bat --color=always {}" -m)'

_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo $'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "bat -n --color=always --line-range :500 {}" "$@" ;;
  esac
}
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --color=fg:#d0d0d0,fg+:#d0d0d0,bg:-1,bg+:#262626
  --color=hl:#b6539e,hl+:#FD77DD,info:#A9DD48,marker:#A9DD48
  --color=prompt:#A9DD48,spinner:#A9DD48,pointer:#54C1DB,header:#FD77DD
  --color=border:#262626,label:#aeaeae,query:#FDEEFC
  --border="sharp" --border-label="" --preview-window="border-rounded" --prompt=" "
  --marker="|" --pointer="󰄛" --separator="─" --scrollbar="│"
  --layout="reverse" --info="right"'

# ------ BAT -------
BAT_THEME="Catppuccin Mocha"

# ------ EZA/LS -------
export EZA_COLORS="di=38;5;148:ln=38;5;81:*.java=38;5;81:*.css=38;5;81:*.lua=38;5;81:*.class=38;5;81:*.md=38;5;81:*.py=38;5;81"
alias ls="eza --color=always -G --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"
alias lst="eza --icons=always -1 -T --level=2"
alias lsl="eza -l"

# ------ ZOXIDE/CD ------
eval "$(zoxide init zsh)"
alias cd="z"

# ------- TMUX ---------
export PATH="$HOME/.config/tmuxifier/bin:$PATH"
alias tmuxk="tmux kill-session"
alias tmuxa="tmux attach"
alias tmuxifire="tmuxifier load-session coding"

# ------- FUCK --------
eval $(thefuck --alias)
alias fk="fuck"

# -------- YAZI ---------
export YAZI_CONFIG_HOME="$HOME/.config/yazi"

# ------- zsh ---------
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ------- SCRIPTS ---------
alias syncsuperfile="~/.config/superfile/sync_superfile.sh"

# ------- VIM MODE ---------
# Enable Vim mode in Zsh
bindkey -v

# Reduce delay when switching modes
export KEYTIMEOUT=1
