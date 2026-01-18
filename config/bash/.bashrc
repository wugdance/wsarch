source config/bash/history.sh
source config/bash/vi-mode.sh

source config/bash/fzf.sh

source /usr/share/bash-completion/bash_completion

# Starship init has to be at the end of the config.
eval "$(starship init bash)"
