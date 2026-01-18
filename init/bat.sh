echo "Setup bat..."

source install/bat.sh

bat --completion bash

ln -s "$WSARCH_ROOT/config/bat" "$HOME/.config/bat"

bat cache --build

echo "bat setup has finished."
