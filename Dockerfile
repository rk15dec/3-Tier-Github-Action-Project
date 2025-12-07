FROM amazoncorretto:21-alpine-jdk as builder
WORKDIR /app/source
COPY . .
RUN chmod +x mvnw
RUN ./mvnw package

FROM amazoncorretto:21-alpine-jdk
COPY --from=builder /app/source/target/*.jar /app/app.jar
EXPOSE 8082
VOLUME /data
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
