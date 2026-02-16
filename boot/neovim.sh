echo "Init neovim..."

pacman -S --noconfirm --needed neovim ripgrep fd unzip xclip

sudo -u "${WSARCH_USER}" -i cargo install tree-sitter-cli

# Install language specific dependencies:
# python-lsp-server - for basic lsp features.
pacman -S --noconfirm --needed python-lsp-server
# pylsp-rope - for formatting features.
paru -S --noconfirm --skipreview python-pylsp-rope 

# ruff - python linter and formatter.
curl -LsSf https://astral.sh/ruff/install.sh \
    | sudo -u ${WSARCH_USER} env RUFF_NO_MODIFY_PATH=1 sh

# stylua - lua code formatter.
sudo -u "${WSARCH_USER}" -i cargo install stylua

# lua-language-server - yes.
pacman -S --noconfirm --needed lua-language-server


# ln creates links.
# -s - create symbolic lynk.
ln -s "${WSARCH_ROOT}/config/neovim" "${WSARCH_USER_HOME}/.config/nvim"

echo "neovim init has completed."
