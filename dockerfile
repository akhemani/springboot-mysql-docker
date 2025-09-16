# ---- Builder ----
FROM eclipse-temurin:17-jdk-jammy AS builder

WORKDIR /workspace

COPY . .

RUN ./mvnw -q -DskipTests package

# ---- Runtime ----
FROM eclipse-temurin:17-jre-jammy

# Non-root user
RUN useradd -u 10001 -r -s /bin/false appuser

WORKDIR /app

# Copy runnable artifact only
COPY --from=builder /workspace/target/*.jar /app/app.jar

# OCI labels (edit values)
LABEL org.opencontainers.image.title="visit-tracker" \
      org.opencontainers.image.description="Spring Boot + MySQL demo (prod-hardened)" \
      org.opencontainers.image.version="1.0.0" \
      org.opencontainers.image.source="https://github.com/akhemani/springboot-mysql-docker/tree/version/v2-production" \
      org.opencontainers.image.licenses="Apache-2.0"

USER appuser

EXPOSE 8081

# Container-aware JVM
ENV JAVA_TOOL_OPTIONS="-XX:MaxRAMPercentage=75.0 -XX:+UseContainerSupport"

ENTRYPOINT ["java","-jar","/app/app.jar"]
