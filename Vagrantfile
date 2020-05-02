# -*- mode: ruby -*-
# vi: set ft=ruby :

BOX_1_NAME = "debian-1-guacamole"
BOX_2_NAME = "debian-2-guacamole"
BOX_3_NAME = "win2019-1-guacamole"
BOX_BASE = "generic/debian10"
BOX_WINBASE = "rgl/windows-server-2019-standard-amd64"
BOX_RAM_MB = 1024
BOX_WRAM_MB = 2*1024
BOX_CPU_COUNT = 1
BOX_WCPU_COUNT = 2
BOX_GUI = false
BOX_SYNC_DIR = true

Vagrant.configure("2") do |config|

  config.vm.define BOX_1_NAME do |deb1|
    deb1.vm.box = BOX_BASE
    deb1.vm.synced_folder ".", "/vagrant", disabled: BOX_SYNC_DIR
    deb1.vm.hostname = BOX_1_NAME
    deb1.vm.network "private_network", ip: "192.168.10.5"
    deb1.vm.provider "virtualbox" do |vb1|
      vb1.name = BOX_1_NAME
      vb1.cpus = BOX_CPU_COUNT
      vb1.memory = BOX_RAM_MB
      vb1.gui = BOX_GUI
    end
    deb1.vm.provision "shell", inline: <<-SHELL
     apt-get -qq update
     apt-get -qq install sl cmatrix
    SHELL
  end

  config.vm.define BOX_2_NAME do |deb2|
    deb2.vm.box = BOX_BASE
    deb2.vm.synced_folder ".", "/vagrant", disabled: BOX_SYNC_DIR
    deb2.vm.hostname = BOX_2_NAME
    deb2.vm.network "forwarded_port", guest: 55555, host: 55555
    # deb2.vm.network "forwarded_port", guest: 5901, host: 5901
    # deb2.vm.network "forwarded_port", guest: 3389, host: 3389
    # deb2.vm.network "forwarded_port", guest: 23, host: 2323
    deb2.vm.network "private_network", ip: "192.168.10.10"
    deb2.vm.provider "virtualbox" do |vb2|
      vb2.name = BOX_2_NAME
      vb2.cpus = BOX_CPU_COUNT
      vb2.memory = BOX_RAM_MB
      vb2.gui = BOX_GUI
    end
    deb2.vm.provision "file", source: "./src", destination: "/tmp/guacamole"
    deb2.vm.provision "shell", name: "install", path: "./ShellProvisioner.sh"
  end

  config.vm.define BOX_3_NAME do |win1|
    win1.vm.box = BOX_WINBASE
    win1.vm.synced_folder ".", "/vagrant", disabled: BOX_SYNC_DIR
    win1.vm.hostname = BOX_3_NAME
    win1.vm.network "private_network", ip: "192.168.10.15"
    win1.vm.provider "virtualbox" do |vb3|
      vb3.name = BOX_3_NAME
      vb3.cpus = BOX_WCPU_COUNT
      vb3.memory = BOX_WRAM_MB
      vb3.gui = BOX_GUI
    end
  end
end
