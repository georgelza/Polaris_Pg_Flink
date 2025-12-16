
USE CATALOG default_catalog;
  
-- Inbound from PostgreSQL via CDC Process
CREATE CATALOG c_cdcsource WITH 
    ('type'='generic_in_memory'); 


CREATE DATABASE IF NOT EXISTS c_cdcsource.demog;  


-- Iceberg based REST Catalog stored inside PostgreSQL database using Polaris as catalog store
-------------------------------------------------------------------------------------------------------------------------
-- server: postgrescat
-- db: findept
-- schema: polaris_schema
CREATE CATALOG c_iceberg WITH (
   'type'                       = 'iceberg'
  ,'catalog-type'               = 'rest'
  ,'uri'                        = 'http://polaris:8181/api/catalog'
  ,'warehouse'                  = 'icebergcat'
  ,'oauth2-server-uri'          = 'http://polaris:8181/api/catalog/v1/oauth/tokens'
  ,'credential'                 = 'root:s3cr3t'
  ,'scope'                      = 'PRINCIPAL_ROLE:ALL'
  ,'s3.endpoint'                = 'http://minio:900'
  ,'s3.access-key-id'           = 'mnadmin'
  ,'s3.secret-access-key'       = 'mnpassword'
  ,'s3.path-style-access'       =' true'
  ,'table-default.file.format'  = 'parquet'
);

USE CATALOG c_iceberg;
CREATE DATABASE IF NOT EXISTS c_iceberg.finflow;
SHOW DATABASES;
-- Create a database in Flink in that catalog (a database in Flink maps to a namespace in Polaris):


-- Paimon based Catalog stored inside PostgreSQL database using JDBC interface
-------------------------------------------------------------------------------------------------------------------------
-- server: postgrescat
-- db: flink_catalog
-- schema: iceberg_jdbc
CREATE CATALOG c_iceberg_jdbc WITH (
   'type'                      = 'iceberg'
  ,'catalog-impl'              = 'org.apache.iceberg.jdbc.JdbcCatalog'
  ,'uri'                       = 'jdbc:postgresql://postgrescat:5432/flink_catalog?currentSchema=iceberg_jdbc'
  ,'jdbc.user'                 = 'dbadmin'
  ,'jdbc.password'             = 'dbpassword'
  ,'jdbc.driver'               = 'org.postgresql.Driver'
  ,'warehouse'                 = 's3a://warehouse/iceberg_jdbc'
  ,'table-default.file.format' = 'parquet'
);

USE CATALOG c_iceberg_jdbc;
CREATE DATABASE IF NOT EXISTS c_iceberg_jdbc.finflow;
SHOW DATABASES;


-- Paimon based Catalog stored inside PostgreSQL database using JDBC interface
-------------------------------------------------------------------------------------------------------------------------
-- server: postgrescat
-- db: flink_catalog
-- schema: paimon_jdbc
CREATE CATALOG c_paimon_jdbc WITH (
   'type'                       = 'paimon'
  ,'metastore'                  = 'jdbc'                       -- JDBC Based Catalog

  -- PostgreSQL connection details
  ,'catalog-key'                = 'jdbc'
  ,'uri'                        = 'jdbc:postgresql://postgrescat:5432/flink_catalog?currentSchema=paimon_jdbc'
  ,'jdbc.user'                  = 'dbadmin'
  ,'jdbc.password'              = 'dbpassword'

  -- Optional: JDBC driver (auto-detected if not specified)
  ,'jdbc.driver'                = 'org.postgresql.Driver'

  -- Data warehouse location (can be S3, HDFS, or local)
  ,'warehouse'                  = 's3://warehouse/paimon_jdbc'      -- bucket / datastore
  -- Alternative: 'warehouse' = 'hdfs://namenode:8020/paimon_jdbc'
  -- Alternative: 'warehouse' = 'file:///tmp/paimon_jdbc'

  -- Optional: Connection pool settings for better performance
  ,'jdbc.pool.enabled'          = 'true'
  ,'jdbc.pool.max-size'         = '10'
  ,'jdbc.pool.min-idle'         = '2'

  ,'s3.endpoint'                = 'http://minio:900'
  ,'s3.access-key-id'           = 'mnadmin'
  ,'s3.secret-access-key'       = 'mnpassword'
  ,'s3.path-style-access'       =' true'
  ,'table-default.file.format'  = 'parquet'
);

USE CATALOG c_paimon_jdbc;
CREATE DATABASE IF NOT EXISTS c_paimon_jdbc.finflow;


-- next execute 2.1

-- next execute 3.1