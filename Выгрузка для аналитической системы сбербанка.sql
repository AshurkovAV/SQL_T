DECLARE @StartDate DATE, @EndDate DATE
SET @StartDate = '2021-12-23'
SET @EndDate = '2021-12-31';

WITH calendar AS(
     SELECT DATEADD(DAY,number,@StartDate) [Date]
     FROM master..spt_values
     WHERE type = 'P'
     AND DATEADD(DAY,number,@StartDate) <= @EndDate
)

SELECT c.date
FROM calendar AS c

------

DECLARE @dbName NVARCHAR(950),@sql NVARCHAR(MAX),@sqlFunc NVARCHAR(MAX)
SELECT  @sqlFunc = [sql] FROM emk.dbo.sql;

DECLARE @TAB2 TABLE
(
	script NVARCHAR(MAX) NULL	
)

DECLARE 
@date_start VARCHAR(8) = '20211202'

DECLARE vendor_cursor CURSOR FOR 
	SELECT [NameDb] FROM [SZV].[dbo].[Lpu] WHERE mcod IS NOT NULL AND NameDb != 'drakina'
OPEN vendor_cursor

FETCH NEXT FROM vendor_cursor INTO  @dbName;
WHILE @@FETCH_STATUS = 0
BEGIN
	SELECT @sql = 'use ' + @dbName + char(10) + 'GO' + char(10)	
   
    INSERT INTO @TAB2 (script) SELECT @sql + ' ' + @sqlFunc + + char(10) + 'GO' + char(10)					
	
	
	
	FETCH NEXT FROM vendor_cursor INTO @dbName;
END;
CLOSE vendor_cursor;
DEALLOCATE vendor_cursor

SELECT
	t.*
FROM
	@TAB2 AS t