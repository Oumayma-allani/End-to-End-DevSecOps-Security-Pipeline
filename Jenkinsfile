pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                echo "Checkout du repo..."
                checkout scm
            }
        }

        stage('Info') {
            steps {
                sh '''
                    echo "Bonjour Jenkins"
                    echo "Date système :"
                    date
                    echo "Java :"
                    java -version || true
                '''
            }
        }

        stage('Check Maven') {
            steps {
                sh '''
                    echo "Vérification Maven :"
                    mvn -version || echo "Maven n'est pas installé"
                '''
            }
        }

        stage('Build (si projet Maven)') {
            steps {
                sh '''
                    if [ -f "pom.xml" ]; then
                      echo "pom.xml trouvé -> build Maven"
                      mvn -B clean package
                    else
                      echo "Pas de pom.xml -> je skip le build"
                    fi
                '''
            }
        }
    }
}
