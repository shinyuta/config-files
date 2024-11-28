eval "$(oh-my-posh init zsh --config ~/dotfiles/ohmyposh/zen.toml)"

export ZSH="$HOME/.oh-my-zsh"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

# ------ NIX/HOME-MANAGER ---------
alias swh="/nix/store/47kmhrlyxpvf9a8alfzsfy4cj6sy9r4n-home-manager-0-unstable-2024-10-20/bin/home-manager switch"

# ---- FZF -----
# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# -- Use fd instead of fzf --

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
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
  --color=hl:#af8685,hl+:#ebbcba,info:#907aa9,marker:#ebbcba
  --color=prompt:#ebbcba,spinner:#907aa9,pointer:#907aa9,header:#907aa9
  --color=border:#262626,label:#aeaeae,query:#d9d9d9
  --border="sharp" --border-label="" --preview-window="border-rounded" --prompt=" "
  --marker="|" --pointer="󰄛" --separator="─" --scrollbar="│"
  --layout="reverse" --info="right"'

# ------ BAT -------
BAT_THEME="Catppuccin Mocha"

# ------ EZA/LS -------
alias ls="eza --color=always -G --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"
alias lst="eza --icons=always -1 -T --level=2"

# ------ ZOXIDE/CD ------
eval "$(zoxide init zsh)"
alias cd="z"

# ------- TMUX ---------
alias tmuxk="tmux kill-session"
alias tmuxifire="tmuxifier load-session coding"


