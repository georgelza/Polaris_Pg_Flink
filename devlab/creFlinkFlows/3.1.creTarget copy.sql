
SET 'execution.checkpointing.interval'   = '60s';

SET 'pipeline.name' = 'Persist into Iceberg-JDBC: accountholders table';

CREATE OR REPLACE TABLE c_iceberg_jdbc.finflow.accountholders AS 
    SELECT * FROM c_cdcsource.demog.accountholders;

