# ---- Build Stage ----
# Use Maven base image from the Docker Hub
FROM --platform=linux/amd64 maven:3.8.3-eclipse-temurin-11 AS build

# Set the current working directory inside the image
WORKDIR /app

# Copy the source code to the container
COPY src /app/src
COPY pom.xml /app

# Package the application
RUN mvn clean install -DskipTests

# ---- Deploy Stage ----
FROM --platform=linux/amd64 eclipse-temurin:11-jre

# Copy the built JAR from the build stage
COPY --from=build /app/target/thymeleaf-0.0.1-SNAPSHOT.jar /app.jar

# Expose port 8080
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "/app.jar"]