echo "Install tmux..."

pacman -S --noconfirm tmux

ln -s "$WSARCH_ROOT/config/tmux/.tmux.conf" "$HOME/.tmux.conf"

echo "Complete tmux installation."
