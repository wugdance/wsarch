#!/bin/bash

# "-e"          - exit on error.
# "-u"          - treat unset variables as errors.
# "-o pipefail" - (o stands for option) fail on pipeline erros.
set -euo pipefail

# EUID - Effective User ID. The user used to determine the permissions for 
# action. 0 is root (or via sudo).
if [[ $EUID -eq 0 ]]; then
    # This script is running as root.
    if [ -z "$SUDO_USER" ]; then
        echo "This script has to be run via sudo, not under root."
        exit 1
    else
        export WSARCH_USER="${SUDO_USER}"
        export WSARCH_USER_ID=$(id -u "${WSARCH_USER}")
        export WSARCH_USER_HOME=$(getent passwd "${WSARCH_USER}" | cut -d: -f6)
    fi
else
    echo "This script requires root priviliges."
    exit 1
fi

# "${BASH_SOURCE[0]}" - contains a path to the run script.
# "$(dirname ...)"    - get directory name.
# $(cd ... && pwd)    - resolve relative paths.
export WSARCH_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Update all packages.
# "-S" - stands for sync. It's in some sense the main flag.
# Sync flag specifiers placed below:
# "-y" - refresh the package database.
# "-u" - upgrade all the installed packages.
pacman -Syu --noconfirm

# Install basic build tools.
pacman -S --noconfirm base-devel

source setup/locale.sh
source setup/wsl.sh

source init/rust.sh

source init/neovim.sh

# bat provides the theme for git-delta.
source init/bat.sh && source init/git.sh

source init/tmux.sh
source init/starship.sh
source init/fzf.sh

# ssh-agent.service depends on env var from .bashrc.
source setup/bash.sh && source init/openssh.sh
