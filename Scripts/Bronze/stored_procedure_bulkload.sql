-------This script works as a stored procedure to load the data from csv files to their respective tables in SQL--------
-------The script firstly empties the table using the TRUCATE command and the load the data using the bulk load command that is acting as a refresh command--------
-------To run this stored procedure USE the Command - EXEC bronze.load_bronze;-------


CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
 TRUNCATE TABLE bronze.crm_cust_info;
 BULK INSERT bronze.crm_cust_info
 FROM 'D:\Desktop\SQL Project - Data Warehouse\datasets\source_crm\cust_info.csv'
 WITH (
    FIRSTROW = 2, ----since the first row has headers
    FIELDTERMINATOR = ',', 
    TABLOCK
 ); 
 
 TRUNCATE TABLE bronze.crm_prod_info;
 BULK INSERT bronze.crm_prod_info
 FROM 'D:\Desktop\SQL Project - Data Warehouse\datasets\source_crm\prd_info.csv'
 WITH (
    FIRSTROW = 2, ----since the first row has headers
    FIELDTERMINATOR = ',', 
    TABLOCK
  );

----ALTER TABLE bronze.crm_sales_details     ----since I used INT DATATYPE for the first column but it contains alphabets also so changed 
----ALTER COLUMN sls_ord_num NVARCHAR (50);  ---- the datatype with ALTER COMMAND

 TRUNCATE TABLE bronze.crm_sales_details;
 BULK INSERT bronze.crm_sales_details
 FROM 'D:\Desktop\SQL Project - Data Warehouse\datasets\source_crm\sales_details.csv'
 WITH (
    FIRSTROW = 2, ----since the first row has headers
    FIELDTERMINATOR = ',', 
    TABLOCK
 );

--------Below is the BULK INSERT FOR the TABLES from ERP
 TRUNCATE TABLE bronze.erp_cust_az12;
 BULK INSERT bronze.erp_cust_az12
 FROM 'D:\Desktop\SQL Project - Data Warehouse\datasets\source_erp\CUST_AZ12.csv'
 WITH (
    FIRSTROW = 2, 
    FIELDTERMINATOR = ',', 
    TABLOCK
 );  -----while leading this table i faced a problem of DATA format, if the date format in CSV is anything other than YYYY-MM-DD 
    -----then SQL will reject it.

 TRUNCATE TABLE bronze.erp_loc_a101;
 BULK INSERT bronze.erp_loc_a101
 FROM 'D:\Desktop\SQL Project - Data Warehouse\datasets\source_erp\LOC_A101.csv'
 WITH (
    FIRSTROW = 2, 
    FIELDTERMINATOR = ',', 
    TABLOCK
 );
 
 TRUNCATE TABLE bronze.erp_px_cat_g1v2;
 BULK INSERT bronze.erp_px_cat_g1v2
 FROM 'D:\Desktop\SQL Project - Data Warehouse\datasets\source_erp\PX_CAT_G1V2.csv'
 WITH (
    FIRSTROW = 2, 
    FIELDTERMINATOR = ',', 
    TABLOCK
 );
 END
