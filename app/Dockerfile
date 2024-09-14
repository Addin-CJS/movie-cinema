# Use openjdk:17-jdk-slim for base image
FROM openjdk:17-jdk-slim

# Set the working directory to '/app'
WORKDIR /app

# Copy the gradlew, gradle folder, and build file to the docker image
COPY gradlew* ./
COPY gradle ./gradle
COPY build.gradle .

# Grant execute permission for 'gradlew'
RUN chmod +x ./gradlew

# Copy source code
COPY src ./src

# Build the application
RUN ./gradlew build

# Expose the port the app runs on
EXPOSE 9999

# Find the .war file and run the application
CMD ["/bin/sh", "-c", "java -jar $(find ./build/libs/*-SNAPSHOT.war | grep -v plain | head -n 1)"]
