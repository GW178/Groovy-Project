pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "gw111/groovy-project:latest"
    }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${DOCKER_IMAGE}")
                    echo "Image ${DOCKER_IMAGE} was built"
                }
            }
        }

        stage('Run Tests') {
            steps {
                script {
                    def container = docker.image("${DOCKER_IMAGE}").run('-d')

                    try {
                        def result = docker.image("${DOCKER_IMAGE}").inside {
                            sh 'groovy /app/vars/test_sum.groovy'
                        }
                        
                        if (result.contains("The sum is:")) {
                            echo "Test succeeded: ${result}"
                            currentBuild.result = 'SUCCESS'
                        } else {
                            echo "Test failed: ${result}"
                            currentBuild.result = 'FAILURE'
                        }
                    } catch (Exception e) {
                        echo "Test execution failed"
                        currentBuild.result = 'FAILURE'
                    } finally {
                        sh "docker stop ${container.id}"
                        sh "docker rm ${container.id}"
                    }
                }
            }
        }

        stage('Push Docker Image') {
            when {
                expression { currentBuild.result == 'SUCCESS' }
            }
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub-credentials-id') {
                        docker.image("${DOCKER_IMAGE}").push()
                    }
                    echo "Image ${DOCKER_IMAGE} was pushed to Docker Hub"
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

