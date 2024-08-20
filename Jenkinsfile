pipeline {
    agent {
        kubernetes {
            label 'minikube'
            defaultContainer 'jnlp'
            yaml """
apiVersion: v1
kind: Pod
metadata:
  labels:
    jenkins/label: minikube
spec:
  containers:
  - name: docker
    image: docker:latest
    command:
    - cat
    tty: true
    volumeMounts:
    - name: docker-socket
      mountPath: /var/run/docker.sock
  volumes:
  - name: docker-socket
    hostPath:
      path: /var/run/docker.sock
            """
        }
    }

    stages {
        stage('Build Docker Image') {
            steps {
                container('docker') {
                    sh 'docker build -t gwm111/groovy-project:latest .'
                }
            }
        }

        stage('Run Hello Script') {
            steps {
                container('docker') {
                    sh 'docker run gwm111/groovy-project:latest'
                }
            }
        }

        stage('Run Tests') {
            steps {
                container('docker') {
                    script {
                        sh 'docker exec $(docker ps -q -f ancestor=gwm111/groovy-project:latest) groovy /app/vars/test_sum.groovy'
                    }
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                container('docker') {
                    script {
                        if (currentBuild.result == 'SUCCESS') {
                            sh 'docker push gwm111/groovy-project:latest'
                        } else {
                            error("Build failed. Not pushing to Docker Hub.")
                        }
                    }
                }
            }
        }
    }

    post {
        always {
            echo 'Cleaning up...'
            cleanWs()
        }
        failure {
            echo 'Pipeline failed.'
        }
    }
}


