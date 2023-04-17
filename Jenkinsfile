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

        stage('Build Docker Image') {
            agent any
            steps {
                script {
                    myDockerImage = docker.build("my-image:${env.BUILD_ID}", ".")
                }
            }
        }

        stage('Build and Test') {
            agent {
                docker {
                    image myDockerImage.id
                    args '-v /var/run/docker.sock:/var/run/docker.sock'
                }
            }
            steps {
                sh 'cross test --target x86_64-unknown-linux-gnu'
                sh 'cross test --target x86_64-pc-windows-gnu'
            }
        }
    }
}
