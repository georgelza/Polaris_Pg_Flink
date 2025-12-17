
## Table/Objects Structures

### 1.1.creCat.sql

Will create the various catalogs and databases.

 - `c_cdcsource` - Generic In Memory

   - demog

 - `c_iceberg` - Apache Polaris REST based

   - finflow

   - fraud


### 2.1.creCdc.sql

This will create our 2 transciant CDC based tables (`demog` database with `c_cdcsource` as catalog) which will connect to our PostgreSQL datastore and expose data using the Flink CDC capabilities.

 - `accountholders`

 - `transactions` 


### 3.2.creTarget.sql

Create our 2 Iceberg tables in our `finflow` database in our `c_iceberg` catalog, managed using Apache Polaris


