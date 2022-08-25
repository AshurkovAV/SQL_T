DECLARE @p1 INT = 705
DECLARE @MekName NVARCHAR(150)
DECLARE @MekSQL NVARCHAR(MAX)
DECLARE @MekSQLParametr INT
DECLARE @tab TABLE (
id INT,
sumv DECIMAL(15,2),
mekName NVARCHAR(max),
[MekSQLParametr] INT
)
/*******************************************
 * Чистим старые мэк
 *******************************************/
SET @MekSql = 'UPDATE dz SET dz.EXP_COMENT = NULL
FROM D3_ZSL_oms AS dz
WHERE dz.D3_SCID = @p1 AND dz.EXP_COMENT LIKE ''МЭК%''' + char(10)
SET @MekSql = REPLACE(@MekSql, '@p1', @p1)	
PRINT @MekSql;

DECLARE vendor_cursor CURSOR FOR 
	SELECT algName, algSQL, Exptype FROM [Yamed_ExpSpr_SqlAlg] m WHERE m.ID NOT IN(396, 386)--m.ID = 184
	
OPEN vendor_cursor

FETCH NEXT FROM vendor_cursor INTO @MekName, @MekSQL, @MekSQLParametr

WHILE @@FETCH_STATUS = 0
BEGIN	
	SET @MekSql = REPLACE(@MekSql, '@p1', @p1)	
	DECLARE @strInsert NVARCHAR(500) = 'DECLARE @tab TABLE (
	id INT, sumv DECIMAL(15,2), mekName NVARCHAR(500) ) 
	INSERT INTO @tab(id,sumv,mekName)' + char(10)
	DECLARE @query NVARCHAR(MAX)
	IF @MekSQLParametr = 1
	BEGIN			
		SET @query =  @strInsert + @MekSQL + char(10) + 
		'UPDATE D3_ZSL_OMS SET EXP_COMENT = ''' + 'МЭК -' + @MekName + '''' + char(10) +
		 'WHERE ID IN (SELECT id FROM @tab) '+ char(10) + 'GO'+ char(10)
		PRINT @query
		--EXECUTE sp_executesql @query
	END
	IF @MekSQLParametr = 2
		BEGIN		
		IF(CHARINDEX('Select ID, SUMV, '''' com', @MekSQL, 0) > 0 )
		BEGIN
			SET @query =  REPLACE(@MekSQL, 'Select ID, SUMV, '''' com', @strInsert + 'Select ID, SUMV, '''' com') + char(10)+		 
		'UPDATE D3_ZSL_OMS SET EXP_COMENT = ''' + 'МЭК -' + @MekName + '''' + char(10) +
		 'WHERE ID IN (SELECT id FROM @tab) '+ char(10) + 'GO'+ char(10)			
		END
		IF(CHARINDEX('SELECT ZID, SUMV, '''' com', @MekSQL, 0) > 0 )
		BEGIN
		 SET @query =  REPLACE(@MekSQL, 'SELECT ZID, SUMV, '''' com', @strInsert + 'SELECT ZID, SUMV, '''' com') + char(10)+		 
		'UPDATE D3_ZSL_OMS SET EXP_COMENT = ''' + 'МЭК -' + @MekName + '''' + char(10) +
		 'WHERE ID IN (SELECT id FROM @tab) '+ char(10) + 'GO'+ char(10)
		END
		IF(CHARINDEX('Select distinct ID, SUMV,'''' com', @MekSQL, 0) > 0 )
		BEGIN
		  SET @query =  REPLACE(@MekSQL, 'Select distinct ID, SUMV,'''' com', @strInsert + 'Select distinct ID, SUMV,'''' com') + char(10)+		 
		'UPDATE D3_ZSL_OMS SET EXP_COMENT = ''' + 'МЭК -' + @MekName + '''' + char(10) +
		 'WHERE ID IN (SELECT id FROM @tab) '+ char(10) + 'GO'+ char(10)
		 END 
		 IF(CHARINDEX('select zs.id,sumv,'''' com', @MekSQL, 0) > 0 )
		BEGIN
		 SET @query =  REPLACE(@MekSQL, 'select zs.id,sumv,'''' com', @strInsert + 'select zs.id,sumv,'''' com') + char(10)+		 
		'UPDATE D3_ZSL_OMS SET EXP_COMENT = ''' + 'МЭК -' + @MekName + '''' + char(10) +
		 'WHERE ID IN (SELECT id FROM @tab) '+ char(10) + 'GO'+ char(10)
		END
		IF(CHARINDEX('select distinct zs.ID,SUMV,'''' com', @MekSQL, 0) > 0 )
		BEGIN
		  SET @query =  REPLACE(@MekSQL, 'select distinct zs.ID,SUMV,'''' com', @strInsert + 'select distinct zs.ID,SUMV,'''' com') + char(10)+		 
		'UPDATE D3_ZSL_OMS SET EXP_COMENT = ''' + 'МЭК -' + @MekName + '''' + char(10) +
		 'WHERE ID IN (SELECT id FROM @tab) '+ char(10) + 'GO'+ char(10)
		 END 
		 
		PRINT @query
		END
		IF @MekSQLParametr = 3
    BEGIN  
      SET @query =  @strInsert + char(10) + @MekSQL + char(10)+     
    'UPDATE D3_ZSL_OMS SET EXP_COMENT = ''' + 'МЭК -'' + t.mekName' + char(10) +
      'FROM D3_ZSL_OMS zsl
       JOIN @tab t ON zsl.id = t.id' + char(10) + 'GO'+ char(10)
     PRINT @query
    END
		
	----SELECT * FROM  @tab
	FETCH NEXT FROM vendor_cursor INTO @MekName, @MekSQL, @MekSQLParametr;
END;
CLOSE vendor_cursor;
DEALLOCATE vendor_cursor;

