echo "Init openssh..."

pacman -S --noconfirm openssh

# Reload systemd user configuration.
sudo -u "${WSARCH_USER}" XDG_RUNTIME_DIR="/run/user/${WSARCH_USER_ID}" \
    systemctl --user daemon-reload

# Enable the service (starts automatically on login).
sudo -u "${WSARCH_USER}" XDG_RUNTIME_DIR="/run/user/${WSARCH_USER_ID}" \
    systemctl --user enable ssh-agent.service

echo "openssh init has completed."
