FROM gradle:8.6.0-jdk17 AS build

WORKDIR /app

COPY gradlew* .
COPY gradle ./gradle

RUN chmod +x ./gradlew

COPY build.gradle .
COPY src ./src

# Build the application
RUN gradle build

# Use adoptopenjdk for base image
FROM openjdk:17-jdk-slim
EXPOSE 9090

# Copy build application to 'app' folder in image
COPY --from=build /app/build/libs/*.jar /app/app.jar

# Run the application
CMD ["java", "-jar", "/app/app.jar"]
