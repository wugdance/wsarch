echo "Init git..."

source install/git.sh

# TODO: Define user email dynamically.
git config --global user.email "sintes4ek@gmail.com"
git config --global user.name "Alexander Ryabyshkin"

git config --global core.pager "delta"
git config --global delta.navigate true
git config --global delta.line-numbers "true"

git config --global delta.true-color "always"
git config --global delta.dark "true"
git config --global delta.syntax-theme "rose-pine"

git config --global delta.minus-style "syntax \"#6d405c\""
git config --global delta.minus-emph-style "syntax bold \"#9d5270\""
git config --global delta.line-numbers-minus-style "\"#eb6f92\" normal"

git config --global delta.plus-style "syntax \"#394d60\""
git config --global delta.plus-emph-style "syntax bold \"#487382\""
git config --global delta.line-numbers-plus-style "\"#9ccfd8\" normal"

git config --global delta.whitespace-error-style "syntax \"#f6c177\""

delta --generate-completion bash

echo "git init has completed."