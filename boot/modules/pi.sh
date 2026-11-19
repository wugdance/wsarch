echo "Init pi..."

# pi is installed through npm, so this module needs node from
# boot/modules/lang/js.sh (sourced before this one in boot/init.sh).
sudo -u "${WSARCH_USER}" -i npm install -g --ignore-scripts @earendil-works/pi-coding-agent

mkdir -p "${WSARCH_USER_HOME}/.pi"
ln -sf "${WSARCH_ROOT}/config/pi" "${WSARCH_USER_HOME}/.pi/agent"

echo "pi init has completed."
