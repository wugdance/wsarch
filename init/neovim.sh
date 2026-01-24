echo "Init neovim..."

pacman -S --noconfirm --needed neovim ripgrep fd

# ln creates links.
# -s - create symbolic lynk.
ln -s "${WSARCH_ROOT}/config/neovim" "${WSARCH_USER_HOME}/.config/nvim"

echo "neovim init has completed."
