echo "Init tmux..."

pacman -S --noconfirm tmux

ln -s "${WSARCH_ROOT}/config/tmux" "${WSARCH_USER_HOME}/.config/tmux"

git clone https://github.com/tmux-plugins/tpm \
"${WSARCH_USER_HOME}/.config/tmux/plugins/tpm"

"${WSARCH_USER_HOME}/.config/tmux/plugins/tpm/bin/install_plugins"

echo "tmux init has completed."
