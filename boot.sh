#!/bin/bash

# "-e"          - exit on error.
# "-u"          - treat unset variables as errors.
# "-o pipefail" - (o stands for option) fail on pipeline erros.
set -euo pipefail

if [[ $EUID -eq 0 ]]; then
    # This script is running as root.
    if [ -z "$SUDO_USER" ]; then
        echo "This script has to be run via sudo, not under root."
        exit 1
    else
        WSARCH_USER="$SUDO_USER"
        WSARCH_USER_HOME=$(getent passwd "$WSARCH_USER" | cut -d: -f6)
    fi
fi

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

# Install basic build tools.
pacman -S --needed base-devel

# Somehow should not break the script.
# source setup/user.sh

source setup/locale.sh
source setup/wsl.sh

source init/neovim.sh

source init/openssh.sh

# bat has to be set before git (theme dependence).
source init/bat.sh
source init/git.sh

source init/tmux.sh
source init/starship.sh
source init/fzf.sh

source setup/bash.sh

