#!/bin/bash

# "-e"          - exit on error.
# "-u"          - treat unset variables as errors.
# "-o pipefail" - (o stands for option) fail on pipeline erros.
set -euo pipefail

# "${BASH_SOURCE[0]}" - contains a path to the run script.
# "$(dirname ...)"    - get direcotry name.
# $(cd ... && pwd)    - resolve relative paths.
export WSARCH_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Update all packages.
# "-S" - stands for sync. It's in some sense the main flag.
# Sync flag specifiers placed below:
# "-y" - refresh the package database.
# "-u" - upgrade all the installed packages.
pacman -Syu --noconfirm

# Install base package bundle for AUR building.
pacman -S --noconfirm base-devel 

source setup/wsl.sh

source setup/neovim.sh
source setup/bat.sh
source setup/git.sh
source setup/tmux.sh
source setup/starship.sh

source setup/bash.sh

