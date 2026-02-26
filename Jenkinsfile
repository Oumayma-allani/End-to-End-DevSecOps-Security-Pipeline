pipeline {
    agent any

    stages {

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

        stage('Build Maven') {
            steps {
                sh '''
                    if [ -f "pom.xml" ]; then
                      echo "pom.xml trouvé -> build Maven (skip tests)"
                      mvn -B clean package -DskipTests
                    else
                      echo "Pas de pom.xml -> je skip le build"
                    fi
                '''
            }
        }
    }

    post {
        success {
            echo "Build terminé avec SUCCESS"
        }
        failure {
            echo "Build terminé avec FAILURE"
        }
    }
}
