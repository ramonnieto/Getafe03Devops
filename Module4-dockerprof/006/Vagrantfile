# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  # Configuración de la máquina virtual manager con Docker instalado
  config.vm.define "docker" do |docker|
    docker.vm.box = "ubuntu/jammy64"
    docker.vm.hostname = "manager-swarm"
    docker.vm.network "private_network", ip: "192.168.57.20"
    docker.vm.provider "virtualbox" do |vb|
      vb.name = "manager-swarm"
      vb.memory = 2048  # Asigna 2 GB de memoria RAM
    end
    docker.vm.provision "shell", path: "manager.sh"

  end

  # Configuración de dos máquinas virtuales objetivo
  (1..3).each do |i|
    config.vm.define "objetivo#{i}" do |objetivo|
      objetivo.vm.box = "ubuntu/jammy64"
      objetivo.vm.hostname = "worker#{i}"
      objetivo.vm.network "private_network", ip: "192.168.57.#{i+20}"
      objetivo.vm.provider "virtualbox" do |vb|
        vb.name = "worker#{i}"
        vb.memory = 1024  # Asigna 1 GB de memoria RAM
      end
      objetivo.vm.provision "shell", path: "worker.sh"
    end
  end

end
