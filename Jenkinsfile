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
        CARGO_TERM_COLOR = 'never'
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

        stage('Build and Test') {
            agent {
                docker {
                    image myLinux.id
                }
            }
            steps {
                sh 'cross test --target x86_64-unknown-linux-gnu'
                sh 'cross test --target x86_64-pc-windows-gnu'
            }
        }
    }
}
