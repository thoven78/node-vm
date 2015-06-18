# -*- mode: ruby -*-
# vi: set ft=ruby :

unless Vagrant.has_plugin?("vagrant-hostmanager")
  raise "Plugin hostmanager not installed. Run `vagrant plugin install vagrant-hostmanager` to install the plugin."
end
# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|

  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.hostmanager.ignore_private_ip = false
  config.hostmanager.include_offline = true

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "base"

  # Configure hostname
  config.vm.define "ubuntu" do |ubuntu|
    ubuntu.vm.hostname = "trusty"
    ubuntu.hostmanager.aliases = ["trusty.ml.dev"]

    # Use the 64 bit version of Ubunutu 12.04.
    ubuntu.vm.box = "ubuntu/trusty64"

    # Setup a private network
    ubuntu.vm.network "private_network", ip: "192.168.0.7"

    # Setup virtualbox parameters
    ubuntu.vm.provider "virtualbox" do |virtualbox|
      virtualbox.memory = 4096
      virtualbox.cpus = 2
      virtualbox.name = "trusty"
    end

    # Provision with ansible to setup the vm.
    ubuntu.vm.provision "shell", path: "./provision.sh"

    # Automatically sync the project to the vm.
    ubuntu.vm.synced_folder ".", "/vagrant", disabled: true
    ubuntu.vm.synced_folder "./components", "/home/vagrant/components",
      type: "virtualbox"
    ubuntu.vm.synced_folder "./ansible", "/home/vagrant/ansible",
      type: "virtualbox"
  end

end
