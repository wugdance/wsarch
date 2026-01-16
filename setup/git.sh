echo "Setup git..."

source install/git.sh

# TODO: Define user email dynamically.
git config --global user.email "sintes4ek@gmail.com"
git config --global user.name "Alexander Ryabyshkin"

echo "git setup has finished."
