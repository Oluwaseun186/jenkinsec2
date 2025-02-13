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
            echo "this is success step"
        }
        failure {
            echo "this is failure step"
        }
    }
}