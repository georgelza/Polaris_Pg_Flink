## Apache Polaris (incubating) / Postgres for Persistence and Apache Flink 



1. Consume from PostgreSQL => Apacke Flink tables using CDC

2. -> Push to Iceberg Tables => Apache Polaris (incubating) Catalog - Persistence via PosgreSQL

3. -> Push to Apache Paimon Tabes => JDBC Catalog - Persistence via PosgreSQL


BLOG: []()

GIT REPO: [Polaris_Pg_Flink](https://github.com/georgelza/Polaris_pg_flink)


## Deployment

- Start basic stack
  
  - Execute `make run_basic` as defined in `devlab/Makefile` to run environment.

- Start full stack
    
    `To run the full stack take note you need to have build the "expanded Flink image" as defined in infrastructure/flink

  - Execute `make run` as defined in `devlab/Makefile` to run environment.

- `<Project Root>/devlab/docker-compose-flink.yml` which can be brought online by executing below, (this will use `.env`).

  - our Postgres init script will create 2 tables in our postgrescdc datastore: (`accountholders` and `transactions`).
  

- Next is moving the data into one or other direction.
  - You can either move the data directly to a Apache Iceberg or a Apache Paimon based table, stored on our MinIO based Object store.


## Stack

The following stack is deployed using one of the provided  `<Project Root>/devlab/docker-compose-*.yaml` files as per above.

- [Apache Polaris 1.2.0 (incubating)](https://polaris.apache.org)

- [Apache Flink 1.20.2](https://nightlies.apache.org/flink/flink-docs-release-1.20/)                   

- [Apache Flink CDC 3.5](https://nightlies.apache.org/flink/flink-cdc-docs-release-3.5/)

- [Apache Iceberg 1.9.1](https://iceberg.apache.org)

- [Apache Paimon 1.3.1.](https://paimon.apache.org)

- [PostgreSQL 12](https://www.postgresql.org)

- [MinIO](https://www.min.io) - Project has gone into Maintenance mode... 




### By: George Leonard
- georgelza@gmail.com
- https://www.linkedin.com/in/george-leonard-945b502/
- https://medium.com/@georgelza



### More Reading



