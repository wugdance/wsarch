sudo -u "${WSARCH_USER}" -i npm install -g --ignore-scripts @earendil-works/pi-coding-agent

mkdir -p "${WSARCH_USER_HOME}/.pi"
ln -sf "${WSARCH_ROOT}/config/pi" "${WSARCH_USER_HOME}/.pi/agent"
