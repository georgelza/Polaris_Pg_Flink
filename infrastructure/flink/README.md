## Building our Primary Flink Contaier

We have the option of building 3 different version/combinations stacks

### 1. Build combinations

- Apache Flink 1.20.1 + Apache Iceberg 1.9.1

  - `make pull_base`
  - `make pull`
  - `make build`


- Apache Flink 1.20.2 + Apache Iceberg 1.9.1

  - `make pull_base`
  - `make pull_1.20.2-1.9.1`
  - `make build1.20.2-1.9.1`
    
- Apache Flink 1.20.2 + Apache Iceberg 1.9.2

  - `make pull_base`
  - `make pull_1.20.2-1.9.2`
  - `make build1.20.2-1.9.2`


### 2. Container tag:

- Modify the IMAGE_NAME at the top of the Makefile

  - IMAGE_NAME=apacheflink-base-1.20.1-scala_2.12-java17

  or

  - IMAGE_NAMEapacheflink-base-1.20.2-scala_2.12-java17

- Then modify the `image:<name>` in the `devlab/docker-compose-flink.yaml `for the jobmanager and taskmanager service

  - image:apacheflink-base-1.20.1-scala_2.12-java17

  or

  - image: apacheflink-base-1.20.2-scala_2.12-java17

