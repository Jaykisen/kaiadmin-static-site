pipeline {
    agent any

    environment {
        AWS_DEFAULT_REGION = 'ap-south-1'
        S3_BUCKET = '001002003004005'
    }

    stages {
        stage('Clone Repository') {
            steps {
                git credentialsId: 'github-creds', url: 'https://github.com/<your-username>/<new-repo>.git', branch: 'main'
            }
        }

        stage('Install AWS CLI (if needed)') {
            steps {
                sh '''
                if ! command -v aws &> /dev/null; then
                  echo "Installing AWS CLI"
                  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
                  unzip awscliv2.zip
                  sudo ./aws/install
                fi
                '''
            }
        }

        stage('Deploy to S3') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-creds']]) {
                    sh '''
                    aws s3 sync . s3://$S3_BUCKET/ --delete
                    '''
                }
            }
        }
    }
}

