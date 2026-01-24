echo "Init bat..."

pacman -S --noconfirm --needed bat

bat --completion bash

ln -s "${WSARCH_ROOT}/config/bat" "${WSARCH_USER_HOME}/.config/bat"

sudo -u "${WSARCH_USER}" bat cache --build

echo "bat init has completed."
