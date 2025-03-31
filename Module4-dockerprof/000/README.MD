# README.md

## Descripción del Proyecto

Este archivo **Vagrantfile** configura un entorno virtualizado utilizando **Vagrant**, una herramienta de infraestructura como código. Permite la creación y gestión de máquinas virtuales de forma automatizada para entornos de desarrollo consistentes y reproducibles. Al ejecutar el comando `vagrant up`, se provisiona automáticamente un entorno virtual con las configuraciones especificadas en el Vagrantfile, facilitando el trabajo colaborativo y evitando problemas de compatibilidad entre sistemas.

### Características principales:
- **Automatización**: Configuración y aprovisionamiento automático de máquinas virtuales.
- **Reproducibilidad**: Garantiza entornos consistentes para desarrollo y pruebas.
- **Compatibilidad**: Soluciona problemas entre diferentes sistemas operativos.
- **Control de versiones**: El Vagrantfile puede ser compartido y versionado.

## Comandos Docker

### Comandos para Imágenes
1. **docker images**  
   Lista todas las imágenes disponibles en el sistema local.  
   Ejemplo: `docker images`

2. **docker pull <imagen>**  
   Descarga una imagen desde un registro como Docker Hub.  
   Ejemplo: `docker pull ubuntu:latest`

3. **docker rmi <imagen>**  
   Elimina una imagen específica del sistema.  
   Ejemplo: `docker rmi ubuntu:latest`

4. **docker image prune**  
   Elimina imágenes no utilizadas para liberar espacio.  
   Ejemplo: `docker image prune -a`

### Comandos para Contenedores
1. **docker container ls**  
   Lista todos los contenedores en ejecución.  
   Ejemplo: `docker container ls`

2. **docker container create <imagen>**  
   Crea un nuevo contenedor basado en una imagen existente sin ejecutarlo.  
   Ejemplo: `docker container create ubuntu:latest`

3. **docker container start <contenedor>**  
   Inicia uno o más contenedores previamente creados.  
   Ejemplo: `docker container start my-container`

4. **docker container stop <contenedor>**  
   Detiene uno o más contenedores en ejecución.  
   Ejemplo: `docker container stop my-container`

5. **docker container rm <contenedor>**  
   Elimina uno o más contenedores detenidos.  
   Ejemplo: `docker container rm my-container`

6. **docker container logs <contenedor>**  
   Muestra los registros de un contenedor específico.  
   Ejemplo: `docker container logs my-container`

### Comandos Generales
1. **docker ps -a**  
   Lista todos los contenedores, incluyendo los detenidos.  
   Ejemplo: `docker ps -a`

2. **docker system prune**  
   Limpia el sistema eliminando contenedores detenidos, imágenes colgadas y caché no utilizada.  
   Ejemplo: `docker system prune`

---

Este archivo README.md proporciona una descripción clara del propósito del Vagrantfile y un listado útil de comandos Docker para gestionar imágenes y contenedores.
