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
        CARGO_TERM_COLOR = 'always'
    }

    stages {
        stage('Checkout') {
            agent any
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            agent any
            steps {
                script {
                    def dockerfile = 'Dockerfile.linux'
                    myLinux = docker.build("my-linux:${env.BUILD_ID}", "-f ${dockerfile} .")
                }
            }
        }

        stage('Build and Test') {
            agent {
                docker {
                    image myLinux.id
                }
            }
            steps {
                sh 'cargo test'
            }
        }
    }
}
