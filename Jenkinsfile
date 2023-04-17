pipeline {
    agent none

    environment {
        RUST_BACKTRACE = 1
        CARGO_TERM_COLOR = 'never'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Build and Test') {
            agent {
                dockerfile {
                    filename 'Dockerfile.linux'
                    dir '.'
                }
            }
            steps {
                sh 'cargo test'
            }
        }
    }
}