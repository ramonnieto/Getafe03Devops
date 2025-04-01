text
# Ejercicio: Persistencia de Datos con Docker y Vagrant

Este ejercicio demuestra cómo configurar una aplicación Flask con persistencia de datos utilizando Docker y Vagrant. La aplicación almacena usuarios en una base de datos SQLite persistente mediante volúmenes Docker.

## **Instrucciones**

### **1. Requisitos previos**
- Tener instalado:
  - [Vagrant](https://www.vagrantup.com/downloads)
  - [VirtualBox](https://www.virtualbox.org/)
  - `curl` (para probar la API)

### **2. Pasos para ejecutar el ejercicio**

#### **Paso 1: Iniciar Vagrant**
Ejecuta el siguiente comando en el directorio del proyecto para iniciar la máquina virtual:
vagrant up

text

Esto configurará una máquina virtual basada en `bento/ubuntu22.04` con Docker y Docker Compose preinstalados.

#### **Paso 2: Acceder al directorio sincronizado**
Una vez que la máquina virtual esté lista, accede al directorio sincronizado `/vagrant`:
vagrant ssh
cd /vagrant

text

#### **Paso 3: Iniciar los contenedores**
Levanta los contenedores Docker con el siguiente comando:
docker compose up -d

text

#### **Paso 4: Probar la API**
Envía una solicitud POST para crear un usuario:
curl -X POST -H "Content-Type: application/json"
-d '{"username":"testuser","password":"securepass"}'
http://192.168.33.10:5000/users

text

Si todo funciona correctamente, recibirás una respuesta indicando que el usuario fue creado:
{"message": "User created"}

text

#### **Paso 5: Intentar crear el mismo usuario nuevamente**
Repite el comando anterior. Ahora deberías recibir un error porque el nombre de usuario ya existe:
{"message": "UNIQUE constraint failed: users.username"}

text

#### **Paso 6: Detener y reiniciar los contenedores**
Detén los contenedores con:
docker compose down

text

Luego, reinicia los contenedores:
docker compose up -d

text

#### **Paso 7: Verificar la persistencia de datos**
Después de reiniciar los contenedores, verifica que el usuario creado previamente aún existe. Puedes hacerlo añadiendo temporalmente una ruta en la API para listar usuarios o inspeccionando directamente la base de datos SQLite (ver sección avanzada).

---

## **Detalles avanzados**

### **Inspeccionar la base de datos SQLite**
1. Accede al contenedor:
docker exec -it vagrant-app-1 bash

text

2. Usa `sqlite3` para abrir la base de datos persistente:
sqlite3 /app/data/users.db

text

3. Consulta los usuarios almacenados:
SELECT * FROM users;

text

### **Verificar persistencia desde el host**
Copia el archivo SQLite desde el volumen al host para inspeccionarlo localmente:
docker cp vagrant-app-1:/app/data/users.db ./users.db

text
Usa herramientas como DB Browser for SQLite para abrirlo.

---

## **Notas importantes**
- El volumen Docker asegura que los datos persistan incluso después de detener o eliminar los contenedores.
- Si necesitas limpiar completamente los datos, elimina el volumen asociado con:
docker volume rm vagrant_data_volume

text

---

## **Conclusión**
Este ejercicio demuestra cómo usar volúmenes Docker para garantizar la persistencia de datos en aplicaciones basadas en contenedores. Puedes reutilizar esta configuración para otros proyectos que requieran almacenamiento persistente.
