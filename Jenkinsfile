pipeline {
    agent any
    stages {
        stage('checkout') {
            steps{
                 echo "this is checkout"
            }     
        }
        stage('Build') {
            when{
                expression{
                    BRANCH_NAME == "testing"
                }
            }
            steps {
                script{
                    try{
                        sh "shh -o -i tester.key root@123.222.222.23.22"
                        echo "successfully built"
                    }catch(err){
                    if(err){
                        currentBuild.result = ${build_log}
                        throw err
                    }
                    }
                }
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
                subject: "Build ${currentBuild.currentResult}: Job ${env.JOB_NAME}, ${BUILD_NUMBER}  ${JOB_NAME},${env.BUILD_LOG}, ${env.BUILD_URL}",
                body: "Build Status: ${currentBuild.currentResult}\nCheck the console output at ${env.BUILD_URL}",
                to: "shopar200@gmail.com",
                replyTo: "shopar200@gmail.com",
                from: "adewumibode7@gmail.com"
            )
        }
        failure {
                script{
                     //def build_log = currentBuild.rawBuild.getLog(100).join('\n') 
                     def build_log = Manager.build.getLog
                        emailext(
                            subject: "Build ${currentBuild.currentResult}: Job ${env.JOB_NAME}, ${env.BUILD_NUMBER}, ${JOB_NAME},${env.BUILD_LOG}, ${BUILD_URL}", ${build_log},
                            body: "Build Status: ${currentBuild.currentResult}\nCheck the console output at ${env.BUILD_URL}",
                            to: "shopar200@gmail.com",
                            replyTo: "shopar200@gmail.com",
                            from: "adewumibode7@gmail.com"
                        )                    
                }
        }
    }
}