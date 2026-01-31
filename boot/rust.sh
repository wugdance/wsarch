echo "Init rust..."

curl https://sh.rustup.rs -sSf | sudo -u ${WSARCH_USER} sh -s -- -y
source "${WSARCH_USER_HOME}/.cargo/env"

echo "rust init has completed."
