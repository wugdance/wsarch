echo "Init neovim..."

pacman -S --noconfirm --needed neovim ripgrep fd unzip xclip

sudo -u "${WSARCH_USER}" -i cargo install tree-sitter-cli

# Install language specific dependencies:
# ruff - python linter and formatter.
# ty - lsp for python.
pacman -S --noconfirm --needed ty ruff

# stylua - lua code formatter.
paru -S stylua

# mdformat - formatter for markdown.
sudo pacman -S mdformat

# lua-language-server - yes.
pacman -S --noconfirm --needed lua-language-server


# ln creates links.
# -s - create symbolic lynk.
ln -s "${WSARCH_ROOT}/config/neovim" "${WSARCH_USER_HOME}/.config/nvim"

echo "neovim init has completed."
