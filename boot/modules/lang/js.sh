echo "Init node..."

# nvm itself is a shell function, not a binary, so every node-related command
# has to run inside a single login shell of the user.
pacman -S --noconfirm --needed nvm

sudo -u "${WSARCH_USER}" -i bash -c '
    source /usr/share/nvm/init-nvm.sh
    nvm install node
    nvm alias default node
'

# .bashrc does not initialize nvm, so put the default node'"'"'s binaries on
# PATH for every shell (interactive ones and the "sudo -u ... -i npm" calls in
# other modules) by symlinking into ~/.local/bin, which .bashrc already adds
# to PATH. The executables resolve their real location through the symlinks.
sudo -u "${WSARCH_USER}" -i bash -c '
    source /usr/share/nvm/init-nvm.sh
    mkdir -p "${HOME}/.local/bin"
    BIN_DIR="$(dirname "$(nvm which default)")"
    for f in "${BIN_DIR}"/*; do
        ln -sf "${f}" "${HOME}/.local/bin/$(basename "${f}")"
    done
'

echo "node init has completed."
