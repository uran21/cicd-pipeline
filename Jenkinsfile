uran@test:~/jenkinscicd/cicd-pipeline$ cat Jenkinsfile
pipeline {
    agent any

    environment {
        IMAGE_TAG = "v1.0"
        IMAGE_NAME = "uran21/"
        PORT = ""
        LOGO_PATH = "logo.svg"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: "${BRANCH_NAME}", url: 'https://github.com/uran21/cicd-pipeline'
            }
        }

        stage('Build') {
            steps {
                script {
                    echo "Building the application..."
                    // Добавьте команды для сборки вашего приложения, например, npm build или другие
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    echo "Running tests..."
                    // Ваши команды для тестирования приложения
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    echo "Building Docker image for ${BRANCH_NAME}..."
                    if (BRANCH_NAME == "main") {
                        PORT = "3000"
                        LOGO_PATH = "main.svg"
                    } else if (BRANCH_NAME == "dev") {
                        PORT = "3001"
                        LOGO_PATH = "dev.svg"
                    }
                    sh """
                    docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .
                    """
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    echo "Deploying application to port ${PORT} with logo: ${LOGO_PATH}..."
                    sh """
                    docker run -d -p ${PORT}:${PORT} ${IMAGE_NAME}:${IMAGE_TAG}
                    """
                    sh """
                    cp ${LOGO_PATH} path/to/application/logo.svg
                    """
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
