echo "Init tuicr..."

# tuicr resolves its configuration as ${XDG_CONFIG_HOME}/tuicr.
tuicr_config="${WSARCH_USER_HOME}/.config/tuicr"

# Avoid creating the symlink inside an existing real config directory.
if [[ -e "${tuicr_config}" && ! -L "${tuicr_config}" ]]; then
    echo "Refusing to overwrite existing tuicr config: ${tuicr_config}" >&2
    exit 1
fi

sudo -u "${WSARCH_USER}" mkdir -p "${WSARCH_USER_HOME}/.config"
ln -fsn "${WSARCH_ROOT}/config/tuicr" "${tuicr_config}"

echo "tuicr init has completed."
