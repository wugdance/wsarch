# Enable vi mode.
set -o vi

bind -m vi-command '"/": history-incremental-search-backward'
bind -m vi-command '"?": history-incremental-search-forward'
