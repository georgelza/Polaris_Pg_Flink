
SET 'execution.checkpointing.interval'   = '60s';

SET 'table.exec.sink.upsert-materialize' = 'NONE';

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
SELECT * FROM c_cdcsource.demog.accountholders;

################################################################################################################################################

SET 'pipeline.name' = 'Persist into catalogxxx: accountholders table';

CREATE OR REPLACE TABLE catalogxxx.finflow.accountholders WITH (
     'file.format'                       = 'parquet'
    ,'compaction.min.file-num'           = '2'
    ,'compaction.early-max.file-num'     = '50'
    ,'snapshot.time-retained'            = '1h'
    ,'snapshot.num-retained.min'         = '5'
    ,'snapshot.num-retained.max'         = '20'
    ,'table.exec.sink.upsert-materialize'= 'NONE'
) AS 
SELECT * FROM c_cdcsource.demog.accountholders;

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
SELECT * FROM c_cdcsource.demog.transactions;


################################################################################################################################################


CREATE OR REPLACE TABLE c_iceberg.finflow.accountholders (
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
)
