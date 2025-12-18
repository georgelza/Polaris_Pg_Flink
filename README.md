## Apache Iceberg with Apache Polaris as Catalog with PostgreSQL for Persistence & MinIO Object store.

The following is a little explore of [Apache Polaris (incubating)](https://polaris.apache.org) as a Catalog store for Lakehouse environments,  primarily an Apache Iceberg catalog store.

### First: What is Apache Polaris and whats does it do for us

Polaris is a catalog for data lakes. It provides new levels of choice, flexibility and control over data, with full enterprise security and [Apache Iceberg](https://iceberg.apache.org) interoperability across a multitude of engines and infrastructure. Polaris builds on standards such as those created by [Apache Iceberg](https://iceberg.apache.org), providing the following benefits for the ecosystem:

- Multi-engine interoperability over a single copy of data, eliminating the need for moving and copying data across different engines and catalogs.
- An interoperable security model providing a unified authorization layer independent from the engines processing analytical tables.
- For multi-catalog scenarios, a unified catalog level view of data across multiple catalogs via catalog notification integrations.
- The ability to host Polaris Catalog on the infrastructure of your choice.

Abstract as from: [PolarisProposal](https://cwiki.apache.org/confluence/display/INCUBATOR/PolarisProposal)


### Now back to our scheduled programming:  ;)

The requirement originally started with me creating a application which created two data products using [ShadowTraffic](https://docs.shadowtraffic.io) 

- `accountholders`

- `transactions`


These data products are inserted into our [Postgres](https://www.postgresql.org) database called `demog`, which is hosted by our `postgrescdc` docker-compose based service.

The plan is then to consume this data stream from PostgreSQL into [Apache Flink](https://flink.apache.org) using the [Apache Flink CDC framework](https://nightlies.apache.org/flink/flink-cdc-docs-stable/). This is accomplished by defining 2 tables inside [Apache Flink](https://flink.apache.org), referncing our [Postgres](https://www.postgresql.org) database/tables.

From here we can then work with this data. This would normally be via either Java based jobs, Python based jobs via PyFlink framework or using Apache Flink SQL.

The output of these processing step are records insert into a Lakehouse tables, referred to as an Open Table Formats, the most popular being:

- [Apache Iceberg](https://iceberg.apache.org)

- [Apache Paimon](https://paimon.apache.org)

- [Apache Hudi](https://hudi.apache.org)

- [Delta Lake](https://delta.io)


Now, a phone book, ye I'm old enough to know what thye looked like was useless without the index at the back. That index was a sort of catalog of the records contained in the book, 

The index in the back was our "reference" of what tables/records are in our book and where to find them. 

And thats what a catalog does for us, it keeps track of our tables, their structures, storage location, access rules, other words, metadata etc.

All this allows one user to create tables inside a database in one session and makes this available to another user in a different session to access that table and the contents, using the processing engine of choice.

In the past, I use to use [Hive Metastore (HMS)](https://hive.apache.org)/see Central Metastore Catalog. But lets see, I like rabit holes so decided to mix things up a bit, or was that I wanted to simplify the stack (HMS is tech heavy), and here we are, lets introduce [Apache Polaris (incubating)](https://polaris.apache.org) and it's [REST](https://en.wikipedia.org/wiki/REST) interface as Catalog service for our [Apache Iceberg](https://iceberg.apache.org) based Lakehouse.

## What is a Lakehouse

A data lakehouse is a modern data architecture blending the flexibility and low-cost storage of a data lake with the structure, performance, and management features of a data warehouse, creating a unified platform for diverse data types and workloads like BI, SQL, data science, and machine learning, all from one central repository. It achieves this by using open formats (like [Delta Lake](https://delta.io), [Apache Iceberg](https://iceberg.apache.org), [Apache Hudi](https://hudi.apache.org)) on top of object storage, adding database-like capabilities (transactions, schema enforcement) for reliability and quality. 


### Key Components & Features:

- Unified Storage: Stores structured, semi-structured, and unstructured data together, eliminating silos.

- Data Lake Benefits: Low-cost, scalable storage (e.g., cloud object storage) and flexibility for raw data.

- Data Warehouse Benefits: ACID transactions, schema enforcement, data quality, and performance for BI.

- Open Formats: Uses open standards (Iceberg, Delta, Hudi) for interoperability and avoiding vendor lock-in.

- Decoupled Compute & Storage: Allows independent scaling of processing power and storage.

- Diverse Workloads: Supports SQL analytics, BI, data science, and machine learning on the same data. 

### Benefits:

- Simplified Architecture: Replaces complex multi-tiered systems with a single source of truth.

- Reduced Costs: Lowers ETL, data duplication, and storage expenses.

- Improved Governance: Easier to manage security and data quality centrally.

- Faster Insights: Enables real-time streaming and quicker access to refined data. 


## About Apache Polaris (incubating) 

Some background on [Apache Polaris (incubating)](https://polaris.apache.org) first, Polaris is an open source project donated to the community by [Snowflake](http://snowflake.com):

[Apache Polaris (incubating)](https://polaris.apache.org) was initially created by engineers at [Snowflake](http://snowflake.com), who open-sourced the technology in June 2024 and contributed it to the Apache Software Foundation for incubation. [Dremio](https://www.dremio.com) was an original co-creator and has been a leading contributor to the project since its inception. 

The project is now a community-driven open-source initiative under the Apache Software Foundation, with contributions from a diverse group of companies including AWS, Google Cloud, Azure, Stripe, IBM, and others. 

Key individuals involved in writing and authoring guides on [Apache Polaris (incubating)](https://polaris.apache.org) include:

- [Alex Merced](https://www.linkedin.com/in/alexmerced/) (Head of Developer Relations at [Dremio](https://www.dremio.com)), a primary author of the O'Reilly book [Apache Polaris : The Definitive Guide](https://hello.dremio.com/wp-apache-polaris-guide-reg.html).

- [Andrew Madson](https://www.linkedin.com/in/andrew-madson/) and [Tomer Shiran](https://www.linkedin.com/in/tshiran/) (Founder and Chief Product Officer of [Dremio](https://www.dremio.com)) are also listed as co-authors of the definitive guide. 


As per previous, [Apache Polaris (incubating)](https://polaris.apache.org) is primarily an [Apache Iceberg](https://iceberg.apache.org) table format catalog, but does offer `Generic Table` functionality, enabling it to store metadata for tables other than [Apache Iceberg](https://iceberg.apache.org), see: [What is a Generic Table?](https://polaris.apache.org/releases/1.2.0/generic-table/#what-is-a-generic-table).

Also critical is catalog persistence. [Apache Polaris (incubating)](https://polaris.apache.org) just happens to natively include every to interface with PostgreSQL.

BLOG: []()

GIT REPO: [Polaris_Pg_Flink](https://github.com/georgelza/Polaris_pg_flink)

NOTE: this project is build on the back of [Open Table Formats (Apache Iceberg and Apache Paimon) with JDBC based Catalog backed by PostgreSQL for Persistence](https://github.com/georgelza/OTF_with-JDBC_Based_Catalog_and_PostgreSQL_persistence.git) where we figured out what Jar fiile combination we need for Apache Flink/Apache Iceberg/MinIO to work together.


## About our Stack:

### Overview

The stack goes through 3 phases, if we can call it that:

- Build the minimum environment to get our [Apache Polaris (incubating)](https://polaris.apache.org) catalog up, with the PostgreSQL backend datastore and MinIO configured/integrated.

- Add to this minimul stack our [Apache Flink 1.20.1](https://flink.apache.org) cluster, enabling us to define our catalog, create a Flink database and create tables inside our database homed inside our catalog.

- Run our data generation utilizing [Shadowtraffic](https://docs.shadowtraffic.io), providing us with a data stream into a PostgreSQL datastore, which we will CDC source and move around.


## NOTES


Take note of the `s3a://` usage when referring to our MinIO Object store locations. This is defined in our: 

- `Docker-compose.yaml` file for the Jobmanager and Taskmanager service configuration. 

- `Docker-compose.yaml` file for the polaris-setup service configuration. 

- In the Apache Flink configuration file as part of the `fs.s3a.*` parameters, (se: `<Project root>/devlab/conf/config.yaml`)

- Part of our Apache Flink Container build, (see: `<Project root>/infrastructure/flink/Dockerfile`), we create `FLINK_HOME/conf/core-site.xml` where we specify our s3 configuraiton and credentials.

- Our Apache Flink catalog create, where we specify we will be using a REST based catalog (see: `<Project root>/devlab/creFlinkFlows/1.1.creCat.sql`)


## Building and Running the environment

You're reading this file, under this directory is our `devlab`, `infrastructure` and `shadowtraffic` sub directories.

- `devlab` contains all our code to run the projects.

- `infrastructure` is where our `Dockerfile`'s are used to build the environment, in addition to `Makefiles` that can be used to `docker pull` our base containers and `wget` additional `jar` modules.

- `shadowtraffic` contains our data generator/config file.
  
You will also found a configuration file used to provide various environment variables as used by our `Docker-compose.yaml` projects in `devlab/.env`.

Our environment can be build and brough online using `devlab/Makefile`:

The first time you start the project, we need to pull and build the required containers, this can be done by:


### 1. via devlab ...

- `cd ../devlab`

- `make build`

or


### 2. via infrastructure ...

-  `cd infrastructure`
-  `make pull_base`
-  `make pull`
-  `make build`

At this point we can startup the minimum environment to make sure our Polaris/Postgres and MinIO is working, or the full stack which adds the Apache Flink cluster.


## Run the Stack

1. Minimal Environment (Polaris, Postgres and MinIO), which will use `<Project Root>/devlab/docker-compose-basic.yml`

   - `make run_base`

   - ... look around

   - `make down`
  

2. Full Environment (Polaris, Flink, Postgres and MinIO), which will use `<Project Root>/devlab/docker-compose-flink.yml`

   - `make run`

   - ... run shadowtraffic, 
   - Execute Flink SQL to move the data from the CDC source tables into our apache Iceberg tables configured with persistent storage on our MinIO object storage service, aka S3 service.

   - `make down`


### Notes

During the startup cycle of our PostgreSQL datastore's, they will go through their standard bootstrap process which happens to include creating a database. If you want to create some personal bits, modify this process then you are able to place your desired SQL inside `postgresql-init.sql` which is mapped/moutned into the PostgreSQL container and run at startup.

For our datastore used for Shadowtraffic, I've placed SQL in the above script to create the following 2 tables, they will be used as target tables for ShadowTraffic and also be our source tables for Apache Flink CDC (note, I could have opted to simply have ShadowTraffic create these tables itself, but I like to do things more in line with how things happen in a production realm). For now these tables are located in a database called `demog` inside the `public` schema.

- `accountholders` 

- `transactions`
  

### Management interfaces

- Polaris Console: http://localhost:4000  ([Polaris Tools / Console](https://github.com/apache/polaris-tools/tree/main/console))
- Polaris: http://localhost:8181 (Client API)
- Polaris: http://localhost:8181 (Management API)
- Flink UI: http://localhost:8084 (Console)
- MinIO API: http://localhost:9000 (Client API)
- MinIO UI: http://localhost:9001 (Console, mnadmin/mnpassword)


## Software/package versions

The following stack is deployed using one of the provided  `<Project Root>/devlab/docker-compose-*.yaml` files as per above.

- [Apache Polaris 1.2.0 (incubating)](https://polaris.apache.org)

- [Apache Polaris (incubating) - Tools](https://github.com/apache/polaris-tools/tree/main/console)

- [Apache Flink 1.20.1](https://flink.apache.org)                   
  
- [Apache Flink CDC 3.5](https://nightlies.apache.org/flink/flink-cdc-docs-release-3.5/)

- [Apache Iceberg 1.9.1](https://iceberg.apache.org)

- [PostgreSQL 12](https://www.postgresql.org)

- [MinIO](https://www.min.io) - Project has gone into Maintenance mode... 

- [Shadowtraffic](https://docs.shadowtraffic.io)


So, Up to here was the original Blog… ;) see more Rabbit Holes, I was asked to have a look at the **Polaris Tools** and the included console. Originally, seeing I was required to git clone, npm build etc etc… was not sure if I wanted to take the wonder down the Rabbit hole, but ye well, then had time and there I went. 

For those interested, I pushed the docker image to my personal [docker hub repo](https://hub.docker.com/repository/docker/georgelza/polaris-console/general). Sure the project will host it themselves soon also.

And am I glad I did. Below are just a couple of screen shots of the various screens, and information contained.

Some notes, See the additional information added to the `.env` file. We also now have a `Polaris-tools` docker-compose service defined.
When you try and log in, and first thing you wonder, what’s the username and password, you will notice the field tags, `client_id` and `client_secret`, as per our `.env` file, in our case `root` & `s3cr3t`


```yaml
# Polaris Console -> matching our <Project root>/devlab/.env values
VITE_POLARIS_API_URL=http://polaris:8181
VITE_POLARIS_REALM=findept 
VITE_POLARIS_REALM_HEADER_NAME=Polaris-Realm                    # optional, defaults to "Polaris-Realm"
VITE_OAUTH_TOKEN_URL=http://polaris:8181/api/v1/oauth/tokens    # optional
```

- **See screen grab Images**: `<Project root>/blog-doc/polaris-tools/*`


## By: George Leonard

- georgelza@gmail.com
- https://www.linkedin.com/in/george-leonard-945b502/
- https://medium.com/@georgelza


