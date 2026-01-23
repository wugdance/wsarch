# wsarch

wsarch goal is providing a convinient way to setup windows 11 wsl archlinux 
dev env. Learning linux and arch linux in particular throught the way is 
also an important part.

## Setup order

```ps1
git clone https://github.com/wugdance/wsarch.git
.\wsl.ps1
wsl -d archlinux
```

Executed under root.

```bash
cd /tmp
pacman -S git
git clone https://github.com/wugdance/wsarch.git
cd wsarch
./setup/user.sh
cd .. && rm -rf wsarch
exit
```

```ps1
.\user.ps1
wsl -d archlinux
cd ~
git clone https://github.com/wugdance/wsarch.git
cd wsarch
sudo ./boot.sh
```

