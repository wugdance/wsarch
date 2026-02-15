echo "Setup a new user..."
read -p "Enter your username: " WSARCH_USER

# Add a user:
# "-m"           - create home folder for the new user.
# "-G wheel"     - add to the wheel group, so they can use `sudo`.
# "-s /bin/bash" - set default shell.
# $WSARCH_USER - user name.
useradd -m -G wheel -s /bin/bash $WSARCH_USER

# Set user password.
# (It will prompt to insert password twice.)
passwd $WSARCH_USER

pacman -S --noconfirm --needed sudo

# Allow the wheel group to execute commands via `sudo`.
# etc/sudoers.d/wheel - directory for sudo configuration fragments
mkdir -p /etc/sudoers.d && touch /etc/sudoers.d/wheel
echo "%wheel ALL=(ALL:ALL) ALL" >> /etc/sudoers.d/wheel
# Make it readable for owner and group.
chmod 440 /etc/sudoers.d/wheel
visudo -cf /etc/sudoers.d/wheel

# Create a new file in the sudoers.d directory
echo 'Defaults timestamp_timeout=60' | tee /etc/sudoers.d/timeout_config
# Set the correct permissions (readable by root only)
chmod 440 /etc/sudoers.d/timeout_config
# VALIDATE THE SYNTAX. This command is crucial.
visudo -cf /etc/sudoers.d/timeout_config


echo "${WSARCH_USER} setup has completed."

cat <<EOF >> /etc/wsl.conf

[user]
default=${WSARCH_USER}
EOF

unset WSARCH_USER
