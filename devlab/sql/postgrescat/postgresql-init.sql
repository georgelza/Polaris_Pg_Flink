
-- psql -h localhost -p 5432 -U dbadmin -d flink_catalog

GRANT ALL PRIVILEGES ON DATABASE flink_catalog TO dbadmin;


-- Apache Polaris Catalog Datastore

-- psql -h localhost -p 5432 -U dbadmin -d findept

CREATE DATABASE findept;
GRANT ALL PRIVILEGES ON DATABASE findept TO dbadmin;
