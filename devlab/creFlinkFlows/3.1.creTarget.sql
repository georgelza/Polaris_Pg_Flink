

-- Switch to the c_iceberg catalog
USE CATALOG c_iceberg;

-- Create database in current catalog
CREATE DATABASE IF NOT EXISTS finflow;

-- Use the database
USE finflow;

-- As we're executing the scripts from master.sql we've moved the below environment variables to there.

-- SET 'execution.checkpointing.interval'   = '60s';
-- SET 'table.exec.sink.upsert-materialize' = 'NONE';
SET 'execution.runtime-mode'            = 'streaming';
SET 'execution.checkpointing.interval'  = '60s';

SET 'pipeline.name' = 'Persist into Iceberg-Polars: accountholders table';

CREATE OR REPLACE TABLE c_iceberg.finflow.accountholders AS 
    SELECT * FROM c_cdcsource.demog.accountholders_iceberg;

-- or

-- CREATE OR REPLACE TABLE c_iceberg.finflow.accountholders WITH (
--      'file.format'                       = 'parquet'
--     ,'compaction.min.file-num'           = '2'
--     ,'compaction.early-max.file-num'     = '50'
--     ,'snapshot.time-retained'            = '1h'
--     ,'snapshot.num-retained.min'         = '5'
--     ,'snapshot.num-retained.max'         = '20'
--     ,'table.exec.sink.upsert-materialize'= 'NONE'
-- ) AS 
-- SELECT * FROM c_cdcsource.demog.accountholders_iceberg;


SET 'pipeline.name' = 'Persist into Iceberg-Polars: transactions table';

CREATE OR REPLACE TABLE c_iceberg.finflow.transactions AS 
    SELECT * FROM c_cdcsource.demog.transactions_iceberg;

-- or 

-- CREATE OR REPLACE TABLE c_iceberg.finflow.transactions WITH (
--      'file.format'                       = 'parquet'
--     ,'compaction.min.file-num'           = '2'
--     ,'compaction.early-max.file-num'     = '50'
--     ,'snapshot.time-retained'            = '1h'
--     ,'snapshot.num-retained.min'         = '5'
--     ,'snapshot.num-retained.max'         = '20'
--     ,'table.exec.sink.upsert-materialize'= 'NONE'
-- ) AS 
-- SELECT * FROM c_cdcsource.demog.transactions_iceberg;

