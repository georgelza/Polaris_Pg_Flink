## Apache Polaris (incubating) / Postgres for Persistence and Apache Flink 

The following is a little explore of [Apache Polaris (incubating)](https://polaris.apache.org) as a Catalog store for Lakehouse environments, originally primarily Apache Iceberg as part of a Apache Flink environment.

### First: Re Polaris, What is it and whats does it do:

Polaris is a catalog for data lakes. It provides new levels of choice, flexibility and control over data, with full enterprise security and Apache Iceberg interoperability across a multitude of engines and infrastructure. Polaris builds on standards such as those created by Apache Iceberg, providing the following benefits for the ecosystem:

- Multi-engine interoperability over a single copy of data, eliminating the need for moving and copying data across different engines and catalogs.
- An interoperable security model providing a unified authorization layer independent from the engines processing analytical tables.
- For multi-catalog scenarios, a unified catalog level view of data across multiple catalogs via catalog notification integrations.
- The ability to host Polaris Catalog on the infrastructure of your choice.

Abstract as from: [PolarisProposal](https://cwiki.apache.org/confluence/display/INCUBATOR/PolarisProposal)


### Now back to our scheduled program:  ;)

The requirement originally started with me creating a application which created two data products, `accountholders` and `transactions`.
These are inserted into an Postgres database called `demog`.

[Apache Flink](https://flink.apache.org) was then to be configured to consume these using the [Apache Flink CDC framework](https://nightlies.apache.org/flink/flink-cdc-docs-stable/), making the the data available for processing.

Along the way I decided instead of using [Hive Metastore (HMS)](https://hive.apache.org), see Central Metastore Catalog, as my normal catalog, I'd explore Apache Polaris (incubating) and it's REST interface.

[Apache Polaris (incubating)](https://polaris.apache.org) is primarily a [Apache Iceberg](https://iceberg.apache.org) table format catalog, but does offer `Generic Table` functionality, enabling it to store metadata for tables other than Apache Iceberg, see: [What is a Generic Table?](https://polaris.apache.org/releases/1.2.0/generic-table/#what-is-a-generic-table).

Also important for me was catalog persistence. [Apache Polaris (incubating)](https://polaris.apache.org) natively come with PostgreSQL libraries.


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

- [PostgreSQL 12](https://www.postgresql.org)

- [MinIO](https://www.min.io) - Project has gone into Maintenance mode... 

- [Shadowtraffic](https://docs.shadowtraffic.io)


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



