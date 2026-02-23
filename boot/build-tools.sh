pacman -S --noconfirm base-devel

git clone https://aur.archlinux.org/paru.git /tmp/paru
sudo -u "${WSARCH_USER}" makepkg -si -p /tmp/paru/PKGBUILD --noconfirm
rm -rf /tmp/paru

pacman -Syu --noconfirm
