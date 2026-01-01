FROM maven:3.8.3-openjdk-17 AS builder

WORKDIR /app

COPY . /app
# these will skip the test case 
RUN mvn clean install -DskipTests=True 


# stage 2 where we run the application 

# Import small size java image
FROM eclipse-temurin:21-jre-alpine

WORKDIR /app

# copy the file from above image andrun in the another image 
# by default the file created inside  the target with extension .jar 
# our app name you can get from src> resources >> application.properties 

COPY --from=builder /app/target/*.jar /app/expense.jar 


CMD ["java", "-jar", "/app/expense.jar"]