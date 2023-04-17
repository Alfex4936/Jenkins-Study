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
                    filename 'Dockerfile.linux'
                    dir '.'
                }
            }
            steps {
                sh 'cargo test'
                sh 'cargo fmt --all -- --check'
                sh 'cargo clippy --all-targets --all-features -- -D warnings'
            }
        }
    }

    post {
        failure {
            emailext (
                subject: "Jenkins Rust CI Failed: ${currentBuild.fullDisplayName}",
                body: "The build has failed. Check the build log at ${env.BUILD_URL}",
                to: 'ikr@kakao.com', // replace with your email address
                replyTo: 'ikr@kakao.com' // replace with the desired reply-to email address
            )
        }
    }
}