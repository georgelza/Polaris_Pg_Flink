
USE CATALOG default_catalog;
  
-- Inbound from PostgreSQL via CDC Process
CREATE CATALOG c_cdcsource WITH 
    ('type'='generic_in_memory'); 


CREATE DATABASE IF NOT EXISTS c_cdcsource.demog;  


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
  ,'s3a.endpoint'              = 'http://minio:9000'
  ,'s3a.access-key-id'         = 'mnadmin'
  ,'s3a.secret-access-key'     = 'mnpassword'
  ,'s3a.path-style-access'     =' true'
  ,'table-default.file.format' = 'parquet'
);

USE CATALOG c_iceberg_jdbc;
CREATE DATABASE IF NOT EXISTS c_iceberg_jdbc.finflow;
SHOW DATABASES;