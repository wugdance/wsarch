$WSARCH_USER = Read-Host "Enter your wsarch username: "
# Set the new default user after creating.
wsl --manage archlinux --set-default-user $WSARCH_USER
