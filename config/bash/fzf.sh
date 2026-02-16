# Set up fzf key bindings and fuzzy completion
eval "$(fzf --bash)"

# Enable rose-pine theme.
export FZF_DEFAULT_OPTS="
	--color=fg:#908caa,bg:#191724,hl:#ebbcba
	--color=fg+:#e0def4,bg+:#26233a,hl+:#ebbcba
	--color=border:#403d52,header:#31748f,gutter:#191724
	--color=spinner:#f6c177,info:#9ccfd8
	--color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa"

fzf::pacman::install() {
    pacman -Slq \
        | fzf --multi --preview 'pacman -Si {1}' \
        | xargs -ro sudo pacman -S
}

fzf::pacman::remove() {
    pacman -Qq \
        | fzf --multi --preview 'pacman -Qi {1}' \
        | xargs -ro sudo pacman -Rns
}
