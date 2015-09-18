#!/usr/bin/env bash
echo "Installing cachefilesd"
apt-get install -y cachefilesd
cat <<EOF >> /etc/default/cachefilesd
RUN=yes
EOF