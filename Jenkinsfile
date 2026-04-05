pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "oumayma15/student-management"
        DOCKER_CREDENTIALS_ID = "123"
        NAMESPACE = "devops"
        KUBECONFIG = "/var/lib/jenkins/.kube/config"
        K8S_DIR = "/home/vagrant/student-management/k8s"
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Maven') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE:latest .'
            }
        }

        stage('Login to DockerHub') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: "${DOCKER_CREDENTIALS_ID}",
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh 'echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin'
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                sh 'docker push $DOCKER_IMAGE:latest'
            }
        }

        stage('Kubernetes Deploy') {
            steps {
                sh 'kubectl get nodes'
                sh 'kubectl get pods -n $NAMESPACE || true'
            }
        }

        stage('Deploy MySQL & Spring Boot on K8s') {
            steps {
                sh 'kubectl apply -f $K8S_DIR/pv-sql.yaml'
                sh 'kubectl apply -f $K8S_DIR/pvc-sql.yaml'
                sh 'kubectl apply -f $K8S_DIR/deploy-sql.yaml'
                sh 'kubectl apply -f $K8S_DIR/service-sql.yaml'

                sh 'kubectl apply -f $K8S_DIR/configmap-spring.yaml'
                sh 'kubectl apply -f $K8S_DIR/secret-spring.yaml'
                sh 'kubectl apply -f $K8S_DIR/deploy-spring.yaml'
                sh 'kubectl apply -f $K8S_DIR/service-spring.yaml'

                sh 'kubectl rollout restart deployment spring-app-deployment -n $NAMESPACE'
            }
        }

        stage('Verify Deployment') {
            steps {
                sh 'kubectl get pods -n $NAMESPACE'
                sh 'kubectl get svc -n $NAMESPACE'
            }
        }
    }

    post {
        success {
            echo 'Pipeline exécutée avec succès.'
        }
        failure {
            echo 'La pipeline a échoué.'
        }
    }
}
