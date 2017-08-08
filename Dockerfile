FROM openjdk:8u131-jdk

ARG APP_VERSION
ARG APP
ARG JAR

ENV version ${APP_VERSION}
ENV application ${APP}

COPY target/docker01-jar-with-dependencies.jar /home/docker01-jar-with-dependencies.jar

EXPOSE 5050

CMD ["java", "-jar", "/home/docker01-jar-with-dependencies.jar"]
