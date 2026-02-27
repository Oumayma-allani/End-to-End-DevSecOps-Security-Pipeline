# Image runtime (plus légère que jdk)
FROM eclipse-temurin:17-jre

WORKDIR /app

# Copier le JAR généré par Jenkins (après mvn clean package)
COPY target/*.jar app.jar

# (optionnel mais recommandé) port Spring Boot par défaut
EXPOSE 8080

# Lancer l'application
CMD ["java", "-jar", "app.jar"]
