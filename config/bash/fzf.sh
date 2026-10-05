# Set up fzf key bindings and fuzzy completion (lazy: loads on first Ctrl-T/Ctrl-R/Alt-C)
__fzf_lazy() {
    eval "$(fzf --bash)"
    printf '\rLoaded fzf.\n'
}
__fzf_bind_all() {
    local key="$1"

    # Keybindings require readline and are meaningful only in interactive Bash.
    [[ $- == *i* ]] || return 0

    bind -m vi-command -x "$key: __fzf_lazy"
    bind -m vi-insert -x "$key: __fzf_lazy"
}
__fzf_bind_all '"\C-t"'
__fzf_bind_all '"\C-r"'
__fzf_bind_all '"\ec"'
unset -f __fzf_bind_all

# One fzf options file is shared by interactive Bash and tmux popups. The
# transparent main background/gutter lets the WezTerm glass material show.
export FZF_DEFAULT_OPTS_FILE="${HOME}/.config/fzf/default-opts"

