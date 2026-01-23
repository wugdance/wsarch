echo "Init neovim..."

source install/neovim.sh

# ln creates links.
# -s - create symbolic lynk.
ln -s "$WSARCH_ROOT/config/neovim" "$HOME/.config/nvim"

echo "neovim has been initialized."
