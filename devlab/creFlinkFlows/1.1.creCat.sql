
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
   'type'='iceberg'
  ,'catalog-type'='rest'
  ,'uri'='http://polaris:8181/api/catalog'
  ,'warehouse'='icebergcat'
  ,'oauth2-server-uri'='http://polaris:8181/api/catalog/v1/oauth/tokens'
  ,'credential'='root:s3cr3t'
  ,'scope'='PRINCIPAL_ROLE:ALL'
  ,'s3.endpoint'='http://minio:900'
  ,'s3.access-key-id'='mnadmin'
  ,'s3.secret-access-key'='mnpassword'
  ,'s3.path-style-access'='true'
);

USE CATALOG c_iceberg;
CREATE DATABASE IF NOT EXISTS c_iceberg.finflow;
CREATE DATABASE IF NOT EXISTS c_iceberg.fraud;
SHOW DATABASES;

CREATE CATALOG catalogxxx WITH (
   'type'='iceberg'
  ,'catalog-type'='rest'
  ,'uri'='http://polaris:8181/api/catalog'
  ,'warehouse'='catalogxxx'
  ,'oauth2-server-uri'='http://polaris:8181/api/catalog/v1/oauth/tokens'
  ,'credential'='root:s3cr3t'
  ,'scope'='PRINCIPAL_ROLE:ALL'
  ,'s3.endpoint'='http://minio:900'
  ,'s3.access-key-id'='mnadmin'
  ,'s3.secret-access-key'='mnpassword'
  ,'s3.path-style-access'='true'
);

USE CATALOG catalogxxx;
CREATE DATABASE IF NOT EXISTS catalogxxx.finflow;


-- Paimon based Catalog stored inside PostgreSQL database using JDBC interface
-------------------------------------------------------------------------------------------------------------------------
-- server: postgrescat
-- db: flink_catalog
-- schema: paimon_catalog
CREATE CATALOG c_paimon WITH (
     'type'                          = 'paimon'
    ,'metastore'                     = 'jdbc'                       -- JDBC Based Catalog
    ,'catalog-key'                   = 'jdbc'
    ,'uri'                           = 'jdbc:postgresql://postgrescat:5432/flink_catalog?currentSchema=paimon_catalog'
    ,'jdbc.user'                     = 'dbadmin'
    ,'jdbc.password'                 = 'dbpassword'
    ,'jdbc.driver'                   = 'org.postgresql.Driver'
    ,'warehouse'                     = 's3://warehouse/paimon'      -- bucket / datastore
    ,'s3.endpoint'                   = 'http://minio:9000'          -- MinIO endpoint
    ,'s3.path-style-access'          = 'true'                       -- Required for MinIO
    ,'table-default.file.format'     = 'parquet'
);

USE CATALOG c_paimon;
CREATE DATABASE IF NOT EXISTS c_paimon.finflow;

-- next execute 2.1

-- next execute 3.1