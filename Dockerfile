# Build stage#
FROM maven:3.5.3-jdk-8-alpine AS build
WORKDIR /app
COPY . .
RUN mvn install -DskipTests=true

# Run stage
FROM amazoncorretto:8-al2-generic-jdk
WORKDIR /run
COPY --from=build /app/target/shoe-ShoppingCart-0.0.1-SNAPSHOT.jar /run/shoe-ShoppingCart-0.0.1-SNAPSHOT.jar 
EXPOSE 8011
ENTRYPOINT java -jar /run/shoe-ShoppingCart-0.0.1-SNAPSHOT.jar
