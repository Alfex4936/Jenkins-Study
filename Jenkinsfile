def getUnixStylePath(path) {
    if (isUnix()) {
        return path
    } else {
        return sh(script: "wslpath -a -u '${path}'", returnStdout: true).trim()
    }
}

pipeline {
    agent none

    environment {
        RUST_BACKTRACE = 1
        // CARGO_TERM_COLOR = 'always'
    }

    stages {
        stage('Checkout') {
            agent any
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image for linux') {
            agent any
            steps {
                script {
                    def dockerfile = 'Dockerfile.linux'
                    myLinux = docker.build("my-linux:${env.BUILD_ID}", "-f ${dockerfile} .")
                }
            }
        }

        stage('Build Docker Image for windows') {
            agent any
            steps {
                script {
                    def dockerfile = 'Dockerfile.windows'
                    myWindows = docker.build("my-window:${env.BUILD_ID}", "-f ${dockerfile} .")
                }
            }
        }

        stage('Build and Test on linux') {
            agent {
                docker {
                    image myLinux.id
                }
            }
            steps {
                sh 'cargo test'
            }
        }

        stage('Build and Test on windows') {
            agent {
                docker {
                    image myWindowws.id
                }
            }
            steps {
                sh 'cargo test'
            }
        }
    }
}
