# Build stage#
FROM public.ecr.aws/docker/library/maven:3.9-eclipse-temurin-8 AS build
WORKDIR /app
COPY . .
RUN mvn install -DskipTests=true

# Run stage
FROM public.ecr.aws/docker/library/alpine:3.19
RUN apk add openjdk8
WORKDIR /run
COPY --from=build /app/target/shoe-ShoppingCart-0.0.1-SNAPSHOT.jar /run/shoe-ShoppingCart-0.0.1-SNAPSHOT.jar 
EXPOSE 8080
ENTRYPOINT java -jar /run/shoe-ShoppingCart-0.0.1-SNAPSHOT.jar
