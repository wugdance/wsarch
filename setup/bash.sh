echo "Setuping bash..."

# -f - force symlink. It will overwrite the file if it exists.
ln -fs "$WSARCH_ROOT/config/bash/.bashrc" "$HOME/.bashrc"

echo "bash setup has finished."
