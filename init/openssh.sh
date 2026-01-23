echo "Init openssh..."

pacman -S --noconfirm openssh

# Create directory for user runtime variables
sudo mkdir -p /etc/profile.d

# Create a file to define the SSH_AUTH_SOCK path for all users
echo 'export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"' | sudo tee /etc/profile.d/ssh-agent.sh

# Reload systemd user configuration
systemctl --user daemon-reload

# Enable the service (starts automatically on login)
systemctl --user enable --now ssh-agent.service

echo "openssh init has completed."
