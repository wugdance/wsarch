# Get the directory where this .bashrc is located.
BASHRC_REAL_PATH="$(readlink -f "${BASH_SOURCE[0]}")"
BASHRC_DIR="$(dirname "${BASHRC_REAL_PATH}")"

source "${BASHRC_DIR}/history.sh"
source "${BASHRC_DIR}/vi-mode.sh"
source "${BASHRC_DIR}/aliases.sh"
source "${BASHRC_DIR}/fzf.sh"

export EDITOR="nvim"
# export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/ssh-agent.socket"

source /usr/share/bash-completion/bash_completion

source "${HOME}/.local/bin/env"
source "${HOME}/.cargo/env"

# Starship init has to be at the end of the config.
eval "$(starship init bash)"
