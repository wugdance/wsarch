echo "Init tmux..."

pacman -S --noconfirm tmux

ln -s "${WSARCH_ROOT}/config/tmux/.tmux.conf" "${WSARCH_USER_HOME}/.tmux.conf"

git clone https://github.com/tmux-plugins/tpm \
    "${WSARCH_USER_HOME}/.tmux/plugins/tpm"

"${WSARCH_USER_HOME}/.tmux/plugins/tpm/bin/install_plugins"

echo "tmux init has completed."
