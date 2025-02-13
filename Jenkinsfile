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
            emailext subject: "Build Success: ${env.JOB_NAME}",
                     body: "Good news! The build succeeded.\nCheck details: ${env.BUILD_URL}",
                     to: 'adewumibode7@gmail.com'
        }
        failure {
            emailext subject: "Build Failed: ${env.JOB_NAME}",
                     body: "Oops! The build failed.\nCheck details: ${env.BUILD_URL}",
                     to: 'shopar200@gmail.com'
        }
    }
}