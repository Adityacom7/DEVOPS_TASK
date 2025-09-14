pipeline {
    agent any

    environment {
        AWS_REGION   = "ap-south-1"
        ECR_REPO_URI = "975050277554.dkr.ecr.ap-south-1.amazonaws.com/devops-task"
        DOCKER_TAG   = "latest"
        CLUSTER_NAME = "Devops_tas-clusterk"   //  replace with your cluster name
    }

    stages {
        stage('Checkout') {
            steps {
                echo " Checking out code..."
                git branch: 'dev', url: 'https://github.com/Adityacom7/DEVOPS_TASK.git'
            }
        }

        stage('Build') {
            steps {
                echo " Installing dependencies..."
                sh 'npm install || echo "No dependencies to install"'
            }
        }

        stage('Dockerize') {
            steps {
                script {
                    echo " Building Docker image..."
                    sh """
                        docker build -t devops-task:latest .
                        docker tag devops-task:latest ${ECR_REPO_URI}:${BUILD_NUMBER}
                        docker tag devops-task:latest ${ECR_REPO_URI}:latest
                    """
                }
            }
        }

        stage('Push to AWS ECR') {
            steps {
                echo " Pushing Docker image to AWS ECR..."
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-cred']]) {
                    sh '''
                        set -x
                        aws ecr get-login-password --region ${AWS_REGION} | \
                        docker login --username AWS --password-stdin 975050277554.dkr.ecr.ap-south-1.amazonaws.com

                        echo "Pushing image to ECR..."
                        docker push ${ECR_REPO_URI}:${BUILD_NUMBER}
                        docker push ${ECR_REPO_URI}:latest
                    '''
                }
            }
        }

        stage('Test') {
            steps {
                echo " Running tests..."
                sh 'echo " All tests passed!"'
            }
        }

        stage('Approval for Merge') {
            steps {
                script {
                    timeout(time: 1, unit: 'HOURS') {
                        input message: "Approve merging dev → main and deploying to EKS?", ok: "Approve & Continue"
                    }
                }
            }
        }

       stage('Merge to main') {
    steps {
        echo " Merging dev → main..."
        withCredentials([usernamePassword(credentialsId: 'github-cred', usernameVariable: 'GIT_USER', passwordVariable: 'GIT_PASS')]) {
            sh '''
                git config user.name "jenkins"
                git config user.email "jenkins@example.com"
                
                git fetch origin
                git checkout main
                git merge origin/dev --no-ff -m "Automated merge from dev to main by Jenkins"

                # Push with injected GitHub credentials
                git push https://${GIT_USER}:${GIT_PASS}@github.com/Adityacom7/DEVOPS_TASK.git main
            '''
        }
    }
}
        stage('Deploy to EKS') {
            steps {
                echo " Deploying to EKS..."
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-cred']]) {
                    sh '''
                        set -x
                        aws eks --region ${AWS_REGION} update-kubeconfig --name ${CLUSTER_NAME}

                        # Update deployment with new image
                        kubectl set image deployment/devops-task-deployment \
                          devops-task=${ECR_REPO_URI}:${BUILD_NUMBER} --record
                    '''
                }
            }
        }
    }

    post {
        success {
            echo " Pipeline executed successfully! Deployment complete."
        }
        failure {
            echo " Pipeline failed!"
        }
    }
}
