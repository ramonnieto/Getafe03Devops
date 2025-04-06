## Actualiizamos la versión de software (comprobadlo previamente atacando a http://192.168.57.20) 
# La versión v1 se actualiza a la v2 en las réplicas que están ejecutándose. La versión v1 ha sido aprovisionada mediante vagrant.
# Revisad Vagrantfile y pprovision path: <nombrefichero> 

docker service update --image gilbertfongan/demo:v2 --update-parallelism 2 --update-delay 20s test-devops

#consultamos la pila

docker stack ls

#consultamos el serviico

docker stack services webapp

#consultamos los procesos

docker stack ps webapp


# los eliminamos

docker stack rm webapp

# eliminamos los servicios ... podemos consultarlo mediante # docker service ls

docker service rm test-devops





