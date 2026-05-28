echo "Init syncthing..."

pacman -S --noconfirm syncthing

# Reload systemd user configuration.
sudo -u "${WSARCH_USER}" XDG_RUNTIME_DIR="/run/user/${WSARCH_USER_ID}" \
    systemctl --user daemon-reload

# Enable the service (starts automatically on login).
sudo -u "${WSARCH_USER}" XDG_RUNTIME_DIR="/run/user/${WSARCH_USER_ID}" \
    systemctl --user enable syncthing

echo "syncthing init has been done."
