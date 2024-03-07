	DECLARE @dbName NVARCHAR(950), @sql NVARCHAR(MAX),@s NVARCHAR(300), @sqlFunc NVARCHAR(MAX),@return_status NVARCHAR(max);
	DECLARE @tt TABLE(galob NVARCHAR(150) )
	DECLARE @tab TABLE(script NVARCHAR(MAX) )

	DECLARE vendor_cursor CURSOR FOR 
		SELECT NAME FROM sys.databases WHERE NAME LIKE 'R_E%' OR NAME LIKE 'G_E%'
	OPEN vendor_cursor

	FETCH NEXT FROM vendor_cursor INTO  @dbName;
	WHILE @@FETCH_STATUS = 0
	BEGIN
		BEGIN TRY		
			SELECT @sql = 'use '+@dbName +'	
			go		
				insert into SZV.dbo.tab2 (db, doc, CREATE_DATE_TIME)  
				SELECT  DB_NAME() db,
					(SELECT m2.NOM + '' '' + m2.PRENOM
					   FROM MEDECINS AS m2 WHERE m2.MEDECINS_ID = m.MEDECINS_ID) doc, m.CREATE_DATE_TIME
					FROM MOTCONSU AS m
					WHERE m.CREATE_DATE_TIME BETWEEN ''20240228'' AND ''20240305''
			'
		print @sql	

		END TRY
		BEGIN CATCH
			PRINT 'Ошибка загрузки XML файла.';
		END CATCH
	
	FETCH NEXT FROM vendor_cursor INTO @dbName;
	END;
	CLOSE vendor_cursor;
	DEALLOCATE vendor_cursor;
