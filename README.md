# ops-vagrant-puppet
Vagrantfiles for images built with packer

# ops-vagrant-puppet
Vagrantfiles for images built with packer

**Ubuntu - puppet**
- Installs and configures puppet master & puppet agent
  - manages forge's puppet modules with librarian-puppet
  - contains profiles & roles puppetcode

**Ubuntu Snappy**

*issues*
  - NFS and private networking does not work with current Vagrant

**CoreOS**

*issues*
  - NFS and private networking does not work with current Vagrant

**RancherOS**
- contains certs/ so you can connect to docker remotely via tcp
- use box built with https://github.com/mkscs/ops-packer-templates/blob/master/rancheros.json

