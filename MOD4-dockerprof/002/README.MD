# README.MD

## **Descripción del Proyecto**

Este proyecto utiliza Vagrant para crear un entorno virtualizado con tres máquinas virtuales (`central`, `nodo1`, `nodo2`) que simulan un escenario de red. Las máquinas están configuradas para trabajar en una red interna (`192.168.33.0/24`) y cumplen las siguientes funciones:

- **`central`**: Actúa como un servidor Nginx que funciona como proxy inverso hacia `nodo1`. Tiene habilitado SSL con un certificado autofirmado.
- **`nodo1`**: Ejecuta un contenedor Docker con un servidor HTTP Python que sirve una página web estática.
- **`nodo2`**: Similar a `nodo1`, pero su contenido puede ser modificado para complementar el funcionamiento del sistema.

---

## **Ejecución del Vagrantfile**

### **Requisitos Previos**
1. **Vagrant**: Instalado en tu sistema. Puedes descargarlo desde [https://www.vagrantup.com/](https://www.vagrantup.com/).
2. **VirtualBox**: Instalado como proveedor de Vagrant. Descárgalo desde [https://www.virtualbox.org/](https://www.virtualbox.org/).

### **Pasos para Ejecutar el Entorno**
1. Clona o descarga este repositorio en tu máquina local.
2. Abre una terminal y navega al directorio donde se encuentra el archivo `Vagrantfile`.
3. Ejecuta el siguiente comando para iniciar las máquinas virtuales:
   ```bash
   vagrant up
Este comando creará las tres máquinas virtuales (`central`, `nodo1`, `nodo2`) y aplicará el aprovisionamiento automático.

Una vez completado el proceso, puedes acceder a los servicios:

- **Central**: Abre un navegador y visita:
  - [http://127.0.0.1](http://127.0.0.1) (HTTP)
  - [https://127.0.0.1](https://127.0.0.1) (HTTPS, con certificado autofirmado)
- **Nodo1**: Accede directamente a [http://192.168.33.11:8080](http://192.168.33.11:8080).
- **Nodo2**: Accede directamente a [http://192.168.33.12:8080](http://192.168.33.12:8080).

### Resultado Esperado

- Visitar [http://127.0.0.1](http://127.0.0.1) mostrará la página web servida por `nodo1` ("Bienvenido a nodo1").
- Visitar [https://127.0.0.1](https://127.0.0.1) mostrará la misma página, pero a través de una conexión cifrada con SSL.
- Acceder directamente a `nodo1` y `nodo2` mostrará sus respectivas páginas web.
