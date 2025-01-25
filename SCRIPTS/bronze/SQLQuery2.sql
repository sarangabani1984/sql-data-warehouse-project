-- Start a new batch for the CREATE PROCEDURE statement
GO

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
    DECLARE @Start_Time DATETIME, 
            @End_time DATETIME, 
            @batch_start_time DATETIME, 
            @batch_end_time DATETIME;

    BEGIN TRY
        SET @batch_start_time = GETDATE();
        PRINT '=======================================================';
        PRINT ' LOADING Bronze layer';
        PRINT '=======================================================';

        -- CRM Tables
        PRINT '-----------------------------------------------------';
        PRINT ' Loading CRM TABLE';
        PRINT '-----------------------------------------------------';
        
        -- Loading CRM Customer Info
        PRINT '>>>>>>>>>>>>>>>> Truncating Table: bronze.crm_cust_info <<<<<<<<<<<<<<<<<<';
        SET @Start_Time = GETDATE();
        TRUNCATE TABLE bronze.crm_cust_info; -- Truncate table and full load 

        PRINT '@@@@@@@@@@@@@@ Insert data INTO: bronze.crm_cust_info @@@@@@@@@@@@@@@@@@@@';
        BULK INSERT bronze.crm_cust_info
        FROM 'D:\\BARAA_SQL Project\\sql-data-warehouse-project\\datasets\\source_crm\\cust_info.CSV'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @End_time = GETDATE();
        PRINT '>>> Loaded duration for bronze.crm_cust_info: ' + CAST(DATEDIFF(SECOND, @Start_Time, @End_time) AS NVARCHAR) + ' seconds';

        -- Repeat for other CRM and ERP tables as shown in your script

        -- Final Batch Completion
        SET @batch_end_time = GETDATE();
        PRINT '=================================================================';
        PRINT ' Loading Bronze Layer is completed';
        PRINT ' - Total Load duration: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' SECONDS';
        PRINT ' ================================================================';

    END TRY
    BEGIN CATCH
        PRINT '=================================================================================';
        PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER';
        PRINT 'ERROR Message: ' + ERROR_MESSAGE();
        PRINT 'ERROR Number: ' + CAST(ERROR_NUMBER() AS NVARCHAR);
        PRINT 'ERROR State: ' + CAST(ERROR_STATE() AS NVARCHAR);
        PRINT '=================================================================================';
    END CATCH
END;

-- End the batch after the CREATE PROCEDURE statement
GO

-- Now you can execute the pr
