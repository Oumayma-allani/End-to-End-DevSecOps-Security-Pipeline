# Étape 1 : Build avec Maven
FROM maven:3.9.6-eclipse-temurin-17 AS build

WORKDIR /app

# Copier tout le projet
COPY . .

# Afficher les fichiers
RUN ls -la

# Compiler le projet (skip tests)
RUN mvn clean package -DskipTests

# Étape 2 : Image légère pour exécuter le JAR
FROM eclipse-temurin:17-jdk

WORKDIR /app

# Copier le JAR généré depuis l'étape build
COPY --from=build /app/target/*.jar app.jar

# Afficher le contenu
RUN ls -la

# Lancer l'application
CMD ["java", "-jar", "app.jar"]
