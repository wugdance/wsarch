pacman -S --noconfirm base-devel

sudo -u "${WSARCH_USER}" git clone https://aur.archlinux.org/paru.git /tmp/paru
sudo -u "${WSARCH_USER}" bash -c "cd /tmp/paru && makepkg -si --noconfirm"
rm -rf /tmp/paru

pacman -Syu --noconfirm
