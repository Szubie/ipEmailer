# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "debian/contrib-jessie64"
  config.vm.box_version = "8.6.2"

  config.ssh.forward_agent = true
  config.ssh.forward_x11 = true

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--natdnsproxy1", "off"]

    vb.name = "debian"
    vb.memory = "2048"
    vb.cpus = 4
  end

  config.vm.synced_folder ".", "/home/vagrant/bash/ipEmailer"
  #config.vm.provision :shell, :privileged => false, :path => "setup.sh"

  # Create a public network
  config.vm.network :public_network, bridge: "wlp3s0"


end
