<pre>##########   MINIKUBE (driver docker)
##### Procedimientos incluidos en Vagrantfile

curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube_latest_amd64.deb
dpkg -i minikube_latest_amd64.deb
curl -LO https://storage.googleapis.com/kubernetes-release/releases/latest/amd/kubectl 
chmod +x kubectl &&  mv ./kubectl /usr/bin/

##################################################################
PROCEDIMIENTOS A EJECUTAR EN MINIKUBE
acceso vagrant ssh minikube

##################################################################

#inicia el cluster y el plano de control. Crea un contenedor de administración

minikube start

# crear espacio de nombres si se quieren separa los servicios. Propiedad de l kernel linux para separa y controlar los procesos.

kubectl create namespace aemet

#Agregamos al cluster ingress. En resumen es la fucnionalidad que permite un proxy inverso... recordad que lo ejecutamos con apache y nginx

minikube addons enable ingress

# Creamos el pod que es un contenedor de datos de presion y altura en el espacio de nombres del aemet. Se etiqueta y denomna como barom

kubectl -n aemet run barom --port=7000 --image=richifor/barom:v1 -l app=barom

# ver el resultado de creación del pod

kubectl get pods -n aemet

#Creamos el servicio de kubernetes reenviando el puero 80 (típico de http para proxy inverso) al 7000 (dónde escuha la aplicación)

kubectl -n aemet create service clusterip barom --tcp=80:7000

#visualizar apis disponibles

kubectl api-resources


# en el directorio /vagrant (compartido por Virtualbox) existe el fichero barom.yaml que contiene la definición del servicio y que se agrega a kubernetes


kubectl apply -f /vagrant/barom.yml

# Visualizar la ip de minikube

minikube ip

# comprobación 

curl 192.168.49.2/api/pressure_data

# Creamos los pods y el servicio en el mismo yaml. PRIMEO DESTRUIMOS TODO

kubectl delete all -l app=barom --all-namespaces

#usamos el barom-service.yml del directorio vagrant (descargado con git)




######################### EXPLICACIÓN ##################################################
#########################################################################################
#####################################################################################
# Versión de la API de Kubernetes para el deployment
apiVersion: apps/v1
# Tipo de objeto que se crea (deployment)
kind: Deployment
# Metadatos del deployment (nombre, namespace y etiquetas)
metadata:
  name: barom
  namespace: aemet
  # Etiqueta del deployment
  labels:
    app: barom
# Configuración del deployment (número de réplicas y plantilla)
spec:
  replicas: 1
  # Regla para seleccionar los pods que forman parte del deployment
  selector:
    matchLabels:
      app: barom
  # Plantilla para crear los pods
  template:
    metadata:
      labels:
        app: barom
    # Contenedores que estarán en los pods creados
    spec:
      containers:
        - name: barom
          image: richifor/barom:v1
          # Puertos que se exponen en el contenedor
          ports:
            - containerPort: 7000
---
# Versión de la API de Kubernetes para el servicio
apiVersion: v1
# Tipo de objeto que se crea (servicio)
kind: Service
# Metadatos del servicio (nombre, namespace y etiquetas)
metadata:
  name: servicio-barometrico
  namespace: aemet
  # Etiqueta del servicio
  labels:
    app: barom
# Configuración del servicio (puertos, selección y tipo)
spec:
  # Puertos que se exponen en el servicio
  ports:
    - name: http
      port: 80
      protocol: TCP
      targetPort: 7000
  # Regla para seleccionar los pods a los que se dirige el servicio
  selector:
    app: barom
  # Tipo de servicio (ClusterIP)
  type: ClusterIP
---
# Versión de la API de Kubernetes para el ingress
apiVersion: networking.k8s.io/v1
# Tipo de objeto que se crea (ingress)
kind: Ingress
# Metadatos del ingress (nombre, namespace y anotaciones)
metadata:
  name: barom
  namespace: aemet
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
# Configuración del ingress (reglas y backend)
spec:
  # Reglas para enrutar las solicitudes al servicio
  rules:
    - http:
        paths:
          # Ruta del ingreso
          - path: /
            # Tipo de ruta (prefijo)
            pathType: Prefix
            # Backend del ingreso
            backend:
              service:
                name: servicio-barometrico
                port:
                  number: 80
#####################################FIN EXPLICACIÓN#######################
##########################################################################
#######################################################################




Escalado
# ver los servicioss
 kubectl get services -n aemet
 
# ver los despliegues
 kubectl -n aemet get deployment barom
 
# autoesclar por uso de cpu
 
 kubectl -n aemet autoscale deployment barom --cpu-percent=20 --min=4 --max=10
 
#visualizar autoescalados
 
 kubectl -n aemet get hpa
 
# eliminarlos
 
 kubectl -n aemet delete hpa barom
 
 
###############################################################################
############## MICROK8S https://ubuntu.com/tutorials/install-a-local-kubernetes-with-microk8s
 
##################### CRear microbot (pods) 
 microk8s kubectl create deployment microbot --image=dontrebootme/microbot:v1
# 2 réplicas

microk8s kubectl scale deployment microbot --replicas=2


#exponer el puerto 
 microk8s kubectl expose deployment microbot --type=NodePort --port=80 --name=microbot-service
 
#visualizamos el cluster

microk8s kubectl get all --all-namespaces

# ver el puerto de microbot y consultar EJEMPLO!!!!

curl localhost:30760

#comandos Integrados

microk8s status: Provides an overview of the MicroK8s state (running / not running) as well as the set of enabled addons
microk8s enable: Enables an addon
microk8s disable: Disables an addon
microk8s kubectl: Interact with kubernetes
microk8s config: Shows the kubernetes config file
microk8s istioctl: Interact with the istio services; needs the istio addon to be enabled
microk8s inspect: Performs a quick inspection of the MicroK8s intallation
microk8s reset: Resets the infrastructure to a clean state
microk8s stop: Stops all kubernetes services
microk8s start: Starts MicroK8s after it is being stopped

 </pre>
