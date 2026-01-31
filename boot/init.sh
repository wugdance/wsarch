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
export WSARCH_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && cd .. && pwd)"

# Install basic build tools.
pacman -S --noconfirm base-devel

source boot/rust.sh

source boot/neovim.sh

# bat provides the theme for git-delta.
source boot/bat.sh && source boot/git.sh

source boot/tmux.sh
source boot/starship.sh
source boot/fzf.sh

# ssh-agent.service depends on env var from .bashrc.
# source setup/bash.sh && source boot/openssh.sh
# But it doesn't work.
source boot/bash.sh
