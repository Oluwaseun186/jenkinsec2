pipeline {
    agent any

    tools {
        nodejs "node18"
    }

    environment {
        DOCKER_IMAGE = "oluwaseun7/myapp"
        DOCKER_TAG = "1.0.1"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: "main", url: "https://github.com/Oluwaseun186/jenkinsfile.git"
            }     
        }

        stage('Build') {
            when {
                expression {
                    return env.BRANCH_NAME == "testing"
                }
            }
            steps {
                sh "npm init -y"   
                echo "This is the build step."

                script {
                    try {
                        sh "npm install"
                        echo "Installation successful"
                    } catch (err) {
                        echo "Installation failed"
                    }
                }
            }
        }

        stage('Docker Build & Push') {
            steps {
                script {
                    def imageName = "oluwaseun7/new-test-image:1"

                    echo "Building Docker image: ${imageName}"
                    sh "docker build -t ${imageName} ."

                    withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'Username', passwordVariable: 'Password')]) {
                        echo "Logging into DockerHub securely..."
                        sh "docker login -u $Username -p $Password"
                    }

                    echo "Pushing Docker image..."
                    sh "docker push ${imageName}"
                }
            }
        }
    }

    post {
        always {
            echo "Pipeline execution completed."
        }

        success {
            script {
                emailext(
                    subject: "Build SUCCESS: Job ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                    body: "Build Status: ${currentBuild.currentResult}\nCheck the console output at ${env.BUILD_URL}",
                    to: "shopar200@gmail.com",
                    replyTo: "shopar200@gmail.com",
                    from: "adewumibode7@gmail.com"
                )
            }
        }

        failure {
            script {
                def build_log = currentBuild.rawBuild.getLog(50).join('\n') // Get last 50 lines of the log
                
                emailext(
                    subject: "Build FAILURE: Job ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                    body: "Build Status: ${currentBuild.currentResult}\nCheck the console output at ${env.BUILD_URL}\n\nLog:\n${build_log}",
                    to: "shopar200@gmail.com",
                    replyTo: "shopar200@gmail.com",
                    from: "adewumibode7@gmail.com"
                )                    
            }
        }
    }
}
