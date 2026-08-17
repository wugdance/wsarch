sudo -u "${WSARCH_USER}" -i npm install -g --ignore-scripts @earendil-works/pi-coding-agent

ln -sf "${WSARCH_ROOT}/config/pi" "${WSARCH_USER_HOME}/.config/pi"
