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
                echo "this is building step.."
            }
        }
    }
    post {
        always {
            echo "this is just a step"
        }
        success {
            emailext(
                subject: "Build ${currentBuild.currentResult}: Job ${env.JOB_NAME}", ${BUILD_NUMBER} - ${BUILD_STATUS}, Job: ${JOB_NAME},${env.BUILD_LOG} Build URL: <a href="${BUILD_URL}">${BUILD_URL}</a>
                body: "Build Status: ${currentBuild.currentResult}\nCheck the console output at ${env.BUILD_URL}",
                to: "shopar200@gmail.com",
                replyTo: "shopar200@gmail.com",
                from: "adewumibode7@gmail.com"
            )
        }
        failure {
            emailext(
                subject: "Build ${currentBuild.currentResult}: Job ${env.JOB_NAME}", ${env.BUILD_NUMBER} - ${BUILD_STATUS}, Job: ${JOB_NAME},${env.BUILD_LOG} Build URL: <a href="${BUILD_URL}">${BUILD_URL}</a>
                body: "Build Status: ${currentBuild.currentResult}\nCheck the console output at ${env.BUILD_URL}",
                to: "shopar200@gmail.com",
                replyTo: "shopar200@gmail.com",
                from: "adewumibode7@gmail.com"
            )
        }
    }
}