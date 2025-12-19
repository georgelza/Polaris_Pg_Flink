

-- NOT WORKING
-- Execute script 1: Create Catalogs
-- SOURCE '/creFlinkFlows/1.1.creCat.sql';

-- Execute script 2: Create CDC Source Tables
-- SOURCE '/creFlinkFlows/2.1.creCdc.sql';

-- Execute script 3: Create our CATS create table / insert jobs
-- SOURCE '/creFlinkFlows/3.1.creTarget.sql';


-- Switch to the c_cdcsource catalog
USE CATALOG c_cdcsource;

-- Create database in current catalog
CREATE DATABASE IF NOT EXISTS demog;

USE demog;

CREATE OR REPLACE TABLE accountholders_iceberg (
     _id                BIGINT                  NOT NULL
    ,nationalid         VARCHAR(16)             NOT NULL
    ,firstname          VARCHAR(100)
    ,lastname           VARCHAR(100)
    ,dob                VARCHAR(10) 
    ,gender             VARCHAR(10)
    ,children           INT
    ,emailaddress       VARCHAR(100)
    ,mobilephonenumber  VARCHAR(20)
    ,accounts           STRING
    ,created_at         TIMESTAMP_LTZ(3)
    ,WATERMARK          FOR created_at AS created_at - INTERVAL '15' SECOND
    ,PRIMARY KEY (_id) NOT ENFORCED
) WITH (
     'connector'                           = 'postgres-cdc'
    ,'hostname'                            = 'postgrescdc'
    ,'port'                                = '5432'
    ,'username'                            = 'dbadmin'
    ,'password'                            = 'dbpassword'
    ,'database-name'                       = 'demog'
    ,'schema-name'                         = 'public'
    ,'table-name'                          = 'accountholders'
    ,'slot.name'                           = 'accountholders_iceberg'
    ,'scan.incremental.snapshot.enabled'   = 'true'               
    ,'scan.startup.mode'                   = 'initial'            
    ,'decoding.plugin.name'                = 'pgoutput'
);


CREATE OR REPLACE TABLE transactions_iceberg (
     _id                    BIGINT              NOT NULL
    ,eventid                VARCHAR(36)         NOT NULL
    ,transactionid          VARCHAR(36)         NOT NULL
    ,eventtime              VARCHAR(30)
    ,direction              VARCHAR(8)
    ,payernationalid        VARCHAR(16)
    ,payeraccount           STRING
    ,payeenationalid        VARCHAR(16)
    ,payeeaccount           STRING
    ,amount                 STRING
    ,created_at             TIMESTAMP_LTZ(3)
    ,WATERMARK              FOR created_at AS created_at - INTERVAL '15' SECOND
    ,PRIMARY KEY (_id) NOT ENFORCED
) WITH (
     'connector'                           = 'postgres-cdc'
    ,'hostname'                            = 'postgrescdc'
    ,'port'                                = '5432'
    ,'username'                            = 'dbadmin'
    ,'password'                            = 'dbpassword'
    ,'database-name'                       = 'demog'
    ,'schema-name'                         = 'public'
    ,'table-name'                          = 'transactions'
    ,'slot.name'                           = 'transactions_iceberg'
    ,'scan.incremental.snapshot.enabled'   = 'true'               
    ,'scan.startup.mode'                   = 'initial'            
    ,'decoding.plugin.name'                = 'pgoutput'
);


USE CATALOG c_iceberg;

-- Create database in current catalog
CREATE DATABASE IF NOT EXISTS finflow;

USE finflow;

SET 'execution.runtime-mode'            = 'streaming';
SET 'execution.checkpointing.interval'  = '60s';

SET 'pipeline.name' = 'Persist into Iceberg-Polars: accountholders table';

CREATE OR REPLACE TABLE c_iceberg.finflow.accountholders AS 
    SELECT * FROM c_cdcsource.demog.accountholders_iceberg;


SET 'pipeline.name' = 'Persist into Iceberg-Polars: transactions table';

CREATE OR REPLACE TABLE c_iceberg.finflow.transactions AS 
    SELECT * FROM c_cdcsource.demog.transactions_iceberg;


