# MODULE 3 JENKINS

## Notas del profe: modificado a 30 marzo 2025 sobre revisiones de 2023
revisiones varias de las versiones - Vagrant box -- bento/ubuntu-22.04 -- pérdida de soporte en jenkins dentro de unos días
en el equipo con Tomcat: - uso de openjdk17 -- tomcat es la version 9.0.100
	script de tomcat con modificaciones del xml de users - admin: vagrant - password vagrant
Fichero jenkinsfile modificado por las actualizaciones d elos plugins - cambió algún elemnto de sintaxis que no recuerdo en un update (la maldición de las versiones)

Procedimiento

jenkins - 
1) registro de la password

2) agregar plugins recomendados

3) crear usuario 'vagrant' password 'vagrant' (para reducir la complejidad y adecuarlo al entorno de trabajo)

4)Agregar varios plugins (algunos ya no se encuentran pero ... funciona). Los actuales son: 
- Maven IntegrationVersion
3.25
- Pipeline Maven IntegrationVersion
1508.v347c4b_692202
- Copy ArtifactVersion
765.v0357cc6e6eb_3
- Deploy to containerVersion
1.16
- JUnit Realtime Test ReporterVersion
166.v889e7b_0e23a_a_

5) Configurar JDK (según nombres de Jenkinfile -withMaven) -- En Jenkins > administración de jenkins> Tools> instalaciones de JDK > \
Nombre - JenkinsJDK - JAVA_HOME - /usr/lib/jvm/java-17-openjdk-amd64

6) en la misma herramienta _ Instalación de Maven - Nombre -JenkinsMAVEN - Instalar desdeapche 3.9.9 

7) administración jenkins> nodes > modificar principal (label master)

8) En la misma ubicación: new node> slave-tomcat - permanent > directorio raíz /tmp > etiqueta(label) slave-tomcat - método ejecución > unix ssh > nombre máquina 172.17.8.163 > credenciales ADD > ssh con password vagrant password vagrant APLICAR > credentials vagrant/****** > host key startegy > Manually trusted key verification (para evitar tener que aceptar el fingerprint) > guargar

9) verificar el agente con > consola interactiva > println "id".execute().text y debe devolver vagrant... etc

10) Comprobación de funcionamiento d elos agentes mediante un pipeline (está en el repositorio ComprobarNodos.txt). Nueva tarea > ComprobarNodos > script (pegar pipeline) - aceptar- build (construir). Ver el resultado pulsando en el build

11) Ejecutar el pipeline de Gilbert (con lasmificaciones de actualización) > Nueva tarea > (Mismo nombre que en project del pilenine) JavaSampleAppDeploy (parece que ya no es necesario con la nueva versión del plugin) > > pipeline > aceptar

12) configurar la tarea: Permision to copy artifact (valor *) > Pipeline script (pegar jenkinsfile) ATENCIÓN!!!!! el id de conexión debe ser el de usuario vagrant (administrar jenkins> credenciales).

13) elevar plegarias a Molock, Chutlu, Loki, Zeus o a Faemino y verificar en http://localhost:8081/devops/
====================================
BOXES
la solución es funcional pero un poco larga. Se han creado ficheros box (imágenes ya preconfiguradas  con el software y la configuración) accesibles desde https://mega.nz/folder/jzQEDJhC#lUpFPGNzIkXy6RDtKkKTuA
Procedimiento de instalación: 
1) descargar los boxes
2) agregar con: #vagrant box add (cadena de texto parausar con vm.box) jenkins.box (realizar la misma tarea con tomcat.box)
3) Uso en Vagrantfile usando la cadena que se haya definido.



## Context

Jenkins is an open source automation server which enables developers around the world to reliably build, test, and deploy their software.

It helps automate the build, test and deployment parts of software development, and facilitates continuous integration and continuous delivery. Written in Java, Jenkins runs in a servlet container such as Apache Tomcat, or in standalone mode with its own embedded web server. 



## Outlines

Part      | Description
----------|-------
Part 1    | Prepare the environment
Part 2    | Configuring Jenkins and initial job
Part 3    | Jenkins integration with Git
Part 4    | Deployment with Tomcat
Part 5    | Complete CI/CD with Jenkins Declarative Pipeline


## Virtual Machines

Server        | IP Address      |  Vagrant box
--------------|-----------------|---------------
Jenkins       | 172.17.8.163    | bento/ubuntu-20.04
Tomcat        | 172.17.8.164    | bento/ubuntu-20.04


## Setting

- Jenkins node

Tools (Jenkins)           | Versions
--------------------------|-------
Jenkins                   | 2.462.2
Git                       | 2.25.1
Openjdk                   | 17

- Tomcat node

Tools (Tomcat)            | Versions
--------------------------|-------
Tomcat                    | 9.0.93
Openjre                   | 17

## Ongoing Tests

Tested on September 09, 2024 : 
- Steps during vagrant initialization for Jenkins-Ubuntu-VM.
$ vagrant up

![Jenkins](images/JenkinsVM.png)

- Steps during vagrant initialization for Tomcat-Ubuntu-VM.
$ vagrant up

![Tomcat](images/TomcatVM.png)

## Issues and troubleshooting

- Tomcat Version : 404 Not Found (Update Tomcat version with the appropriate value in tomcat.sh : TOMCAT_VERSION="9.0.80" -> TOMCAT_VERSION=[NEW_VERSION])
- If you have an connection timeout when booting the VM and an error on type "kernel panic not syncing attempted to kill the idle task" on the console, it will be necessary to upgrade the number of CPU on Vagrantfile (Example : From 1 to 2)
