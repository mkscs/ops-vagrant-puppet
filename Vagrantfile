# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
$share = ""

$ip = '10.0.1.10'

Vagrant.configure(2) do |config|

  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.synced_folder $share, "/home/vagrant/projects", type: "nfs",
    mount_options: ['rw', 'vers=3', 'tcp', 'fsc']

  config.vm.define "ubuntu", primary: true, autostart: false do |ubuntu|
    ubuntu.vm.box = "ubu1504-docker"
    
    ubuntu.vm.network :private_network, ip: $ip
    ubuntu.vm.provision :shell, :path => "#{$share}/files/base.sh"
    ubuntu.vm.provision :shell, :path => "#{$share}/files/puppet.sh"
    
    ubuntu.vm.provision :puppet do |puppet|
      puppet.synced_folder_type = 'nfs'
      puppet.manifests_path = "#{$share}/puppet/manifests"
      puppet.manifest_file = "init.pp"
  end
end

  config.vm.define "coreos", autostart: false do |coreos|
    coreos.ssh.insert_key = false
    coreos.vm.box = "coreos-stable"
  end

end
