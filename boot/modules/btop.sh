echo "Init btop..."

pacman -S --noconfirm --needed btop

ln -sf "$WSARCH_ROOT/config/btop" \
    "$WSARCH_USER_HOME/.config/btop"
echo "btop init has completed."
