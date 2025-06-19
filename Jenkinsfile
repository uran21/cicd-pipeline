pipeline {
    agent any

    environment {
        IMAGE_TAG = "v1.0"
        IMAGE_NAME = "uran21/cicd-pipeline"
        PORT = ""
        LOGO_PATH = "src/logo.svg"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: "${BRANCH_NAME}", url: 'https://github.com/uran21/cicd-pipeline'
            }
        }

        stage('Install Node.js') {
            steps {
                script {
                    echo "Installing Node.js and npm..."
                    sh """
                    curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -
                    sudo apt-get install -y nodejs
                    """
                }
            }
        }

        stage('Build') {
            steps {
                script {
                    echo "Building the application..."
                    sh 'npm install' // Установка зависимостей
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    echo "Running tests..."
                    sh 'npm test' // Запуск тестов
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    echo "Building Docker image for ${BRANCH_NAME}..."
                    if (BRANCH_NAME == "main") {
                        PORT = "3000"
                        LOGO_PATH = "src/main.svg"  // Логотип для main ветки
                    } else if (BRANCH_NAME == "dev") {
                        PORT = "3001"
                        LOGO_PATH = "src/dev.svg"  // Логотип для dev ветки
                    }

                    // Сборка Docker-образа
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

                    // Запуск Docker-контейнера
                    sh """
                    docker run -d -p ${PORT}:${PORT} ${IMAGE_NAME}:${IMAGE_TAG}
                    """

                    // Копирование логотипа в приложение
                    sh """
                    cp ${LOGO_PATH} ${WORKSPACE}/public/logo.svg
                    """
                }
            }
        }
    }

    post {
        always {
            cleanWs() // Очистка рабочего пространства после выполнения
        }
    }
}
