pacman -S --noconfirm nvm
sudo -u "${WSARCH_USER}" source /usr/share/nvm/init-nvm.sh
sudo -u "${WSARCH_USER}" nvm install node
sudo -u "${WSARCH_USER}" nvm use node
