FROM openjdk:8-jre

EXPOSE 9091

WORKDIR /dynamodb
RUN wget -O /tmp/dynamodb_local_latest https://s3-us-west-2.amazonaws.com/dynamodb-local/dynamodb_local_latest.tar.gz && \
    tar xfz /tmp/dynamodb_local_latest && \
    rm -f /tmp/dynamodb_local_latest

ENTRYPOINT ["java", "-Djava.library.path=.", "-jar", "DynamoDBLocal.jar", "-port", "9091"]
