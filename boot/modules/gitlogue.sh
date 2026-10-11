echo "Init gitlogue..."

# gitlogue-bin tracks the upstream release. Package installation avoids keeping
# a manually downloaded binary in ~/.local/bin where it would shadow /usr/bin.
sudo -u "${WSARCH_USER}" -i paru -S --noconfirm --needed --skipreview gitlogue-bin

# Remove the upstream installer's copy, if present. Otherwise it shadows the
# package-owned binary because ~/.local/bin precedes system directories in PATH.
rm -f "${WSARCH_USER_HOME}/.local/bin/gitlogue"

# gitlogue resolves its configuration as ~/.config/gitlogue.
# Keep the whole directory under wsarch version control.
gitlogue_config="${WSARCH_USER_HOME}/.config/gitlogue"
gitlogue_repo_config="${WSARCH_ROOT}/config/gitlogue"

if [[ -L "${gitlogue_config}" ]]; then
    if [[ "$(readlink "${gitlogue_config}")" != "${gitlogue_repo_config}" ]]; then
        echo "Refusing to replace non-wsarch gitlogue config symlink: ${gitlogue_config}" >&2
        exit 1
    fi
elif [[ -e "${gitlogue_config}" ]]; then
    echo "Refusing to overwrite existing gitlogue config directory: ${gitlogue_config}" >&2
    echo "Move it aside, then rerun gitlogue init." >&2
    exit 1
else
    sudo -u "${WSARCH_USER}" mkdir -p "${WSARCH_USER_HOME}/.config"
    ln -fsn "${gitlogue_repo_config}" "${gitlogue_config}"
fi
