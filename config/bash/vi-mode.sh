# Enable vi mode.
set -o vi

# Tell bash to add the mode indicator to the prompt
bind 'set show-mode-in-prompt on'

# Optional: Change the cursor color/shape based on mode
# (Requires a terminal that supports DECSCUSR sequences, like iTerm2, VS Code, or Linux TTY)
bind 'set vi-cmd-mode-string \1\e[2 q\2'      # Block cursor for Normal mode
bind 'set vi-ins-mode-string \1\e[6 q\2'      # Pipe cursor for Insert mode

# Map 'v' in normal mode to edit-and-execute-command
bind -m vi-command 'v: edit-and-execute-command'
