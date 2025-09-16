```markdown
# Spring Boot + MySQL with Docker (Fast & Loose Version)

## 📌 Why this project?
This project demonstrates how to quickly containerize a **Java Spring Boot application** with a **MySQL database** using Docker.  
The focus here is on **getting things running fast**, not on production best practices.  

We will later improve this in a **Production-Ready Version** (with security, health checks, non-root users, etc.), and add **Bonus Challenges**.

## 🚀 What we built
- A **Spring Boot REST API** that:
  - Returns a hello message with container ID (`GET /`)
  - Tracks visits in a MySQL database (`POST /visits` and `GET /visits`)
  - Exposes a simple health endpoint (`GET /health`)
- A **MySQL database container** for persistence
- Both containers run together using **Docker Compose**

## 🗂️ Project Structure
```

├─ src/main/java/com/visittracker/   # Spring Boot application code

├─ src/main/resources/application.properties

├─ pom.xml                           # Maven config

├─ Dockerfile                        # Builds the Java app image

├─ docker-compose.yml                # Runs app + MySQL together

└─ README.md                         # This file

````

## 🐳 Docker Setup

**1. Build the JAR**  
If you have Java/Maven locally:
```bash
./mvnw -DskipTests package
cp target/demo-0.0.1-SNAPSHOT.jar target/app.jar
````

If you don’t have Java/Maven installed (like me right now), build inside a Maven container:

```bash
docker run --rm -v "$PWD":/app -w /app maven:3.9-eclipse-temurin-17 \
  mvn -DskipTests package
cp target/*SNAPSHOT.jar target/app.jar
```

**2. Build the Docker image**

```bash
docker build -t my-java-app:v1 .
```

**3. Start the stack (App + MySQL)**

```bash
docker compose up -d
```

**4. Verify containers**

```bash
docker compose ps
```

**5. Test endpoints**

```bash
curl http://localhost:8081/
curl -X POST "http://localhost:8081/visits?message=first+visit"
curl http://localhost:8081/visits
curl http://localhost:8081/health
```

**6. Peek into the MySQL database (optional)**

```bash
docker exec -it mysql-db mysql -uroot -ppassword \
  -e "SHOW DATABASES; USE appdb; SHOW TABLES; SELECT * FROM visit;"
```

## ⚡ What we observed

* Both containers come up quickly with a single `docker compose up`.
* The app can connect to MySQL by **service name (`db`)** inside the network.
* We can interact with the REST endpoints and verify persistence in the DB.
* The Docker image size is **large** (single-stage, JDK base) and runs as **root**.
  👉 This is intentional in the **Fast & Loose** version.

## ❌ Limitations in this version

* Runs as **root** inside the container
* **Single-stage build** → large image size
* MySQL **port is exposed** to the host (not needed in production)
* Credentials are **hardcoded** in env vars
* No **health checks**, **monitoring**, or **backups**

## ✅ Next steps

* Create a **Production-Ready Version**:

  * Multi-stage builds
  * Non-root user
  * Health checks & observability
  * Secrets and environment best practices
* Add **Bonus Challenges**:

  * Multi-stage builds
  * Health checks
  * Monitoring with `docker stats`
  * Environment variables injection

```

---

👉 This way, **everything flows naturally** under the same style (no heavy separators), and you can paste it directly into your branch’s README.  

Do you want me to make the **same streamlined format** for **Version 2 (Production-Ready)** as well, so both branches look uniform?
```
