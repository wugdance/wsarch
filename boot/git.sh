echo "Init git..."

pacman -S --noconfirm --needed git git-delta

ln -sf "${WSARCH_ROOT}/config/git/.gitconfig" "${WSARCH_USER_HOME}/.gitconfig"
ln -sf "${WSARCH_ROOT}/config/delta" "${WSARCH_USER_HOME}/.config/delta"

delta --generate-completion bash

echo "git init has completed."
