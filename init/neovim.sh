echo "Init neovim..."

pacman -S --noconfirm --needed neovim ripgrep fd tree-sitter-cli unzip

# Install language specific dependencies:
# ty - python language server.
curl -LsSf https://astral.sh/ty/install.sh | sh

# ln creates links.
# -s - create symbolic lynk.
ln -s "${WSARCH_ROOT}/config/neovim" "${WSARCH_USER_HOME}/.config/nvim"

echo "neovim init has completed."
