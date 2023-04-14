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
