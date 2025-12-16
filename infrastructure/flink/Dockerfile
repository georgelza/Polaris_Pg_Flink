FROM arm64v8/flink:1.20.1-scala_2.12-java17
SHELL ["/bin/bash", "-c"]


ENV FLINK_HOME=/opt/flink
ENV HIVE_HOME=$FLINK_HOME/conf/
ENV FLINK_VERSION_SHORT=1.20
ENV FLINK_VERSION_FULL=1.20.1
ENV ICEBERG_VERSION=1.9.1
ENV HADOOP_VERSION=2.8.3
ENV POSTGRESQL_CONNECTOR=42.7.6
ENV FLINK_CDC=3.5.0
ENV PAIMON_VERSION=1.3.1
WORKDIR $FLINK_HOME

RUN echo "--> Setup Directory Structure" && \
    mkdir -p ${FLINK_HOME}/conf/ && \
    mkdir -p ${FLINK_HOME}/checkpoints && \
    mkdir -p ${FLINK_HOME}/rocksdb 

# RUN echo "--> Install JARs: Flink's S3 plugin" && \
#     mkdir -p ./plugins/s3-fs-hadoop && \
#     mv ./opt/flink-s3-fs-hadoop-${FLINK_VERSION_FULL}.jar ./plugins/s3-fs-hadoop/

RUN echo "-> Install JARs: Postgres Driver and Flink CDC Postgres connector" && \
    mkdir -p ./lib/jdbc

COPY stage/flink-sql-connector-postgres-cdc-${FLINK_CDC}.jar    ${FLINK_HOME}/lib/jdbc/flink-sql-connector-postgres-cdc-${FLINK_CDC}.jar 
COPY stage/postgresql-${POSTGRESQL_CONNECTOR}.jar               ${FLINK_HOME}/lib/jdbc/postgresql-${POSTGRESQL_CONNECTOR}.jar 

# RUN echo "--> Install JARs: => Paimon 1.3.1" && \
#     mkdir -p ./lib/paimon

# COPY stage/paimon-flink-${FLINK_VERSION_SHORT}-${PAIMON_VERSION}.jar      ${FLINK_HOME}/lib/paimon/paimon-flink-${FLINK_VERSION_SHORT}-${PAIMON_VERSION}.jar
# COPY stage/paimon-s3-${PAIMON_VERSION}.jar                                ${FLINK_HOME}/lib/paimon/paimon-s3-${PAIMON_VERSION}.jar

RUN echo "-> Install JARs: Dependencies for Iceberg" && \
    mkdir -p ./lib/iceberg

COPY stage/iceberg-flink-runtime-${FLINK_VERSION_SHORT}-${ICEBERG_VERSION}.jar      ${FLINK_HOME}/lib/iceberg/iceberg-flink-runtime-${FLINK_VERSION_SHORT}-${ICEBERG_VERSION}.jar
COPY stage/iceberg-aws-bundle-${ICEBERG_VERSION}.jar                                ${FLINK_HOME}/lib/hadoop/iceberg-aws-bundle-${ICEBERG_VERSION}.jar

RUN echo "-> Install JARs: Flink Generic" 
COPY stage/flink-sql-parquet-${FLINK_VERSION_FULL}.jar                              ${FLINK_HOME}/lib/flink-sql-parquet-${FLINK_VERSION_FULL}.jar

RUN echo "-> Install JARs: AWS" && \
    mkdir -p ./lib/aws

COPY stage/bundle-2.20.18.jar                                                       ${FLINK_HOME}/lib/aws/bundle-2.20.18.jar

RUN echo "-> Install JARs: Hadoop/S3" && \
    mkdir -p ./lib/hadoop 

COPY stage/hadoop-common-${HADOOP_VERSION}.jar                                      ${FLINK_HOME}/lib/hadoop/hadoop-common-${HADOOP_VERSION}.jar
COPY stage/flink-shaded-hadoop-2-uber-${HADOOP_VERSION}-10.0.jar                    ${FLINK_HOME}/lib/hadoop/flink-shaded-hadoop-2-uber-${HADOOP_VERSION}-10.0.jar


RUN echo "-> Install JARs: Hadoop" && \
    mkdir -p ./lib/hadoop && pushd $_ && \
    curl https://repo1.maven.org/maven2/org/apache/commons/commons-configuration2/2.1.1/commons-configuration2-2.1.1.jar -O && \
    curl https://repo1.maven.org/maven2/commons-logging/commons-logging/1.1.3/commons-logging-1.1.3.jar -O && \
    curl https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-auth/3.3.4/hadoop-auth-3.3.4.jar -O && \
    curl https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-common/3.3.4/hadoop-common-3.3.4.jar -O && \
    curl https://repo1.maven.org/maven2/org/apache/hadoop/thirdparty/hadoop-shaded-guava/1.1.1/hadoop-shaded-guava-1.1.1.jar -O && \
    curl https://repo1.maven.org/maven2/org/codehaus/woodstox/stax2-api/4.2.1/stax2-api-4.2.1.jar -O && \
    curl https://repo1.maven.org/maven2/com/fasterxml/woodstox/woodstox-core/5.3.0/woodstox-core-5.3.0.jar -O && \
    curl https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-hdfs-client/3.3.4/hadoop-hdfs-client-3.3.4.jar -O && \
    curl https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-mapreduce-client-core/3.3.4/hadoop-mapreduce-client-core-3.3.4.jar -O  && \
    popd


RUN echo "--> Set Ownerships of /opt/flink" && \
    chown -R flink:flink $FLINK_HOME 

USER flink:flink

CMD ./bin/start-cluster.sh && sleep infinity