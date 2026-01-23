echo "Init openssh..."

source install/openssh.sh

systemctl --user enable ssh-agent.service

echo "openssh init has completed."