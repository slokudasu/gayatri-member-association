FROM maven:3.9.9-eclipse-temurin-17 AS build
WORKDIR /workspace

COPY pom.xml ./
RUN mvn -B -q -DskipTests dependency:go-offline

COPY src ./src
RUN mvn -B -q -DskipTests package && \
    WAR_PATH="$(ls target/*.war | grep -v '\.original$' | head -n 1)" && \
    cp "${WAR_PATH}" /tmp/app.war

FROM eclipse-temurin:17-jdk
WORKDIR /app

COPY --from=build /tmp/app.war /app/app.war

EXPOSE 8080

ENV JAVA_OPTS=""
ENTRYPOINT ["sh", "-c", "if [ -n \"${DATABASE_URL}\" ] && [ -z \"${SPRING_DATASOURCE_URL}\" ]; then DB_URI=\"${DATABASE_URL#postgresql://}\"; DB_URI=\"${DB_URI#postgres://}\"; DB_HOST_AND_PATH=\"${DB_URI#*@}\"; if [ \"${DB_HOST_AND_PATH}\" = \"${DB_URI}\" ]; then DB_HOST_AND_PATH=\"${DB_URI}\"; fi; DB_HOST_PORT=\"${DB_HOST_AND_PATH%%/*}\"; DB_PATH=\"${DB_HOST_AND_PATH#*/}\"; if [ \"${DB_PATH}\" = \"${DB_HOST_AND_PATH}\" ]; then DB_PATH=\"\"; fi; if [ -n \"${DB_PATH}\" ]; then export SPRING_DATASOURCE_URL=\"jdbc:postgresql://${DB_HOST_PORT}/${DB_PATH}\"; else export SPRING_DATASOURCE_URL=\"jdbc:postgresql://${DB_HOST_PORT}\"; fi; fi; if [ -n \"${DATABASE_URL}\" ] && [ -z \"${SPRING_DATASOURCE_DRIVER}\" ]; then export SPRING_DATASOURCE_DRIVER=\"org.postgresql.Driver\"; fi; java ${JAVA_OPTS} -Dserver.port=${PORT:-8080} -jar /app/app.war"]
