# java build stage
FROM dhi.io/maven:3.9.14-jdk17-alpine3.22-dev AS java_builder

USER 0
RUN mkdir /artifact
RUN --mount=type=bind,source=.,target=/src,rw \
    mvn clean package -f /src && \
    cp /src/target/application.jar /artifact/application.jar

# Run environment
FROM docker.io/milkliver/openjdk-17-runtime:202603

USER 0
WORKDIR /app
RUN --mount=type=bind,from=java_builder,source=/artifact/application.jar,target=/tmp/target/application.jar \
    cp /tmp/target/application.jar /app/application.jar && \
    chmod 644 /app/application.jar

USER 65532
ENTRYPOINT ["java"]
CMD ["-jar", "/app/application.jar"]
