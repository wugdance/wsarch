echo "Setup bash settings..."

pacman -S --noconfirm bash-completion

# -f - force symlink. It will overwrite the file if it exists.
ln -fs "${WSARCH_ROOT}/config/bash/.bashrc" "${WSARCH_USER_HOME}/.bashrc"
ln -fs "${WSARCH_ROOT}/config/bash/.inputrc" "${WSARCH_USER_HOME}/.inputrc"

echo "bash setup has completed."
