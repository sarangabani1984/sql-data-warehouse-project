
create or alter procedure bronze.bonze_load as 
begin
	DECLARE @START_TIME DATETIME, @END_TIME DATETIME, @TOTAL_START DATETIME, @TOTAL_END DATETIME;

	-- Capture total process start time
	SET @TOTAL_START = GETDATE();

	PRINT '-------------- LOADING CRM DATA --------------'

	-- Truncate and Load crm_cust_info
	PRINT '----------- Truncating and Loading crm_cust_info ----------'
	TRUNCATE TABLE bronze.crm_cust_info;
	SET @START_TIME = GETDATE();
	BULK INSERT bronze.crm_cust_info
	FROM 'D:\SQL\BARAA_SQL Project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
	WITH (
		FIRSTROW = 2,            
		FIELDTERMINATOR = ',',    
		ROWTERMINATOR = '\n',     
		ERRORFILE = 'D:\SQL\error_file.txt', 
		TABLOCK
	);
	SET @END_TIME = GETDATE();
	PRINT 'crm_cust_info data loaded successfully in ' + CAST(DATEDIFF(SECOND, @START_TIME, @END_TIME) AS VARCHAR) + ' seconds.'

	-- Truncate and Load crm_prd_info
	PRINT '----------- Truncating and Loading crm_prd_info ----------'
	TRUNCATE TABLE bronze.crm_prd_info;
	SET @START_TIME = GETDATE();
	BULK INSERT bronze.crm_prd_info
	FROM 'D:\SQL\BARAA_SQL Project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
	WITH (
		FIRSTROW = 2,             
		FIELDTERMINATOR = ',',    
		ROWTERMINATOR = '\n',     
		ERRORFILE = 'D:\SQL\error_file.txt', 
		TABLOCK
	);
	SET @END_TIME = GETDATE();
	PRINT 'crm_prd_info data loaded successfully in ' + CAST(DATEDIFF(SECOND, @START_TIME, @END_TIME) AS VARCHAR) + ' seconds.'

	-- Truncate and Load crm_sales_details
	PRINT '----------- Truncating and Loading crm_sales_details ----------'
	TRUNCATE TABLE bronze.crm_sales_details;
	SET @START_TIME = GETDATE();
	BULK INSERT bronze.crm_sales_details
	FROM 'D:\SQL\BARAA_SQL Project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
	WITH (
		FIRSTROW = 2,             
		FIELDTERMINATOR = ',',    
		ROWTERMINATOR = '\n',     
		ERRORFILE = 'D:\SQL\error_file.txt', 
		TABLOCK
	);
	SET @END_TIME = GETDATE();
	PRINT 'crm_sales_details data loaded successfully in ' + CAST(DATEDIFF(SECOND, @START_TIME, @END_TIME) AS VARCHAR) + ' seconds.'

	PRINT '-------------- LOADING ERP DATA --------------'

	-- Truncate and Load erp_cust_az12
	PRINT '----------- Truncating and Loading erp_cust_az12 ----------'
	TRUNCATE TABLE bronze.erp_cust_az12;
	SET @START_TIME = GETDATE();
	BULK INSERT bronze.erp_cust_az12
	FROM 'D:\SQL\BARAA_SQL Project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
	WITH (
		FIRSTROW = 2,             
		FIELDTERMINATOR = ',',    
		ROWTERMINATOR = '\n',     
		ERRORFILE = 'D:\SQL\error_file.txt', 
		TABLOCK
	);
	SET @END_TIME = GETDATE();
	PRINT 'erp_cust_az12 data loaded successfully in ' + CAST(DATEDIFF(SECOND, @START_TIME, @END_TIME) AS VARCHAR) + ' seconds.'

	-- Truncate and Load erp_loc_a101
	PRINT '----------- Truncating and Loading erp_loc_a101 ----------'
	TRUNCATE TABLE bronze.erp_loc_a101;
	SET @START_TIME = GETDATE();
	BULK INSERT bronze.erp_loc_a101
	FROM 'D:\SQL\BARAA_SQL Project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
	WITH (
		FIRSTROW = 2,             
		FIELDTERMINATOR = ',',    
		ROWTERMINATOR = '\n',     
		ERRORFILE = 'D:\SQL\error_file.txt', 
		TABLOCK
	);
	SET @END_TIME = GETDATE();
	PRINT 'erp_loc_a101 data loaded successfully in ' + CAST(DATEDIFF(SECOND, @START_TIME, @END_TIME) AS VARCHAR) + ' seconds.'

	-- Truncate and Load erp_px_cat_g1v2
	PRINT '----------- Truncating and Loading erp_px_cat_g1v2 ----------'
	TRUNCATE TABLE bronze.erp_px_cat_g1v2;
	SET @START_TIME = GETDATE();
	BULK INSERT bronze.erp_px_cat_g1v2
	FROM 'D:\SQL\BARAA_SQL Project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
	WITH (
		FIRSTROW = 2,             
		FIELDTERMINATOR = ',',    
		ROWTERMINATOR = '\n',     
		ERRORFILE = 'D:\SQL\error_file.txt', 
		TABLOCK
	);
end;
SET @END_TIME = GETDATE();
PRINT 'erp_px_cat_g1v2 data loaded successfully in ' + CAST(DATEDIFF(SECOND, @START_TIME, @END_TIME) AS VARCHAR) + ' seconds.'

-- Capture total process end time
SET @TOTAL_END = GETDATE();
PRINT '-------------- DATA LOADING PROCESS COMPLETED --------------'
PRINT 'Total data loading time: ' + CAST(DATEDIFF(SECOND, @TOTAL_START, @TOTAL_END) AS VARCHAR) + ' seconds.'
