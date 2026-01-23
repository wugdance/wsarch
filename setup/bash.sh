echo "Setup bash settings..."

sudo pacman -S --noconfirm bash-completion

# -f - force symlink. It will overwrite the file if it exists.
ln -fs "$WSARCH_ROOT/config/bash/.bashrc" "$HOME/.bashrc"

echo "bash setup has completed."
