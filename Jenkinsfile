pipeline {
  agent any

  environment {
    DOCKER_IMAGE = "oumayma15/student-management"
    DOCKER_CREDENTIALS_ID = "123"
  }

  stages {

    stage('Checkout') {
      steps { checkout scm }
    }

    stage('Build Maven') {
      steps { sh 'mvn clean package -DskipTests' }
    }

    stage('Debug Workspace') {
      steps {
        sh '''
          echo "=== PWD ==="
          pwd
          echo "=== LS ROOT ==="
          ls -la
          echo "=== DOCKERFILE ==="
          ls -la Dockerfile || true
          echo "=== TARGET ==="
          ls -la target || true
          echo "=== JAR FOUND ==="
          ls -la target/*.jar || true
        '''
      }
    }

    stage('Build Docker Image') {
      steps {
        sh '''
          set -euxo pipefail
          docker version
          docker info | head -n 30
          echo "=== BUILD DOCKER ==="
          docker build --no-cache --progress=plain -t "$DOCKER_IMAGE:latest" .
        '''
      }
    }

    stage('Login to DockerHub') {
      steps {
        withCredentials([usernamePassword(
          credentialsId: "${DOCKER_CREDENTIALS_ID}",
          usernameVariable: 'DOCKER_USER',
          passwordVariable: 'DOCKER_PASS'
        )]) {
          sh '''
            set -euxo pipefail
            echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
          '''
        }
      }
    }

    stage('Push Docker Image') {
      steps { sh 'docker push $DOCKER_IMAGE:latest' }
    }
  }
}
