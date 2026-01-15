echo "Install tmux..."

pacman -S --noconfirm tmux

ln -s "$WSARCH_ROOT/config/tmux/.tmux.conf" "$HOME/.tmux.conf"

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo "Complete tmux installation."
