```markdown
# Visit Tracker App (Spring Boot + MySQL) — Production Ready Setup

This project is a simple **Spring Boot + MySQL REST service** that demonstrates production-ready Docker practices.  
The application exposes a root endpoint returning a hello message and stores/retrieves "visits" from a MySQL database.  

---

## ✨ Features
- Java 17 (Spring Boot)
- REST endpoints:  
  - `/` → hello message, container id, and visit count  
  - `/visits` → create/list visits  
  - `/actuator/health`, `/actuator/health/liveness`, `/actuator/health/readiness`  
- MySQL 8 as database  
- Dockerized with **multi-stage build**, **non-root user**, **read-only filesystem**  
- Config via environment variables (`.env` file for local dev)  
- **OCI labels** in Docker image for metadata  
- **Health checks** for app and DB  
- MySQL persistence with a **named volume**  
- Database not exposed to host (only accessible to app)  

---

## 📂 Project Structure
```

visittracker/

├─ src/main/java/com/visittracker/

│  ├─ VisitTrackerApplication.java

│  ├─ Visit.java

│  ├─ VisitRepository.java

│  └─ VisitController.java

├─ src/main/resources/

│  ├─ application.properties

│  └─ db/

│     └─ migration/

│        └─ V1__init.sql

├─ pom.xml

├─ Dockerfile

├─ docker-compose.yml

└─ .env


````

---

## ⚙️ Setup Instructions

### 1. Prerequisites
- Docker & Docker Compose
- Java 17 + Maven (for building the JAR locally)

---

### 2. Build Application
```bash
# Compile and package jar (skip tests for speed)
./mvnw -DskipTests package
````
Or if you don't have maven installed in local

```bash
docker run --rm -v "$PWD":/app -w /app maven:3.9-eclipse-temurin-17 \
  mvn -DskipTests package
```

---

### 3. Build Docker Image

```bash
docker build -t visit-tracker:2.0.0 .
```

---

### 4. Configure Environment

Create a `.env` file in project root:

```env
DB_HOST=
DB_PORT=
DB_NAME=
DB_USER=
DB_PASS=
DB_ROOT_PASS=
DB_USE_SSL=

APP_PORT=
```

---

### 5. Run with Docker Compose

```bash
docker compose up -d
```

Check status:

```bash
docker compose ps
```

Expected: both `db` and `app` containers show `(healthy)`.

---

## 🚀 Usage

### 1. Health Endpoints

```bash
curl http://localhost:8081/actuator/health
curl http://localhost:8081/actuator/health/liveness
curl http://localhost:8081/actuator/health/readiness
```

### 2. App Endpoints

```bash
# Create a visit
curl -X POST "http://localhost:8081/visits?message=hello"

# List visits
curl http://localhost:8081/visits

# Root endpoint
curl http://localhost:8081/
```

---

## 🐳 Docker Tips

### Inspect image size

```bash
docker images | grep visit-tracker
```

Compare this (smaller) multi-stage image to Version 1 (single-stage).

### Check OCI Labels

```bash
docker inspect visit-tracker:2.0.0 | grep -A5 org.opencontainers
```

### View logs

```bash
docker logs java-app --tail=100
```

### Resource usage

```bash
docker stats --no-stream
```

---

## 📦 Production-Ready Practices Implemented

* **Multi-stage build** → slim runtime image
* **Non-root user** + **read-only filesystem** → safer containers
* **OCI labels** → image metadata & provenance
* **Environment variables** for config → 12-factor style
* **Named volume** for DB → persistence and durability
* **Custom network** → DB not exposed to host
* **Health checks** → app & DB only marked ready when actually available
* **Graceful shutdown** → handles `SIGTERM` cleanly

---

---

## 📝 Notes

* This is **Version 2 (Production Ready)** of the Visit Tracker app.
* **Version 1** was a quick-and-dirty setup (single-stage, root user, exposed DB).
* In Version 2, we hardened the app to follow best practices, but kept it simple enough for local Docker use.

```
