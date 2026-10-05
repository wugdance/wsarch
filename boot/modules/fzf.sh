echo "Init fzf..."

pacman -S --noconfirm --needed fzf

# Share one fzf options file with Bash and tmux popups.
mkdir -p "${WSARCH_USER_HOME}/.config"
ln -fsn "${WSARCH_ROOT}/config/fzf" "${WSARCH_USER_HOME}/.config/fzf"

echo "fzf init has completed."
