.DEFAULT_GOAL := help
include ../.env

IMAGE_NAME=apacheflink-base-1.20.1-scala_2.12-java17
VERSION=1.0.0

define HELP

Available commands:

- build: Build this project

endef

export HELP
help:
	@echo "$$HELP"
.PHONY: help

build : 
	@echo "🔨 Building Apache Flink 1.20.1 - Iceberg 1.9.1 Docker images..."
	docker build --build-arg REPO_NAME=${REPO_NAME} -t ${REPO_NAME}/${IMAGE_NAME}:${VERSION} --file Dockerfile.1.20.1-1.9.1 . --no-cache
	@echo "✅ Apache Flink Docker image built successfully"

build1.20.2-1.9.1: 
	@echo "🔨 Building Apache Flink 1.20.2 - Iceberg 1.9.1 Docker images..."
	docker build --build-arg REPO_NAME=${REPO_NAME} -t ${REPO_NAME}/${IMAGE_NAME}:${VERSION} --file Dockerfile.1.20.2-1.9.1 . --no-cache
	@echo "✅ Apache Flink Docker image built successfully"

build1.20.2-1.9.2: 
	@echo "🔨 Building Apache Flink 1.20.2 - Iceberg 1.9.2 Docker images..."
	docker build --build-arg REPO_NAME=${REPO_NAME} -t ${REPO_NAME}/${IMAGE_NAME}:${VERSION} --file Dockerfile.1.20.2-1.9.2 . --no-cache
	@echo "✅ Apache Flink Docker image built successfully"

pull_base:
	cd stage; wget https://repo1.maven.org/maven2/software/amazon/awssdk/bundle/2.31.9/bundle-2.31.9.jar \
    cd stage; wget https://repo1.maven.org/maven2/org/apache/flink/flink-shaded-hadoop-2-uber/2.8.3-10.0/flink-shaded-hadoop-2-uber-2.8.3-10.0.jar \
	cd stage; wget https://repo1.maven.org/maven2/org/postgresql/postgresql/42.7.6/postgresql-42.7.6.jar \
	cd stage; wget https://repo1.maven.org/maven2/org/apache/flink/flink-sql-connector-postgres-cdc/3.5.0/flink-sql-connector-postgres-cdc-3.5.0.jar \
	cd stage; wget https://repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-core/2.20.1/jackson-core-2.20.1.jar

# docker pull arm64v8/flink:1.20.1-scala_2.12-java17
# docker pull flink/flink:1.20.1-scala_2.12-java17
pull: paimon
	cd stage; wget https://repo1.maven.org/maven2/org/apache/flink/flink-connector-jdbc/3.3.0-1.20/flink-connector-jdbc-3.3.0-1.20.jar \
	cd stage; wget https://repo1.maven.org/maven2/org/apache/flink/flink-sql-json/1.20.1/flink-sql-json-1.20.1.jar \
	cd stage; wget https://repo.maven.apache.org/maven2/org/apache/flink/flink-json/1.20.1/flink-json-1.20.1.jar \
	cd stage; wget https://repo.maven.apache.org/maven2/org/apache/flink/flink-sql-parquet/1.20.1/flink-sql-parquet-1.20.1.jar \
	cd stage; wget https://repo1.maven.org/maven2/org/apache/iceberg/iceberg-flink-runtime-1.20/1.9.1/iceberg-flink-runtime-1.20-1.9.1.jar \
	cd stage; wget https://repo1.maven.org/maven2/org/apache/iceberg/iceberg-flink-1.20/1.9.1/iceberg-flink-1.20-1.9.1.jar \
	cd stage; wget https://repo1.maven.org/maven2/org/apache/iceberg/iceberg-aws-bundle/1.9.1/iceberg-aws-bundle-1.9.1.jar

# docker pull arm64v8/flink:1.20.2-scala_2.12-java17
# docker pull flink/flink:1.20.2-scala_2.12-java17
pull_1.20.2-1.9.1:
	cd stage; wget https://repo1.maven.org/maven2/org/apache/flink/flink-connector-jdbc/3.3.0-1.20/flink-connector-jdbc-3.3.0-1.20.jar \
	cd stage; wget https://repo1.maven.org/maven2/org/apache/flink/flink-sql-json/1.20.2/flink-sql-json-1.20.2.jar \
	cd stage; wget https://repo.maven.apache.org/maven2/org/apache/flink/flink-json/1.20.2/flink-json-1.20.2.jar \
	cd stage; wget https://repo.maven.apache.org/maven2/org/apache/flink/flink-sql-parquet/1.20.2/flink-sql-parquet-1.20.2.jar \
	cd stage; wget https://repo1.maven.org/maven2/org/apache/iceberg/iceberg-flink-runtime-1.20/1.9.1/iceberg-flink-runtime-1.20-1.9.1.jar \
	cd stage; wget https://repo1.maven.org/maven2/org/apache/iceberg/iceberg-flink-1.20/1.9.1/iceberg-flink-1.20-1.9.1.jar \
	cd stage; wget https://repo1.maven.org/maven2/org/apache/iceberg/iceberg-aws-bundle/1.9.1/iceberg-aws-bundle-1.9.1.jar

# docker pull arm64v8/flink:1.20.2-scala_2.12-java17
# docker pull flink/flink:1.20.2-scala_2.12-java17
pull_1.20.2-1.9.2: 
	cd stage; wget https://repo1.maven.org/maven2/org/apache/flink/flink-connector-jdbc/3.3.0-1.20/flink-connector-jdbc-3.3.0-1.20.jar \
	cd stage; wget https://repo1.maven.org/maven2/org/apache/flink/flink-sql-json/1.20.2/flink-sql-json-1.20.2.jar \
	cd stage; wget https://repo.maven.apache.org/maven2/org/apache/flink/flink-json/1.20.2/flink-json-1.20.2.jar \
	cd stage; wget https://repo.maven.apache.org/maven2/org/apache/flink/flink-sql-parquet/1.20.2/flink-sql-parquet-1.20.2.jar \
	cd stage; wget https://repo1.maven.org/maven2/org/apache/iceberg/iceberg-flink-runtime-1.20/1.9.2/iceberg-flink-runtime-1.20-1.9.2.jar \
	cd stage; wget https://repo1.maven.org/maven2/org/apache/iceberg/iceberg-flink-1.20/1.9.2/iceberg-flink-1.20-1.9.2.jar \
	cd stage; wget https://repo1.maven.org/maven2/org/apache/iceberg/iceberg-aws-bundle/1.9.2/iceberg-aws-bundle-1.9.2.jar \
	cd stage; wget https://repo1.maven.org/maven2/org/apache/paimon/paimon-flink-1.20/1.2.0/paimon-flink-1.20-1.3.0.jar

paimon:
	cd stage; wget https://repo1.maven.org/maven2/org/apache/paimon/paimon-s3/1.3.1/paimon-s3-1.3.1.jar \
	cd stage; wget https://repo1.maven.org/maven2/org/apache/paimon/paimon-flink-1.20/1.3.1/paimon-flink-1.20-1.3.1.jar
