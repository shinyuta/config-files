export PATH=$PATH:/Users/yutakirihara/.spicetify
export PATH="$(brew --prefix ruby)/bin:$PATH"
export TERM=xterm-256color
export LANG=en_US.UTF-8

autoload -U compinit
compinit -C

HISTSIZE=5000      # Number of commands kept in memory (adjust as needed)
SAVEHIST=5000      # Number of commands written to disk
HISTFILE="$HOME/.zsh_history"

# ----- ALIASES ------
alias obs="cd ~/Desktop/obsidian/Main"
alias leet="cd ~/Desktop/projects/leetcode"

# ---- STARSHIP -----
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"

# Ensure Starship is only loaded once (prevents duplicate function registrations)
if ! typeset -f starship_zle-keymap-select >/dev/null; then
    eval "$(starship init zsh)"
fi

# Ensure Starship's keymap function does NOT recursively register
autoload -Uz add-zle-hook-widget

# Remove any previous instances to prevent infinite recursion
zle -N starship_zle-keymap-select-wrapped 2>/dev/null
zle -N starship_zle-keymap-select 2>/dev/null

# Register the function properly
add-zle-hook-widget zle-keymap-select starship_zle-keymap-select

# ---- VI MODE SETTINGS AND BINDS ----
# Enable Vi Mode in Zsh
bindkey -v
export KEYTIMEOUT=1  # Reduce delay when switching modes

# Use Vim keys in tab completion menu:
bindkey -v '^?' backward-delete-char

function copy_selection {
  zle kill-region       # Copy selection to internal clipboard
  echo -n "$CUTBUFFER" | pbcopy  # macOS clipboard
}

zle -N copy_selection
bindkey -M vicmd 'y' copy_selection

# history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# ---- HISTORY SETTINGS ----
# Store history in cache directory (ensure it exists)
HISTSIZE=10000
SAVEHIST=10000
HISTFILE="$HOME/.zsh_history"  # Using a file outside of .cache since no zsh dir exists there

# ---- COMPLETION ENHANCEMENTS ----
# Load completion system properly
autoload -U compinit
compinit

# Load completion selection menu (required for menuselect)
zmodload zsh/complist

# Ensure menu selection mode is enabled
zstyle ':completion:*' menu select

# Ensure menuselect keybindings work (only bind if the keymap exists)
autoload -Uz add-zle-hook-widget
add-zle-hook-widget zle-line-init ensure-menuselect

function ensure-menuselect {
  zmodload zsh/complist  # Ensure completion is loaded
  if bindkey -M menuselect >/dev/null 2>&1; then
    bindkey -M menuselect '^h' vi-backward-char
    bindkey -M menuselect '^k' vi-up-line-or-history
    bindkey -M menuselect '^l' vi-forward-char
    bindkey -M menuselect '^j' vi-down-line-or-history
  fi
}
_comp_options+=(globdots)  # Include hidden files in tab completion

# ---- VI MODE CURSOR SHAPE ----
function zle-keymap-select {
  echo -ne '\e[1 q'  # Always use block cursor
  zle reset-prompt   # Ensure Starship prompt updates
}
zle -N zle-keymap-select

zle-line-init() {
    zle -K viins
    echo -ne "\e[1 q"
}
zle -N zle-line-init
echo -ne '\e[1 q'
preexec() { echo -ne '\e[1 q' ;}  # Keep block cursor after each command

# ---- EDIT COMMAND IN NVIM ----
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

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
  --layout="reverse" --info="right"
'

# ------ BAT -------
export BAT_THEME="Monokai Extended Origin"

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

# ------- SCRIPTS/ALIAS ---------
alias syncsuperfile="~/.config/superfile/sync_superfile.sh"
alias login04="ssh hedfo001@login04.cselabs.umn.edu"

# From Home to Labs: Copy a file to login04 (default: remote home directory)
h2lf() {
  # Usage: h2lf <local_file> [remote_destination]
  # If remote_destination is omitted, the file is copied to your home directory.
  remote_dest=${2:-}
  scp "$1" hedfo001@login04.cselabs.umn.edu:"${remote_dest}"
}

# From Labs to Home: Copy a file from login04 (default: remote home directory) to the current directory
l2hf() {
  # Usage: l2hf <remote_file> [local_destination]
  # If local_destination is omitted, the file is copied to the current directory.
  local_dest=${2:-.}
  scp hedfo001@login04.cselabs.umn.edu:"$1" "$local_dest"
}

# From Home to Labs: Recursively copy a directory to login04 (default: remote home directory)
h2ld() {
  # Usage: h2ld <local_directory> [remote_destination]
  # If remote_destination is omitted, the directory is copied to your home directory.
  remote_dest=${2:-}
  scp -r "$1" hedfo001@login04.cselabs.umn.edu:"${remote_dest}"
}

# From Labs to Home: Recursively copy a directory from login04 (default: remote home directory) to the current directory
l2hd() {
  # Usage: l2hd <remote_directory> [local_destination]
  # If local_destination is omitted, the directory is copied to the current directory.
  local_dest=${2:-.}
  scp -r hedfo001@login04.cselabs.umn.edu:"$1" "$local_dest"
}


# ------- zsh ---------
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $(brew --prefix)/share/zsh-history-substring-search/zsh-history-substring-search.zsh

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}  # Use colors from `LS_COLORS`
zstyle ':completion:*' group-name ''                   # Group files by type
zstyle ':completion:*' menu select                     # Enable menu-based selection
zstyle ':completion:*' list-prompt '%B%F{green}Choose: %f%b'  # Prompt for list selection
zstyle ':completion:*' format '%B%F{yellow}%d%f%b'     # Format completion group headers
zstyle ':completion:*' select-prompt '%B%F{cyan}Scrolling...%f%b'  # Prompt when scrolling

# Force completion listings into columns (grid layout)
zstyle ':completion:*' list-packed true
zstyle ':completion:*' last-prompt true

# Function to move the cursor to the bottom before showing the prompt
__prompt_to_bottom_line() {
  tput cup $(( $(tput lines) - 1 ))  # Move to the last line of the terminal
}

# Alias `clear` to keep the prompt at the bottom
alias clear='clear && __prompt_to_bottom_line'

# Keep previous command and avoid extra blank lines after `clear`
preexec() {
    export PREV_CMD="$1"
}

# Ensure prompt stays at the bottom while keeping space below output
precmd() {
    if [[ "$PREV_CMD" != "clear" ]]; then
        echo  # Add a blank line after command output
    fi
    __prompt_to_bottom_line
}
