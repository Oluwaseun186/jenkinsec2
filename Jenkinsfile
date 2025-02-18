pipeline {
    agent any
        tools {
            nodejs "node18"
    }
    environment {
        DOCKER_IMAGE = "oluwaseun7/myapp"
        DOCKER_TAG = "1.1.1"
    }
    stages {
        stage('checkout') {
           // checkout all files
            steps{
                git branch: "origin", url: "https://github.com/Oluwaseun186/jenkinsfile.git"
            }     
        }

        stage('build') {

            // PASSING BRANCH NAME AS A CONDITION
             when{
                 expression{
                    BRANCH_NAME == "testing"
                 }
             }
            steps {

                //sh "npm init -y"   
                echo "this is building step."
                // RUNNING NPM INSTALL AND TESTING WHETHER THE INSTALLTION ACHIEVED
                script{
                    try{
                        //sh "npm install"
                        echo "Installtion successful"
                    }catch(err){
                        echo "Installtion failed."
                    }
                }
                  
            }
        }
        stage("build docker image") {
            steps {
                script {
                    // echo "Building Docker image: ${dapper01/new-test-image}:${1}"
                    
                    // Build Docker image
                    sh "docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} ."

                    // Use Jenkins credentials to log in to DockerHub securely
                    withCredentials([usernamePassword(credentialsId: 'dockerhub_access', usernameVariable: 'Username', passwordVariable: 'Password')]) {
                        sh "echo 'Logging into DockerHub securely...'"
                        sh "docker login -u $username -p $Password"
                    }

                    // Push Docker image
                    sh "docker push ${DOCKER_IMAGE}:${DOCKER_TAG}"
                    sh "docker pull ${DOCKER_IMAGE}:${DOCKER_TAG}"
                    //sh "docker run -d -p 80:80 ${DOCKER_IMAGE}:${DOCKER_TAG}"
                }
            }
    
        }
    }


    // POST BUILD FOR FAILURE AND SUCCESS OF RUN JOBS
    post {
        always {
            echo "this is just a step.."
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
                     //def build_log = Manager.build.log
                     def build_log = readFile("build.log")
                        emailext(
                            subject: "Build ${currentBuild.currentResult}: Job ${env.JOB_NAME}, ${env.BUILD_NUMBER}, ${JOB_NAME}, ${build_log},  ${BUILD_URL}",
                            body: "Build Status: ${currentBuild.currentResult}\nCheck the console output at ${env.BUILD_URL}, ${build_log}, ${env.BUILD_NUMBER}",
                            to: "shopar200@gmail.com",
                            replyTo: "shopar200@gmail.com",
                            from: "adewumibode7@gmail.com"
                        )                    
                }
        }
    }
}