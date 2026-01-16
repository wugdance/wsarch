# Enable vi mode.
set -o vi

# NORMAL mode → steady block
bind 'set vi-cmd-mode-string "\1\e[2 q\2"'

# INSERT mode → steady bar
bind 'set vi-ins-mode-string "\1\e[6 q\2"'

# Time in milliseconds. Allows to switch mode rapidly.
export KEYTIMEOUT=10


# Starship init has to be at the end of the config.
eval "$(starship init bash)"
