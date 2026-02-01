echo "Init neovim..."

pacman -S --noconfirm --needed neovim ripgrep fd tree-sitter-cli unzip


# Install clipboard tool.
temp_dir=$(mktemp -d)
curl -sSL -o "${temp_dir}/win32yank.zip" \
    "https://github.com/equalsraf/win32yank/releases/latest/download/win32yank-x64.zip"
unzip -q "${temp_dir}/win32yank.zip" -d "${temp_dir}"
mv "${temp_dir}/win32yank.exe" /usr/local/bin/win32yank
chmod +x /usr/local/bin/win32yank
rm -rf "${temp_dir}"

# Install language specific dependencies:
# ty - python language server.
curl -LsSf https://astral.sh/ty/install.sh \
    | sudo -u ${WSARCH_USER} env TY_NO_MODIFY_PATH=1 sh

# ruff - python linter and core formatter.
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
