echo "Init hunk..."

# hunkdiff ships its CLI through npm, so this module needs node from
# boot/modules/lang/js.sh (sourced before this one in boot/init.sh).
sudo -u "${WSARCH_USER}" -i npm install -g --ignore-scripts hunkdiff

# If ~/.config/hunk exists as a real directory (e.g. hunk was used before the
# first boot), a plain ln -sf would nest the symlink INSIDE it instead of
# replacing it. Only a non-symlink is replaced: the repo is the single source
# of truth for hunk's config.
if [[ ! -L "${WSARCH_USER_HOME}/.config/hunk" ]]; then
    rm -rf "${WSARCH_USER_HOME}/.config/hunk"
fi
ln -sf "${WSARCH_ROOT}/config/hunk" "${WSARCH_USER_HOME}/.config/hunk"

echo "hunk init has completed."
