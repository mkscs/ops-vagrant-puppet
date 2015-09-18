#!/usr/bin/env bash

REPO="http://apt.puppetlabs.com/puppetlabs-release-pc1-vivid.deb"

echo "Configuring PuppetLabs repo"
repo_deb_path=$(mktemp)
wget --output-document=${repo_deb_path} ${REPO} 2>/dev/null
dpkg -i ${repo_deb_path} >/dev/null
apt-get update >/dev/null

# Install Puppet
echo "Installing Puppet Agent"
apt-get install -y puppet >/dev/null
