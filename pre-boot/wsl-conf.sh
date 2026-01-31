echo "Setup wsl specific settings."

cat <<EOF >> /etc/wsl.conf

[interop]
enabled = true
appendWindowsPath = true
EOF

echo "wsl setup has completed."
