FROM maven:3.6.3-jdk-11-slim AS build
COPY src /home/spring-petclinic/src
WORKDIR /home/spring-petclinic
COPY pom.xml .
RUN mvn -f pom.xml clean package

FROM openjdk:16-alpine AS stage
COPY --from=build /home/spring-petclinic/target/spring-petclinic-2.3.0.BUILD-SNAPSHOT.jar petclinic.jar 
EXPOSE 8080 8989
ENTRYPOINT ["java","-jar","petclinic.jar"]