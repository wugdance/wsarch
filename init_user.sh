echo "Initialize a user..."
read -p "Enter your username:" WSARCH_USER

# Add a user:
# "-m"           - create home folder for the new user.
# "-G wheel"     - add to the wheel group, so they can use `sudo`.
# "-s /bin/bash" - set default shell.
# $WSARCH_USER - user name.
useradd -m -G wheel -s /bin/bash $WSARCH_USER

# Set user password.
# (It will prompt to insert password twice.)
passwd $WSARCH_USER

# Allow the wheel group to execute commands via `sudo`.

# etc/sudoers.d/wheel - directory for sudo configuration fragments
sh -c 'echo "%wheel ALL=(ALL:ALL) ALL" > /etc/sudoers.d/wheel'

# Make it readable for owner and group.
chmode 440 /etc/sudoers.d/wheel

# Validate sudoers syntax.
visudo -c

mkdir -p "/home/$WSARCH_USER/.config"
