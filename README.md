# wsarch

wsarch goal is providing a convinient way to setup windows 11 wsl archlinux 
dev env. Learning linux and arch linux in particular throught the way is 
also an important part.

## Setup order

```ps1
git clone https://github.com/wugdance/wsarch.git
.windows\wsl.ps1
wsl -d archlinux
```

Executed under root.

```bash
pacman -Syu
pacman -S git
cd /tmp && git clone https://github.com/wugdance/wsarch.git && cd wsarch
./setup/user.sh
cd .. && rm -rf wsarch
exit
```

```ps1
.\windows\user.ps1
wsl -d archlinux
```

```bash
cd ~ && git clone https://github.com/wugdance/wsarch.git && cd wsarch
sudo ./boot.sh
```

