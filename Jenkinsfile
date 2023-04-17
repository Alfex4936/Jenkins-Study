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
                    myDockerImage = docker.build("my-rust:${env.BUILD_ID}", ".")
                }
            }
        }

        stage('Build and Test') {
            agent {
                docker {
                    image myDockerImage.id
                }
            }
            steps {
                sh 'cargo test --target x86_64-unknown-linux-gnu'
                sh 'cargo build --tests --target x86_64-pc-windows-gnu'
                sh 'wine target/x86_64-pc-windows-gnu/debug/jenkins_test-*.exe'
            }
        }
    }
}
