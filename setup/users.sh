echo "Setup a new user..."

echo "Setup the root password..."
passwd

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
# mkdir -p /etc/sudoers.d
# touch /etc/sudoers.d/wheel
echo "%wheel ALL=(ALL:ALL) ALL" > /etc/sudoers.d/wheel

# Make it readable for owner and group.
chmod 440 /etc/sudoers.d/wheel

echo "" >> /etc/wsl.conf
echo "[user]" >> /etc/wsl.conf
echo "default=${WSARCH_USER}" >> /etc/wsl.conf

echo "${WSARCH_USER} setup has completed."
unset WSARCH_USER
