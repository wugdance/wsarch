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

function pytest::run {
    target=$1

    poetry run pytest -s -vv $target
}
