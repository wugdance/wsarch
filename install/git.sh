echo "Install git..."

pacman -S --noconfirm --needed git

# TODO: Define user email dynamically.
git config --global user.email "sintes4ek@gmail.com"
git config --global user.name "Alexander Ryabyshkin"
