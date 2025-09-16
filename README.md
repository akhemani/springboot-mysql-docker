# Spring Boot + MySQL Docker

This repository demonstrates how to containerize a **Java Spring Boot application** with a **MySQL database** using Docker.  
It evolves through three versions, starting from a quick "Fast & Loose" setup and moving toward a production-ready deployment with bonus challenges.

---

**V1 Fast &amp; Loose (quick, not production ready)  
V2 Production Ready (hardened best practices)  
V3 Bonus Challenges (multi-stage builds, health checks, monitoring, env vars)**

---

## 📌 Project Overview
- **Technology stack:** Java 17, Spring Boot, MySQL 8, Docker, Docker Compose
- **Use case:** A simple REST API that stores and retrieves visits in a MySQL database
- **Goal:** Show the journey from a minimal Docker setup to a production-ready stack

---

## 🛠 Versions Available

This repo is organized into **branches**, each representing a version:

1. **[`version/v1-fast`](../../tree/version/v1-fast)**  
   - Quick setup ("Fast & Loose")  
   - Single-stage Dockerfile, runs as root, DB port exposed  
   - Focus: *get it working quickly*  

2. **[`version/v2-prod`](../../tree/version/v2-prod) [default]**  
   - Production-ready best practices  
   - Multi-stage builds, non-root user, health checks, secrets & env configs  
   - Focus: *secure, optimized, ready for real use*  

3. **[`version/v3-bonus`](../../tree/version/v3-bonus)**  
   - Bonus challenges on top of prod version  
   - Adds multi-stage demo, Docker health checks, monitoring, env var injection  
   - Focus: *extra credit and exploration*  

---

## 🚀 How to Use
1. Clone this repository:
   ```bash
   git clone https://github.com/<your-username>/springboot-mysql-docker.git
   cd springboot-mysql-docker
