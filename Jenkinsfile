pipeline {
    agent any

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("gwm111/groovy-project:latest")
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
                            echo "yay"
                        } else {
                            echo "failed"
                        }
                    } catch (Exception e) {
                        echo "failed"
                    } finally {
                        sh "docker stop ${container.id}"
                        sh "docker rm ${container.id}"
                    }
                }
            }
        }
    }
    
    post {
        always {
            // clean up
        }
    }
}
