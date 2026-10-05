# Get the directory where this .bashrc is located.
BASHRC_REAL_PATH="$(readlink -f "${BASH_SOURCE[0]}")"
BASHRC_DIR="$(dirname "${BASHRC_REAL_PATH}")"

source "${BASHRC_DIR}/history.sh"
source "${BASHRC_DIR}/aliases.sh"
source "${BASHRC_DIR}/funcs.sh"
source "${BASHRC_DIR}/fzf.sh"

export EDITOR="nvim"
export VISUAL="nvim"
export MANPAGER="nvim +Man!"
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/ssh-agent.socket"

export REQUESTS_CA_BUNDLE=/etc/ssl/cert.pem
export NODE_USE_SYSTEM_CA=1

source /usr/share/bash-completion/bash_completion

source "${HOME}/.local/bin/env"
source "${HOME}/.cargo/env"

# Bracketed paste is a readline feature, so only enable it interactively.
if [[ $- == *i* ]]; then
    bind 'set enable-bracketed-paste on'
fi

export PATH=$PATH:~/.o3-cli/bin

export GITLAB_TOKEN=$(cat ~/.tokens/gitlab-token)
export GITLAB_HOST="gitlab.ozon.ru"

# o3 platform needs a Python <3.14 (Arch default is 3.14). Shadow only for o3
# with a 3.12 that has pip, leaving the system python untouched.
o3() { PATH="$HOME/.o3-python:$PATH" command o3 "$@"; }
export PATH="$PATH:${GOPATH:-$HOME/go}/bin"

export OPENCODE_DISABLE_DEFAULT_PLUGINS=true

export NODE_EXTRA_CA_CERTS="/etc/ssl/certs/ca-certificates.crt"


# Starship init has to be at the end of the config.
eval "$(starship init bash)"
