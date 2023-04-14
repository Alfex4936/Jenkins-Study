pipeline {
    agent none

    environment {
        RUST_BACKTRACE = 1
        CARGO_TERM_COLOR = 'always'
    }

    stages {
        stage('Build and Test') {
            agent {
                dockerfile {
                    filename 'Dockerfile.linux'
                    dir '.'
                    label 'linux'
                }
            }
            steps {
                sh 'cargo test'
            }
        }
    }
}
