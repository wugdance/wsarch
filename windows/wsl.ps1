# Wipe the old copy if exist.
wsl --unregister archlinux

# Get latest wsl release version.
wsl --update

# Install arch distro.
wsl --install archlinux
