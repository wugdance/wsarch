source install/tmux.sh

ln -s "$WSARCH_ROOT/config/tmux/.tmux.conf" "$HOME/.tmux.conf"

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
