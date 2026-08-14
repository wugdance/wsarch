# Set up fzf key bindings and fuzzy completion (lazy: loads on first Ctrl-T/Ctrl-R/Alt-C)
__fzf_lazy() {
    eval "$(fzf --bash)"
    printf '\rLoaded fzf.\n'
}
__fzf_bind_all() {
    local key="$1"
    bind -m vi-command -x "$key: __fzf_lazy"
    bind -m vi-insert -x "$key: __fzf_lazy"
}
__fzf_bind_all '"\C-t"'
__fzf_bind_all '"\C-r"'
__fzf_bind_all '"\ec"'
unset -f __fzf_bind_all

# Enable rose-pine theme.
export FZF_DEFAULT_OPTS="
	--color=fg:#908caa,bg:#191724,hl:#ebbcba
	--color=fg+:#e0def4,bg+:#26233a,hl+:#ebbcba
	--color=border:#403d52,header:#31748f,gutter:#191724
	--color=spinner:#f6c177,info:#9ccfd8
	--color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa"

