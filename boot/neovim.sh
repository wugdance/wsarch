echo "Init neovim..."

pacman -S --noconfirm --needed neovim ripgrep fd tree-sitter-cli unzip

# Install language specific dependencies:
# ty - python language server.
curl -LsSf https://astral.sh/ty/install.sh | sudo -u ${WSARCH_USER} sh

# ruff - python linter and core formatter.
curl -LsSf https://astral.sh/ruff/install.sh | sudo -u ${WSARCH_USER} sh

# stylua - lua code formatter.
sudo -u "${WSARCH_USER}" -i cargo install stylua

# lua-language-server - yes.
pacman -S --noconfirm --needed lua-language-server


# ln creates links.
# -s - create symbolic lynk.
ln -s "${WSARCH_ROOT}/config/neovim" "${WSARCH_USER_HOME}/.config/nvim"

echo "neovim init has completed."
