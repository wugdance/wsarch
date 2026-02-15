# Enable appending mode for history commands so they persist after 
# a session ends and across different shell sessions.
shopt -s histappend        

# Save multiline commands in history as the whole.
shopt -s cmdhist           

# Store multiline commands with line breaks. Without this they will be 
# compressed into one liners.
shopt -s lithist           

# Expand a command when accessing with ! (like !12) before run it.
shopt -s histverify

# Number of commands kept in memory (current session). Makes fzf much more 
# powerful for really old commands or if there are many of thems.
HISTSIZE=50000

# Maximum number of commands stored on disk (~/.bash_history).
HISTFILESIZE=100000

# Enable showing date and time when command was run.
HISTTIMEFORMAT='%F %T  '

# Don't store duplicates.
HISTCONTROL=erasedups
