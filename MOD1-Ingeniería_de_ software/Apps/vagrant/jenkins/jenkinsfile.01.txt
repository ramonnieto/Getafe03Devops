pipeline {
    agent any

    stages {
        stage('Clonar repositorio') {
            steps {
                checkout([$class: 'GitSCM', 
                         branches: [[name: '*/main']],
                         userRemoteConfigs: [[url: 'https://github.com/ricardoinstructor/bus_app.git']]
                ])
            }
        }

        stage('Crear entorno virtual') {
            steps {
                dir('bus_app/users-service') {
                    sh 'python3 -m venv venv'
                }
            }
        }

        stage('Instalar dependencias') {
            steps {
                dir('bus_app/users-service') {
                    sh '''
                        . venv/bin/activate
                        pip install -r https://raw.githubusercontent.com/ricardoinstructor/bus_app/refs/heads/main/users-service/requirements.txt
                    '''
                }
            }
        }

        stage('Iniciar aplicación') {
            steps {
                dir('bus_app/users-service') {
                    sh '''
                        . venv/bin/activate
                        python3 ./src/app.py &
                        echo $! > app.pid
                    '''
                }
            }
        }

        stage('Esperar inicio de la aplicación') {
            steps {
                sleep(time: 5, unit: 'SECONDS')
            }
        }

        stage('Ejecutar pruebas') {
            steps {
                dir('bus_app/users-service') {
                    sh '''
                        echo "Ejecutando pruebas de registro"
                        curl -X POST -H "Content-Type: application/json" \
                            -d '{"email": "exampleuser@example.com", "password": "password123"}' \
                            http://192.168.33.10:5000/users/register

                        echo "Ejecutando pruebas de login"
                        curl -X POST -H "Content-Type: application/json" \
                            -d '{"email": "exampleuser@example.com", "password": "password123"}' \
                            http://192.168.33.10:5000/users/login
                    '''
                }
            }
        }

        stage('Detener aplicación') {
            steps {
                dir('bus_app/users-service') {
                    sh '''
                        if [ -f app.pid ]; then
                            kill $(cat app.pid) 2>/dev/null || echo "El proceso ya no estaba en ejecución."
                            rm -f app.pid
                        else
                            echo "No se encontró el archivo app.pid."
                        fi
                    '''
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}

