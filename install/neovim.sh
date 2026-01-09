echo "Install neovim..."

# You can specify a concrete package name with "-S" flag.
# pacman manages the official arch packages. So in this case we'll get 
# stable neovim version. You if want a latest nightly build you have to 
# access the community repository (AUR).
pacman -S --noconfirm neovim

# ln creates links.
# -s - create symbolic lynk.
ln -s "$WSARCH_ROOT/config/neovim" "$HOME/.config/nvim"
