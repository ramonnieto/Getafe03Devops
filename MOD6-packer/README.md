
# Guía Completa: Creación de una Imagen Automatizada de Ubuntu 22.04 Server LTS con Packer y VirtualBox

## Introducción

Esta guía proporciona instrucciones detalladas para crear una imagen automatizada de **Ubuntu 22.04 Server LTS** utilizando **Packer** en formato **HCL2** para el hipervisor **VirtualBox**. La imagen resultante incluirá un usuario llamado `curso` con contraseña `qwerty` (cifrada con SHA-512), configurará el sistema y el teclado en español, instalará únicamente el servicio **OpenSSH Server** y estará preparada para su uso en sistemas host tanto **Linux** como **Windows**. Además, se abordarán problemas comunes, se explicará cómo adaptar la configuración para **Proxmox**, y se describirá la integración con **Ansible** para automatizar configuraciones post-instalación.

## 1. Instalación de Packer

### 1.1. En Linux (Ubuntu)

```bash
sudo apt update && sudo apt upgrade -y
sudo apt install -y wget unzip
wget https://releases.hashicorp.com/packer/1.9.4/packer_1.9.4_linux_amd64.zip
unzip packer_1.9.4_linux_amd64.zip
sudo mv packer /usr/local/bin/
packer version
```

### 1.2. En Windows

1. Descargar Packer desde https://developer.hashicorp.com/packer/downloads
2. Extraer el ZIP y añadir la carpeta a la variable de entorno PATH
3. Verificar con `packer version` desde la consola

## 2. Diferencias entre HCL2 y JSON en Packer

- HCL2 es más legible y modular.
- Soporta variables y funciones complejas.
- HashiCorp recomienda HCL2 para nuevos proyectos.

## 3. Preparación del Entorno

```bash
wget https://releases.ubuntu.com/22.04/ubuntu-22.04-live-server-amd64.iso
sha256sum ubuntu-22.04-live-server-amd64.iso
```

## 4. Archivos de Proyecto

### `ubuntu.pkr.hcl`

```hcl
variable "iso_url" { default = "file:///path/to/ubuntu-22.04-live-server-amd64.iso" }
variable "iso_checksum" { default = "SHA256:your_iso_checksum" }
variable "ssh_username" { default = "curso" }
variable "ssh_password" { default = "qwerty" }
variable "vm_name" { default = "ubuntu-2204-server" }

source "virtualbox-iso" "ubuntu" {
  iso_url            = var.iso_url
  iso_checksum       = var.iso_checksum
  ssh_username       = var.ssh_username
  ssh_password       = var.ssh_password
  ssh_wait_timeout   = "20m"
  shutdown_command   = "echo '${var.ssh_password}' | sudo -S shutdown -P now"
  guest_os_type      = "Ubuntu_64"
  vm_name            = var.vm_name
  disk_size          = 10240
  hard_drive_interface = "sata"
  headless           = true
  boot_wait          = "5s"
  communicator       = "ssh"
  http_directory     = "http"
  boot_command = [
    "<esc><wait>",
    "<enter><wait>",
    "/install/vmlinuz auto ",
    "locale=es_ES ",
    "keyboard-configuration/layoutcode=es ",
    "console-setup/layoutcode=es ",
    "file=/cdrom/preseed.cfg ",
    "initrd=/install/initrd.gz ",
    " --- <enter>"
  ]
}

build {
  sources = ["source.virtualbox-iso.ubuntu"]
  provisioner "shell" {
    inline = ["echo 'Provisioning complete'"]
  }
}
```

### `variables.pkr.hcl`

```hcl
variable "iso_url" {}
variable "iso_checksum" {}
variable "ssh_username" {}
variable "ssh_password" {}
variable "vm_name" {}
```

### `http/autoinstall.yaml`

```yaml
#cloud-config
autoinstall:
  version: 1
  locale: es_ES
  keyboard:
    layout: es
  identity:
    hostname: ubuntu-server
    username: curso
    password: "$6$abcdefgh$Bzg58Ex4JKlmYHqFfJvljknfaLmyUs8qZmbQhUZvB0kOofmK.5P2gpbBzIykx6j7kKk1ZsmDpH1K8XkaEZD6a1"
  ssh:
    install-server: true
    allow-pw: true
  packages: []
  storage:
    layout:
      name: direct
```

## 5. Comandos para construir

```bash
packer init .
packer validate .
packer build .
```

## 6. Verificación

Verificar idioma, teclado, usuario `curso`, SSH y que solo esté instalado openssh.

## 7. Para Proxmox

Cambiar `virtualbox-iso` por `qemu`, salida en `qcow2` y subir al almacenamiento.

## 8. Automatización con Ansible

```yaml
- name: Configuración postinstalación
  hosts: all
  become: yes
  tasks:
    - name: Crear archivo de prueba
      file:
        path: /home/curso/prueba_ansible.txt
        state: touch
        owner: curso
```

## 9. Problemas comunes

- ISO incorrecta: revisa ruta y checksum
- Teclado en inglés: ajusta `keyboard:` en autoinstall
- Usuario no creado: revisa contraseña cifrada
- Sin red: cambia adaptador de red en VirtualBox

## 10. Referencias

- https://developer.hashicorp.com/packer
- https://ubuntu.com/server/docs/install/autoinstall
- https://www.virtualbox.org/manual/
- https://mkpasswd.net/
- https://docs.ansible.com/
