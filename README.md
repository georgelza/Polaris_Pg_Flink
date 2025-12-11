## Apache Polaris (incubating) / Postgres for Persistence and Apache Flink 

The following is a little explore of [Apache Polaris (incubating)](https://polaris.apache.org) as a Catalog store for Lakehouse environments, originally primarily Apache Iceberg as part of a Apache Flink environment.

The requirement originally started with me creating a application which created two data products, `accountholders` and `transactions`.
These are inserted into an Postgres database called demog.

Apache Flink was then to be configured to consume these using the Apache Flink CDC framework, making the the data available for processing.

Along the way I decided instead of using Hive Metastore (HMS) as my normal catalog, I'd explore Apache Polaris (incubating) and it's REST interface.

Apache Polaris (incubating) is primarily a Iceberg catalog, but does offer `Generic Table` functionality, enabling it to store metadata for tables other than Apache Iceberg, see: [What is a Generic Table?](https://polaris.apache.org/releases/1.2.0/generic-table/#what-is-a-generic-table).

Also important for me was catalog persistence. [Apache Polaris (incubating)](https://polaris.apache.org) natively come with PostgreSQL libraries.

Deviating a little bit... Not all implimentations/projects, might utilize Apache Iceberg for all the data, so we said, as we're using Apache Flink and there is a strong relationship in the real time streaming world with Apache Paimon how would we manage/accommodate "caalog services" for it. This is where we now have 2 options. 

1. The `Generic Table` functionality from Apache Polaris or

2. Apache Paimon's support for a metastore: `jdbc` which allows it to store metadata directly into any jdbc compliant datastore, and as we're already using PostgreSQL is just implied an additional database or schema in our PostgreSQL environment.


BLOG: []()

GIT REPO: [Polaris_Pg_Flink](https://github.com/georgelza/Polaris_pg_flink)


## The stack:

### Building and Running

as defined in `devlab/Makefile` to run environment, (this will use `.env`).

The first time, first build the required containers.

- `cd ../devlab`

- `make build`

Then you can run, either of the following 2 options. both files will utilize the `.env` file located in `<Project Root>/devlab`.

Minimal Environment (Polaris, Postgres and MinIO), which will use `<Project Root>/devlab/docker-compose-basic.yml`

- `make run_base`

Full Environment (Polaris, Flink, Postgres and MinIO), which will use `<Project Root>/devlab/docker-compose-flink.yml`

- `make run`


During the startup cycle of our PostgreSQL datastore it will run it's bootstrap init script which will create the following 2 tables.
For the purpose of this blog i've simplified their structure.

- `accountholders` 

- `transactions`
  

### Software/package versions

The following stack is deployed using one of the provided  `<Project Root>/devlab/docker-compose-*.yaml` files as per above.

- [Apache Polaris 1.2.0 (incubating)](https://polaris.apache.org)

- [Apache Flink 1.20.2](https://nightlies.apache.org/flink/flink-docs-release-1.20/)                   

- [Apache Flink CDC 3.5](https://nightlies.apache.org/flink/flink-cdc-docs-release-3.5/)

- [Apache Iceberg 1.9.1](https://iceberg.apache.org)

- [Apache Paimon 1.3.1.](https://paimon.apache.org)

- [PostgreSQL 12](https://www.postgresql.org)

- [MinIO](https://www.min.io) - Project has gone into Maintenance mode... 


### Management interfaces

- Polaris: http://localhost:8181 (Client API)
- Polaris: http://localhost:8181 (Management API)
- Flink UI: http://localhost:8084 (Console)
- MinIO API: http://localhost:9000 (Client API)
- MinIO UI: http://localhost:9001 (Console, mnadmin/mnpassword)


### By: George Leonard
- georgelza@gmail.com
- https://www.linkedin.com/in/george-leonard-945b502/
- https://medium.com/@georgelza



### More Reading



