source config/bash/history.sh
source config/bash/vi-mode.sh

# source /usr/share/bash-completion/bash_completion
source /usr/share/fzf/key-bindings.bash

# Starship init has to be at the end of the config.
eval "$(starship init bash)"
