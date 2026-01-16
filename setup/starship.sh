echo "Setuping starshpip..."

source install/starship.sh

ln -s "$WSARCH_ROOT/config/starship/starship.toml" "$HOME/.config/starship.toml"

echo "starship setup has finished."
