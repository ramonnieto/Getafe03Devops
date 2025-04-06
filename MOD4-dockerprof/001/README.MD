# Proyecto: Entorno de Desarrollo con Vagrant y Docker

Este repositorio contiene un entorno de desarrollo diseñado para facilitar la comprensión del funcionamiento de un Dockerfile. El entorno utiliza Vagrant para crear máquinas virtuales y Docker para ejecutar aplicaciones dentro de contenedores.

## Contenido del Proyecto

El proyecto incluye los siguientes elementos:

- Vagrantfile: Define la configuración de las máquinas virtuales que se crearán con Vagrant.
- Dockerfile: Archivo utilizado para construir una imagen Docker que ejecuta una aplicación Flask.
- app.py: Código fuente de la aplicación Flask.
- requirements.txt: Dependencias necesarias para la aplicación Flask.
- doc001.pdf: Documentación adicional para comprender mejor el proyecto.

## Requisitos Previos

Antes de comenzar, asegúrate de tener instalado lo siguiente en tu sistema:

- Vagrant: https://www.vagrantup.com/
- VirtualBox: https://www.virtualbox.org/ (u otro proveedor compatible con Vagrant)
- Conocimientos básicos sobre Docker y Vagrant.

## Ejecución del Proyecto

Sigue estos pasos para ejecutar el proyecto:

1. Clona este repositorio:
   git clone <URL_DEL_REPOSITORIO>
   cd <NOMBRE_DEL_REPOSITORIO>

2. Inicia las máquinas virtuales con Vagrant:
   vagrant up
   Este proceso creará dos máquinas virtuales (principal y test) y aprovisionará Docker en ambas.

3. Accede a una máquina virtual:
   vagrant ssh principal

4. Construye y ejecuta el contenedor Docker:
   Una vez dentro de la máquina virtual, navega al directorio donde está el Dockerfile y ejecuta los siguientes comandos:
   docker build -t flask-app .
   docker run -d -p 5000:5000 --name flask-container flask-app

5. Prueba la aplicación Flask:
   Desde tu navegador o usando curl, accede a las APIs de la aplicación:
   - Presión: http://localhost:5000/api/pressure
   - Temperatura: http://localhost:5000/api/temperature
   - Humedad: http://localhost:5000/api/humidity

   Ejemplo con curl:
   curl http://localhost:5000/api/temperature

## Documentación Adicional

Para una mejor comprensión del proyecto y del funcionamiento del Dockerfile, consulta el archivo doc001.pdf incluido en este repositorio.

## Notas Importantes

- Asegúrate de que las máquinas virtuales estén correctamente configuradas antes de intentar construir y ejecutar el contenedor Docker.
- Si encuentras algún problema durante la ejecución, revisa los logs de Vagrant y Docker para identificar posibles errores.

## Contribuciones

Si deseas contribuir al proyecto, abre un issue o envía un pull request con tus sugerencias o correcciones.

---

Gr