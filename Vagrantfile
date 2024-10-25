# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # Requested variables
  PROXY_URL = "http://10.20.0.1:8080"
  PROXY_ENABLE = false
  BASE_INT_NETWORK = "10.10.20"
  BASE_HOST_ONLY_NETWORK = "192.168.56"

  # Extra variables
  NAME_WEB = "web.m340"
  NAME_DB = "db.m340"
  BOX_IMAGE = "ubuntu/jammy64"
  HOST_ONLY_ADAPTER = "VirtualBox Host-Only Ethernet Adapter"
  SYNCED_FOLDER_HOST = "src/"
  SYNCED_FOLDER_GUEST = "/var/www/html"
  SSH_INSERT_KEYS = false

  config.vm.define "web" do |subconfig|
    subconfig.vm.box = BOX_IMAGE

    # Set vm name and hostname
    subconfig.vm.hostname = NAME_WEB
    subconfig.vm.provider "virtualbox" do |vb|
      vb.name = NAME_WEB
      vb.memory = "4092"
      vb.cpus = 2
    end

    # Synced folder (create folder if doesn't exists)
    subconfig.vm.synced_folder SYNCED_FOLDER_HOST, SYNCED_FOLDER_GUEST, create: true

    # Network, proxy and ssh configurations
    subconfig.vm.network "private_network", ip: "#{BASE_INT_NETWORK}.10", virtualbox__intnet: true
    subconfig.vm.network "private_network", ip: "#{BASE_HOST_ONLY_NETWORK}.10",  name: HOST_ONLY_ADAPTER
    subconfig.ssh.insert_key = SSH_INSERT_KEYS

    if Vagrant.has_plugin?("vagrant-proxyconf") && PROXY_ENABLE
      subconfig.proxy.http = PROXY_URL
      subconfig.proxy.https = PROXY_URL
      subconfig.proxy.no_proxy = "localhost,127.0.0.1"
    end

    # Bash script to config VM
    subconfig.vm.provision "shell", path: "scripts/general.sh"
    subconfig.vm.provision "shell", path: "scripts/web.sh"
  end

  config.vm.define "db" do |subconfig|
    subconfig.vm.box = BOX_IMAGE

    # Set vm name and hostname
    subconfig.vm.hostname = NAME_DB
    subconfig.vm.provider "virtualbox" do |vb|
      vb.name = NAME_DB
      vb.memory = "4092"
      vb.cpus = 2
    end

    # Network, proxy and ssh configurations
    subconfig.vm.network "private_network", ip: "#{BASE_INT_NETWORK}.11", virtualbox__intnet: true
    subconfig.ssh.insert_key = SSH_INSERT_KEYS

    if Vagrant.has_plugin?("vagrant-proxyconf") && PROXY_ENABLE
      subconfig.proxy.http = PROXY_URL
      subconfig.proxy.https = PROXY_URL
      subconfig.proxy.no_proxy = "localhost,127.0.0.1"
    end

    # Bash script to config VM
    subconfig.vm.provision "shell", path: "scripts/general.sh"
    subconfig.vm.provision "shell", path: "scripts/db.sh"
  end
end
