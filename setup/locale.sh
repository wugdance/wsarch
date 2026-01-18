cat <<EOF >> /etc/locale.gen
en_US.UTF-8 UTF-8
EOF

locale-gen
localectl set-locale LANG=en_US.UTF-8
