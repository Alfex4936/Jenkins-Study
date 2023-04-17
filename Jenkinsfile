pipeline {
    agent any

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

        stage('Build') {
            steps {
                sh 'cargo build'
            }
        }

        stage('Test') {
            steps {
                sh 'cargo test'
            }
        }

        stage('Format') {
            steps {
                sh 'cargo fmt --all -- --check'
            }
        }

        stage('Clippy Lint') {
            steps {
                sh 'cargo clippy --all-targets --all-features -- -D warnings'
            }
        }
    }
}
