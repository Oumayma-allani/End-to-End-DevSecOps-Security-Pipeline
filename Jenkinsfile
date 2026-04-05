pipeline {
    agent any

    environment {
        IMAGE_NAME = "student-management:latest"
        NAMESPACE = "devops"
        KUBECONFIG = "/var/lib/jenkins/.kube/config"
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
                sh 'docker build -t $IMAGE_NAME .'
            }
        }

        stage('Load Image into Minikube') {
            steps {
                sh 'minikube image load $IMAGE_NAME'
            }
        }

        stage('Deploy MySQL') {
            steps {
                sh 'kubectl apply -f k8s/pv-sql.yaml'
                sh 'kubectl apply -f k8s/pvc-sql.yaml'
                sh 'kubectl apply -f k8s/deploy-sql.yaml'
                sh 'kubectl apply -f k8s/service-sql.yaml'
            }
        }

        stage('Deploy Spring Boot') {
            steps {
                sh 'kubectl apply -f k8s/configmap-spring.yaml'
                sh 'kubectl apply -f k8s/secret-spring.yaml'
                sh 'kubectl apply -f k8s/deploy-spring.yaml'
                sh 'kubectl apply -f k8s/service-spring.yaml'
            }
        }

        stage('Restart Spring Deployment') {
            steps {
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
