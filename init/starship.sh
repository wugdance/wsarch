echo "Init starship..."

source install/starship.sh

ln -s "$WSARCH_ROOT/config/starship/starship.toml" "$WSARCH_USER_HOME/.config/starship.toml"

echo "starship init has completed."
