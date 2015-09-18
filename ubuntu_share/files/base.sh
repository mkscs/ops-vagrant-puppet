#!/usr/bin/env bash
echo "Installing cachefielsd"
apt-get install -y cachefilesd
cat <<EOF >> /etc/default/cachefilesd
RUN=yes
EOF