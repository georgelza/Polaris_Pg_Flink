
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
-- Create using below
CREATE DATABASE IF NOT EXISTS c_iceberg.finflow;

-- create using api, see polaris/README.md
CREATE DATABASE IF NOT EXISTS c_iceberg.fraud;

SHOW DATABASES;


-- next execute 2.1

-- next execute 3.1
