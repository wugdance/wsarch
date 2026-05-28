function pea {
    source "$(poetry env info --path)/bin/activate"
}

function pacman::install {
    pacman -Slq \
        | fzf --multi --preview 'pacman -Si {1}' \
        | xargs -ro sudo pacman -S
}

function pacman::remove {
    pacman -Qq \
        | fzf --multi --preview 'pacman -Qi {1}' \
        | xargs -ro sudo pacman -Rns
}

function jit {
    base_url="https://jit.o3.ru/browse/"
    task=$(echo $(git branch --show-current) | cut -d '/' -f 2)
    explorer.exe "${base_url}${task}"
}
