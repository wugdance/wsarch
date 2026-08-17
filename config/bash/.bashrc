# Get the directory where this .bashrc is located.
BASHRC_REAL_PATH="$(readlink -f "${BASH_SOURCE[0]}")"
BASHRC_DIR="$(dirname "${BASHRC_REAL_PATH}")"

source "${BASHRC_DIR}/history.sh"
source "${BASHRC_DIR}/aliases.sh"
source "${BASHRC_DIR}/funcs.sh"
source "${BASHRC_DIR}/fzf.sh"

export EDITOR="nvim"
export MANPAGER="nvim +Man!"
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/ssh-agent.socket"

export REQUESTS_CA_BUNDLE=/etc/ssl/cert.pem

source /usr/share/bash-completion/bash_completion

source "${HOME}/.local/bin/env"
source "${HOME}/.cargo/env"

# Enable Bracketed Paste so pasted multi-line blocks do not execute line-by-line
bind 'set enable-bracketed-paste on'

export PATH=$PATH:~/.o3-cli/bin
export PATH="$PATH:${GOPATH:-$HOME/go}/bin"

export OPENCODE_DISABLE_DEFAULT_PLUGINS=true

export PI_CODING_AGENT_DIR="${HOME}/.config/pi"

export NODE_EXTRA_CA_CERTS="/etc/ssl/certs/ca-certificates.crt"


# Starship init has to be at the end of the config.
eval "$(starship init bash)"
