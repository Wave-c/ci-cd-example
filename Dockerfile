# =========================
# 1️⃣ Build stage
# =========================
FROM maven:3.9.9-eclipse-temurin-21 AS build

WORKDIR /build

# --- 1. Копируем parent pom ---
COPY pom.xml .

RUN mvn -B -ntp \
    dependency:go-offline

COPY src ./src

# --- 5. Собираем jar ---
RUN mvn -B -ntp \
    package \
    -DskipTests

# =========================
# 2️⃣ Runtime stage
# =========================
FROM eclipse-temurin:21-jre-jammy

WORKDIR /app

RUN useradd -r -u 1001 appuser
USER appuser

COPY --from=build /build/target/*.jar app.jar

ENV JAVA_OPTS="-XX:MaxRAMPercentage=75 -XX:+UseG1GC"

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]