# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "genebean/centos-7-rvm-221"
  # config.vm.box = "debian/jessie64"
  # config.vm.box = "debian/stretch64"
  # config.vm.box = "ubuntu/bionic64"
  # config.vm.box_check_update = false
  # config.vm.network "forwarded_port", guest: 80, host: 8080
  # config.vm.network "private_network", ip: "192.168.33.10"
  # config.vm.network "public_network"

  config.vm.network "private_network", type: "dhcp",
    virtualbox__intnet: "vboxnet1"

  config.vm.hostname = "puppet-amavisd.example.com"

  config.vm.provider "virtualbox" do |vb|
   vb.gui = false
   vb.memory = "1024"
   vb.name = "puppet-amavisd"
  end

  config.vm.provision "file", source: "Gemfile", destination: "/tmp/Gemfile"
  config.vm.provision "file", source: "vagrant_files/hiera.yaml", destination: "/tmp/hiera.yaml"
  config.vm.provision "shell", path: "vagrant_files/centos7-init.sh"
  # config.vm.provision "shell", path: "vagrant_files/debian-jessie-init.sh"
  # config.vm.provision "shell", path: "vagrant_files/debian-stretch-init.sh"
  # config.vm.provision "shell", path: "vagrant_files/ubuntu-bionic-init.sh"

  config.vm.synced_folder ".", "/etc/puppetlabs/code/modules/amavisd"
  # config.vm.synced_folder ".", "/etc/puppetlabs/code/modules/amavisd", type: 'rsync'

  config.ssh.insert_key = false
end
