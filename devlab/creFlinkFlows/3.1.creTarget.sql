
SET 'execution.checkpointing.interval'   = '15s';

SET 'table.exec.sink.upsert-materialize' = 'NONE';

################################################################################################################################################

SET 'pipeline.name' = 'Persist into Iceberg: accountholders table';

CREATE OR REPLACE TABLE c_iceberg.finflow.accountholders WITH (
     'file.format'                       = 'parquet'
    ,'compaction.min.file-num'           = '2'
    ,'compaction.early-max.file-num'     = '50'
    ,'snapshot.time-retained'            = '1h'
    ,'snapshot.num-retained.min'         = '5'
    ,'snapshot.num-retained.max'         = '20'
    ,'table.exec.sink.upsert-materialize'= 'NONE'
) AS 
SELECT * FROM postgres_catalog.demog.accountholders;

################################################################################################################################################

SET 'pipeline.name' = 'Persist into Iceberg: transactions table';

CREATE OR REPLACE TABLE c_iceberg.finflow.transactions WITH (
     'file.format'                       = 'parquet'
    ,'compaction.min.file-num'           = '2'
    ,'compaction.early-max.file-num'     = '50'
    ,'snapshot.time-retained'            = '1h'
    ,'snapshot.num-retained.min'         = '5'
    ,'snapshot.num-retained.max'         = '20'
    ,'table.exec.sink.upsert-materialize'= 'NONE'
) AS 
SELECT * FROM postgres_catalog.demog.transactions;


################################################################################################################################################


SET 'pipeline.name' = 'Persist into Paimon: accountholders table';

CREATE OR REPLACE TABLE c_paimon.finflow.accountholders WITH (
     'file.format'                       = 'parquet'
    ,'compaction.min.file-num'           = '2'
    ,'compaction.early-max.file-num'     = '50'
    ,'snapshot.time-retained'            = '1h'
    ,'snapshot.num-retained.min'         = '5'
    ,'snapshot.num-retained.max'         = '20'
    ,'table.exec.sink.upsert-materialize'= 'NONE'
) AS 
SELECT * FROM postgres_catalog.demog.accountholders;

################################################################################################################################################

SET 'pipeline.name' = 'Persist into Paimon: transactions table';

CREATE OR REPLACE TABLE c_paimon.finflow.transactions WITH (
     'file.format'                       = 'parquet'
    ,'compaction.min.file-num'           = '2'
    ,'compaction.early-max.file-num'     = '50'
    ,'snapshot.time-retained'            = '1h'
    ,'snapshot.num-retained.min'         = '5'
    ,'snapshot.num-retained.max'         = '20'
    ,'table.exec.sink.upsert-materialize'= 'NONE'
) AS 
SELECT * FROM postgres_catalog.demog.transactions;

################################################################################################################################################





