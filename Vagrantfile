# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Local Android VM for testing applications alongside local Zeto services
  config.vm.define "android" do |machine|
      machine.vm.box = "lgromb/androidx86-kk"
      machine.ssh.username = "root"
      machine.ssh.password = "vagrant"
      machine.vm.network "private_network", ip: "192.168.33.11", auto_config: false
      machine.vm.network "forwarded_port", guest: 5555, host: 5051
      machine.vm.synced_folder ".", "/vagrant", disabled: true
      machine.vm.provider "virtualbox" do |vb|
        vb.gui = true
        vb.customize ["modifyvm", :id, "--memory", "1024"]
      end
  end
end
