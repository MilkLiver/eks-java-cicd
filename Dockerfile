FROM docker.io/milkliver/openjdk-17-runtime:202603

RUN mkdir /workspace
WORKDIR /workspace
RUN --mount=type=bind,source=target/application.jar,target=/tmp/target/application.jar \
    cp /tmp/target/application.jar /workspace/application.jar \
    chmod 644 /workspace/application.jar

ENTRYPOINT ["java"]
CMD ["-jar", "/workspace/application.jar"]
