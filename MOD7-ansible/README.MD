# Ansible y Ansible Navigator: Guía de Instalación y Configuración

## Requisitos Previos
- **Equipo Manager**: Rocky Linux 9 con usuario `vagrant` (sudo sin contraseña).
- **Nodos Administrados**:
  - **nodo1**: Rocky Linux 9.
  - **nodo2**: Rocky Linux 8.
  - **nodo3**: Ubuntu 24.04.
- **Acceso SSH**: El usuario `vagrant` debe tener permisos de sudo sin contraseña en todos los nodos.

---

## Instalación

### 1. Actualizar Sistema
sudo dnf update -y


### 2. Instalar Paquetes Necesarios
sudo dnf install -y epel-release ansible python3-pip podman


### 3. Instalar Ansible Navigator via pip
pip install --user ansible-navigator


### 4. Generar Clave SSH ED25519
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -N ""

### 5. Configurar Resolución de Nombres (`/etc/hosts`)
echo "192.168.56.10 nodo1" | sudo tee -a /etc/hosts
echo "192.168.56.11 nodo2" | sudo tee -a /etc/hosts
echo "192.168.56.12 nodo3" | sudo tee -a /etc/hosts

### 6. Copiar Clave Pública a los Nodos
ssh-copy-id -i ~/.ssh/id_ed25519.pub vagrant@nodo1
ssh-copy-id -i ~/.ssh/id_ed25519.pub vagrant@nodo2
ssh-copy-id -i ~/.ssh/id_ed25519.pub vagrant@nodo3


### 7. Configurar Ansible
- **Vincular archivos de configuración** desde `/vagrant`:
sudo cp /vagrant/ansible.cfg ~/ansible.cfg
sudo cp /vagrant/ansible-navigator.yml ~/ansible-navigator.yml
sudo cp /vagrant/inventario ~/inventario


---

## Conceptos Clave

### **Ansible (Comando)**
- **Descripción**: Ejecuta tareas ad-hoc o playbooks.
- **Ejemplo**:
ansible all -m ping


### **ansible-config**
- **Descripción**: Muestra o modifica la configuración de Ansible.
- **Ejemplo**:
ansible-config dump --only-changed


### **ansible-doc**
- **Descripción**: Consulta documentación de módulos.
- **Ejemplo**:
ansible-doc yum


### **ansible-navigator**
- **Descripción**: Herramienta interactiva para ejecutar playbooks en entornos de ejecución (EE).
- **Diferencias**:
- Soporta contenedores (Podman/Docker).
- Interfaz TUI para navegación.
- Ejecución en entornos aislados.

---

## Sintaxis de `ansible-navigator`

| Comando | Opción | Descripción |
|---------|--------|-------------|
| `exec` | `-m <módulo>` | Ejecuta un módulo específico. |
| `run` | `-p <playbook>` | Ejecuta un playbook. |
| `inventory` | `-i <inventario>` | Muestra información del inventario. |
| `settings` | `-c <archivo>` | Configura opciones del entorno. |

---

## Uso de Documentación

### **Buscar Módulo con `ansible-doc`**
ansible-doc -l | grep apache


### **Ver Documentación con `ansible-navigator`**
ansible-navigator doc yum --mode stdout


---

## Verificación
ansible all -m ping -i /vagrant/inventario
ansible-navigator run /vagrant/playbook.yml --ee false

---

## Notas
- Los archivos `ansible.cfg` e `inventario` deben estar en `/vagrant`.
- Para usar entornos de ejecución (EE), asegúrate de que Podman esté activo.
