pipeline {
    agent any
    stages {
        stage('checkout') {
            steps{
                 echo "this is checkout"
            }     
        }
        stage('Build') {
            steps {
                echo "This is building step"
            }
        }
        stage('Test') {
            steps {
                echo "this is testing step"
            }
        }
        stage('Deploy') {
            steps {
                echo "this is building step"
            }
        }
    }
    post {
        always {
            echo "this is just a step"
        }
        success {
            emailext(
                subject: "Build ${currentBuild.currentResult}: Job ${env.JOB_NAME}",
                body: "Build Status: ${currentBuild.currentResult}\nCheck the console output at ${env.BUILD_URL}",
                to: "adewumibode7@gmail.com", "shopar200@gmail.com",
                replyTo: "shopar200@gmail.com",
                from: "adewumibode7@gmail.com"
            )
        }
        failure {
            emailext(
                subject: "Build ${currentBuild.currentResult}: Job ${env.JOB_NAME}",
                body: "Build Status: ${currentBuild.currentResult}\nCheck the console output at ${env.BUILD_URL}",
                to: "adewumibode7@gmail.com", "shopar200@gmail.com",
                replyTo: "shopar200@gmail.com",
                from: "adewumibode7@gmail.com"
            )
        }
    }
}