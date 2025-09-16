# Fast & loose: single-stage, runs as root, JDK base
FROM eclipse-temurin:17-jdk-jammy
WORKDIR /app
COPY target/app.jar app.jar
EXPOSE 8081
CMD ["java", "-jar", "/app/app.jar"]
