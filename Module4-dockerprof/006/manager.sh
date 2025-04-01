#!/bin/bash
# Actualizar la lista de paquetes disponibles
apt-get update

# Instalar paquetes para permitir que APT utilice un repositorio HTTPS
apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release 

# Añadir la clave GPG oficial de Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Añadir el repositorio de Docker a la lista de fuentes de APT
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" |  tee /etc/apt/sources.list.d/docker.list > /dev/null

# Actualizar la lista de paquetes disponibles con los nuevos paquetes de Docker
apt-get update

# Instalar la última versión de Docker
apt-get install -y docker-ce docker-ce-cli containerd.io

# Agregar usuario vagrant a grupo docker correctamente

usermod -aG docker vagrant
# agregamos a un cluster (como manager) al host

docker swarm init --advertise-addr 192.168.57.20 --listen-addr 192.168.57.20
#creamos ala red overlay

docker network create -d overlay devops

#agregamos un servicio

docker service create --name=test-devops --network devops -p 80:80 gilbertfongan/demo:v1

#entradas al fichero host
echo "192.168.57.20 manager" >> /etc/hosts
echo "192.168.57.21 worker1" >> /etc/hosts
echo "192.168.57.22 worker2" >> /etc/hosts
echo "192.168.57.23 worker3" >> /etc/hosts

echo "APROVISIONAMIENTO EJECUTADO"
