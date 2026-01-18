[[ -f ~/.bashrc ]] && . ~/.bashrc

# Add key if not already loaded.
ssh-add -l &>/dev/null || ssh-add ~/.ssh/id_ed25519
