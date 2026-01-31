# wsarch

The goal is providing a convinient way to setup windows 11 wsl archlinux 
env. 


## Characteristics

* opinionated  - config for personal use primaraly.
* minimalistic - don't use what you don't need.
* modular      - separation of concerns, avoid mental overhead.
* documented   - part of the learning process.
* ready-to-go  - as few commands to setup as possible.


## Setup order

```ps1
git clone https://github.com/wugdance/wsarch.git
.\windows\wsl.ps1  # You will login into wsl at the end of the script.
```

Executed under root.

```bash
pacman -Syu --noconfirm git && cd /tmp && git clone https://github.com/wugdance/wsarch.git && cd wsarch && ./pre-boot/init.sh && cd .. && rm -rf wsarch && exit
```

```ps1
wsl --terminate archlinux; wsl -d archlinux
```

```bash
cd ~ && git clone https://github.com/wugdance/wsarch.git && cd wsarch && sudo ./boot/init.sh
```

