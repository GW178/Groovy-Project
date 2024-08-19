pipeline {
    agent any

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    def app = docker.build("gwm111/groovy-project:latest")
                    echo "Image ${app.imageName()} was built."
                }
            }
        }

        stage('Run Tests') {
            steps {
                script {
                    def container = docker.image("gwm111/groovy-project:latest").run('-d')

                    try {
                        def result = docker.image("gwm111/groovy-project:latest").inside {
                            sh 'groovy /app/vars/test_sum.groovy'
                        }

                        if (result.contains("The sum is:")) {
                            echo "Test succeeded."
                        } else {
                            error "Test failed."
                        }
                    } catch (Exception e) {
                        error "Test execution failed: ${e.message}"
                    } finally {
                        sh "docker stop ${container.id}"
                        sh "docker rm ${container.id}"
                    }
                }
            }
        }

        stage('Push Docker Image') {
            when {
                expression { currentBuild.result == null || currentBuild.result == 'SUCCESS' }
            }
            steps {
                script {
                    docker.image("gwm111/groovy-project:latest").push('latest')
                    echo "Image pushed to Docker Hub."
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
            echo "Pipeline failed."
        }
    }
}

