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

        stage('Build and Test') {
            agent { 
                dockerfile {
                    filename 'Dockerfile'
                    dir .
                }
            }
            steps {
                sh 'cross test --target x86_64-unknown-linux-gnu'
                sh 'cross test --target x86_64-pc-windows-gnu'
            }
        }
    }
}
