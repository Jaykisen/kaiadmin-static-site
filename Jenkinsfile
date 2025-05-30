pipeline {
    agent any

    environment {
        DOCKER_HOST = "ec2-user@65.2.69.47"       // Docker EC2 IP
        SSH_KEY_ID = "docker-ssh-key"             // SSH credentials ID in Jenkins
        IMAGE_NAME = "my-static-site-image"
        CONTAINER_NAME = "my-static-site-container"
    }

    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Deploy to Docker Host') {
            steps {
                sshagent(credentials: [SSH_KEY_ID]) {
                    sh """
                        ssh -o StrictHostKeyChecking=no ${DOCKER_HOST} '
                            docker stop ${CONTAINER_NAME} || true &&
                            docker rm ${CONTAINER_NAME} || true &&
                            docker rmi ${IMAGE_NAME} || true
                        '
                        scp -o StrictHostKeyChecking=no -r ./* ${DOCKER_HOST}:~/app/
                        ssh -o StrictHostKeyChecking=no ${DOCKER_HOST} '
                            cd ~/app &&
                            docker build -t ${IMAGE_NAME} . &&
                            docker run -d -p 80:80 --name ${CONTAINER_NAME} ${IMAGE_NAME}
                        '
                    """
                }
            }
        }
    }
}
