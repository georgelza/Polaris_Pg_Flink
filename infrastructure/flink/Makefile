.DEFAULT_GOAL := help
include ../.env

IMAGE_NAME=apacheflink-base-1.20.1-scala_2.12-java17
VERSION=1.0.0

FLINK_HOME=/opt/flink
HIVE_HOME=$FLINK_HOME/conf/

FLINK_VERSION_SHORT=1.20
FLINK_VERSION_FULL=1.20.1
ICEBERG_VERSION=1.9.1
#HADOOP_VERSION=2.8.3
#HADOOP_VERSION=3.3.4
HADOOP_VERSION=3.4.1
POSTGRESQL_CONNECTOR=42.7.6
FLINK_CDC=3.5.0
PAIMON_VERSION=1.3.1
JDBC_VERSION=3.3.0
define HELP

Available commands:

- pull:  Pull/wget all jar's

- build: Build this project

endef

export HELP
help:
	@echo "$$HELP"
.PHONY: help

build : 
	@echo "🔨 Building Apache Flink ${FLINK_VERSION_FULL} - Iceberg ${ICEBERG_VERSION} Docker images..."
	docker build --build-arg REPO_NAME=${REPO_NAME} -t ${REPO_NAME}/${IMAGE_NAME}:${VERSION} --file Dockerfile . --no-cache
	@echo "✅ Apache Flink Docker image built ${IMAGE_NAME}:${VERSION} successfully"


pull: pull_base paimon iceberg
	cd stage; wget https://repo1.maven.org/maven2/org/apache/flink/flink-connector-jdbc/${JDBC_VERSION}-${FLINK_VERSION_SHORT}/flink-connector-jdbc-${JDBC_VERSION}-${FLINK_VERSION_SHORT}.jar \
	cd stage; wget https://repo1.maven.org/maven2/org/apache/flink/flink-sql-json/${FLINK_VERSION_FULL}/flink-sql-json-${FLINK_VERSION_FULL}.jar \
	cd stage; wget https://repo1.maven.org/maven2/org/apache/flink/flink-sql-connector-postgres-cdc/${FLINK_CDC}/flink-sql-connector-postgres-cdc-${FLINK_CDC}.jar \
    cd stage; wget https://repo1.maven.org/maven2/org/apache/flink/flink-shaded-hadoop-2-uber/${HADOOP_VERSION}-10.0/flink-shaded-hadoop-2-uber-${HADOOP_VERSION}-10.0.jar \
	cd stage; wget https://repo.maven.apache.org/maven2/org/apache/flink/flink-json/${FLINK_VERSION_FULL}/flink-json-${FLINK_VERSION_FULL}.jar \
	cd stage; wget https://repo.maven.apache.org/maven2/org/apache/flink/flink-sql-parquet/${FLINK_VERSION_FULL}/flink-sql-parquet-${FLINK_VERSION_FULL}.jar 
	
pull_base:
	cd stage; wget https://repo1.maven.org/maven2/software/amazon/awssdk/bundle/2.31.9/bundle-2.31.9.jar \
	cd stage; wget https://repo1.maven.org/maven2/org/postgresql/postgresql/${POSTGRESQL_CONNECTOR}/postgresql-${POSTGRESQL_CONNECTOR}.jar \
	cd stage; wget https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/2.8.3/hadoop-aws-${HADOOP_VERSION}.jar \
	cd stage; wget https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-client/2.8.3/hadoop-client-${HADOOP_VERSION}.jar \
	cd stage; wget https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-common/3.3.4/hadoop-common-${HADOOP_VERSION}.jar \
    cd stage; wget https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bundle/1.12.789/aws-java-sdk-bundle-1.12.789.jar \
	cd stage; wget https://repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-core/2.20.1/jackson-core-2.20.1.jar 

paimon:
	cd stage; wget https://repo1.maven.org/maven2/org/apache/paimon/paimon-s3/${PAIMON_VERSION}/paimon-s3-${PAIMON_VERSION}.jar \
	cd stage; wget https://repo1.maven.org/maven2/org/apache/paimon/paimon-flink-${FLINK_VERSION_SHORT}/${PAIMON_VERSION}/paimon-flink-${FLINK_VERSION_SHORT}-${PAIMON_VERSION}.jar

iceberg:
	cd stage; wget https://repo1.maven.org/maven2/org/apache/iceberg/iceberg-flink-runtime-${FLINK_VERSION_SHORT}/${ICEBERG_VERSION}/iceberg-flink-runtime-${FLINK_VERSION_SHORT}-${ICEBERG_VERSION}.jar \
	cd stage; wget https://repo1.maven.org/maven2/org/apache/iceberg/iceberg-flink-${FLINK_VERSION_SHORT}/${ICEBERG_VERSION}/iceberg-flink-${FLINK_VERSION_SHORT}-${ICEBERG_VERSION}.jar \
	cd stage; wget https://repo1.maven.org/maven2/org/apache/iceberg/iceberg-aws-bundle/${ICEBERG_VERSION}/iceberg-aws-bundle-${ICEBERG_VERSION}.jar
