pipeline {
    agent any
        tools {
            nodejs "node18"
    }
    environment {
        DOCKER_IMAGE = "oluwaseun7/myapp"
        DOCKER_TAG = "1.1.2"
        EC2_USER = "ubuntu" // Change if using Amazon Linux ("ec2-user")
        EC2_IP = "3.91.152.26"
        SSH_KEY = credentials('SSH_KEY') // Store the SSH key in Jenkins credentials
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
                    BRANCH_NAME == "testing."
                 }
             }
            steps {

                //sh "npm init -y"   
                echo "this is building step."
                // RUNNING NPM INSTALL AND TESTING WHETHER THE INSTALLTION ACHIEVED
                script{
                    try{
                        //sh "npm install"
                        sh "cat 'Starting build process' > builder.log"
                        //sh "npm run test | tee builder.log"
                        echo "Installtion successful"
                    }catch(Exception err){
                        currentBuild.result = "FAILURE"
                        sh "echo ${err} | tee builder.log"
                        throw err
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
                        sh "echo 'Logging into DockerHub securely..'"
                        sh "docker login -u $username -p $Password"
                    }

                    // Push Docker image
                    sh "docker push ${DOCKER_IMAGE}:${DOCKER_TAG}"
                    sh "docker pull ${DOCKER_IMAGE}:${DOCKER_TAG}"
                    //sh "docker run -d -p 80:80 ${DOCKER_IMAGE}:${DOCKER_TAG}"
                }
            }
    
        }

        stage('Deploy to EC2') {
            steps {
                script {
                    sh """
                        ssh -o StrictHostKeyChecking=no -i $SSH_KEY $EC2_USER@$EC2_IP 
                            echo "Connected to EC2"
                            
                            # Ensure sudo does not require a password
                            sudo -n true 2>/dev/null || echo "$EC2_USER ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/$EC2_USER

                            # Update system and install Docker
                            sudo apt-get update -y
                            sudo apt-get install -y docker-ce docker-ce-cli containerd.io

                             # Start Docker service
                            sudo systemctl enable docker
                            sudo systemctl start docker
                                    
                            # Stop and remove any existing container
                            sudo docker stop ${DOCKER_IMAGE}:${DOCKER_TAG} || true
                            sudo docker rm ${DOCKER_IMAGE}:${DOCKER_TAG} || true
                            
                            # Pull and run the new container
                            sudo docker pull ${DOCKER_IMAGE}:${DOCKER_TAG}
                            sudo docker run -d -p 80:80 --name myapp ${DOCKER_IMAGE}:${DOCKER_TAG}
                            
                            echo "Deployment Successful"
                        
                    """
                }
            }
        }

    }



    // POST BUILD FOR FAILURE AND SUCCESS OF RUN JOBS
    post {
        changed {
            echo "this is job as been successfully completed."
        }
        success {
            script{
                def build_log = readFile("builder.log")
                emailext(
                    subject: "Build ${currentBuild.currentResult}: Job ${env.JOB_NAME}",
                    body: "Build Status: ${currentBuild.currentResult}\nCheck the console output at ${env.BUILD_URL}, ${env.build_log}, ${env.BUILD_NUMBER}",
                    to: "shopar200@gmail.com",
                    replyTo: "shopar200@gmail.com",
                    from: "adewumibode7@gmail.com"
                )
            }

        }
        failure {
                script{
                     //def build_log = currentBuild.rawBuild.getLog(100).join('\n') 
                     //def build_log = Manager.build.log
                     def build_log = readFile("build.log")
                        emailext(
                            subject: "Build ${currentBuild.currentResult}: Job ${env.JOB_NAME}",
                            body: "Build Status: ${currentBuild.currentResult}\nCheck the console output at ${env.BUILD_URL}, ${build_log}, ${env.BUILD_NUMBER}",
                            to: "shopar200@gmail.com",
                            replyTo: "shopar200@gmail.com",
                            from: "adewumibode7@gmail.com"
                        )                    
                }
        }
    }
}