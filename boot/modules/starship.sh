echo "Init starship..."

curl -sS https://starship.rs/install.sh | sudo -u ${WSARCH_USER} sh -s -- -y

ln -sf "$WSARCH_ROOT/config/starship/starship.toml" \
    "$WSARCH_USER_HOME/.config/starship.toml"

echo "starship init has completed."
