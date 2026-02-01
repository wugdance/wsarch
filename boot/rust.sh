echo "Init rust..."


pacman -S --noconfirm --needed clang
curl https://sh.rustup.rs -sSf | sudo -u ${WSARCH_USER} sh -s -- -y

echo "rust init has completed."
