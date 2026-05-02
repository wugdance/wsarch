echo "Init neovim..."

pacman -S --noconfirm --needed neovim ripgrep fd unzip xclip

sudo -u "${WSARCH_USER}" -i cargo install tree-sitter-cli

# Install language specific dependencies:
# ruff - python linter and formatter.
# ty - lsp for python.
pacman -S --noconfirm --needed ty ruff

# stylua - lua code formatter.
sudo -u "${WSARCH_USER}" -i paru -S --noconfirm --skipreview stylua

# mdformat - formatter for markdown.
# marksman - markdown lsp.
pacman -S --noconfirm --needed mdformat mdformat-tables marksman

# lua-language-server - yes.
pacman -S --noconfirm --needed lua-language-server

ln -sf "${WSARCH_ROOT}/config/neovim" "${WSARCH_USER_HOME}/.config/nvim"

echo "neovim init has completed."
