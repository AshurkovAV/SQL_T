DECLARE @dbName NVARCHAR(950),@sql NVARCHAR(MAX),@sqlFunc NVARCHAR(MAX)
SET @sqlFunc = 'INSERT [dbo].[employees_slots] ([id], [resource_general_id], [slot_start_time], [slot_end_time], [slot_ordinal], [duration_min], [order_id], [customer_id], [iteration_nubmer], [active]) VALUES ('
DECLARE  @id [int]
DECLARE  @resource_general_id [int]
	DECLARE  @slot_start_time [datetime]
	DECLARE  @slot_end_time [datetime]
	DECLARE  @slot_ordinal [int]
	DECLARE  @duration_min [int]
	DECLARE  @order_id [int] 
	DECLARE  @customer_id [int] 
	DECLARE  @iteration_nubmer [int] 
	DECLARE @active [bit]

DECLARE @TAB TABLE
(
	script NVARCHAR(MAX) NULL	
)

DECLARE vendor_cursor CURSOR FOR 
	SELECT  [id]
      ,[resource_general_id]
      ,[slot_start_time]
      ,[slot_end_time]
      ,[slot_ordinal]
      ,[duration_min]
      ,[order_id]
      ,[customer_id]
      ,[iteration_nubmer]     
      ,[active]
FROM employees_slots AS es
OPEN vendor_cursor

FETCH NEXT FROM vendor_cursor INTO  @id, @resource_general_id, @slot_start_time, @slot_end_time, @slot_ordinal, @duration_min, @order_id, @customer_id, @iteration_nubmer, @active;
WHILE @@FETCH_STATUS = 0
BEGIN
	SELECT @sql = @sqlFunc + cast(@id AS NVARCHAR(20)) +',' + cast(@resource_general_id AS NVARCHAR(20)) + ','	+ CAST(N'2020-05-05 08:00:00.000' AS DateTime)
	INSERT INTO @TAB (script) SELECT @sql 	
	FETCH NEXT FROM vendor_cursor INTO  @id, @resource_general_id, @slot_start_time, @slot_end_time, @slot_ordinal, @duration_min, @order_id, @customer_id, @iteration_nubmer, @active;
END;
CLOSE vendor_cursor;
DEALLOCATE vendor_cursor

SELECT
	t.script
FROM
	@TAB AS t

