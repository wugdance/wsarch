echo "Init bat..."

pacman -S --noconfirm bat

bat --completion bash

ln -s "${WSARCH_ROOT}/config/bat" "${WSARCH_USER_HOME}/.config/bat"

bat cache --build

echo "bat init has completed."
