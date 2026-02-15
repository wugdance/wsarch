pacman -S --noconfirm base-devel

git clone https://aur.archlinux.org/paru.git /tmp/paru
makepkg -si -p /tmp/paru --noconfirm
rm -rf /tmp/paru

pacman -Syu --noconfirm
