echo "Init rust..."

curl https://sh.rustup.rs -sSf | sudo -u ${WSARCH_USER} sh -s -- -y
export PATH="${WSARCH_USER_HOME}/.cargo/bin:${PATH}"

echo "rust init has completed."
