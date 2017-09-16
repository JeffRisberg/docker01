FROM openjdk:8u131-jdk

ARG APP_VERSION
ARG APP
ARG JAR

ENV version ${APP_VERSION}
ENV application ${APP}

COPY target/docker01-jar-with-dependencies.jar /home/docker01-jar-with-dependencies.jar

# port for microservice
EXPOSE 5050

# remote debugging port for IntelliJ
EXPOSE 50505

CMD ["java", \
     "-agentlib:jdwp=transport=dt_socket,address=50505,suspend=n,server=y", \
     "-jar", \
     "/home/docker01-jar-with-dependencies.jar"]
