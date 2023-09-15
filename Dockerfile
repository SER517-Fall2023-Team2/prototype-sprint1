# Docker maven image.
FROM maven:3.8.4-openjdk-17-slim AS build

# Copy the project source code and required files to the Docker container.
COPY pom.xml .
COPY src ./src

# Build the Maven project.
RUN mvn clean install

# Specify JDK to run JAR file.
FROM openjdk:17

# Set the working directory in the container
WORKDIR /app

# Copy the JAR file from the build stage to the final image
COPY --from=build /target/ser517-fall2023-team2-0.0.1-SNAPSHOT.jar .

# Expose port to run. (Ensure this port is mapped in your IDE's settings if you are using one).
EXPOSE 8080

# Run JAR file.
CMD ["java", "-jar", "ser517-fall2023-team2-0.0.1-SNAPSHOT.jar"]
