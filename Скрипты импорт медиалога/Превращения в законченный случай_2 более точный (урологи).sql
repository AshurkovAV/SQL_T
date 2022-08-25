DECLARE @D3_SCID INT = 3862
DROP TABLE ztemp_301
CREATE TABLE ztemp_301 (
	ZSLG_ID UNIQUEIDENTIFIER NOT NULL,
	zsl_id INT NOT NULL,
	sl_id INT NOT NULL,
	[NPOLIS] [nvarchar](20) NULL,
	[dr] [datetime] NULL,
	[ds1] [nvarchar](3) NULL,
	[PROFIL] [int] NULL,
	datez_1 DATETIME,
	datez_2 DATETIME)
	
DECLARE @ztemp_301_1 TABLE(
	ZSLG_ID UNIQUEIDENTIFIER NOT NULL,
	zsl_id INT NOT NULL,
	sl_id INT NOT NULL,
	[NPOLIS] [nvarchar](20) NULL,
	[dr] [datetime] NULL,
	[ds1] [nvarchar](3) NULL,
	[PROFIL] [int] NULL,
	datez_1 DATETIME,
	datez_2 DATETIME)
DECLARE @ztemp_301_2 TABLE(
	ZSLG_ID UNIQUEIDENTIFIER NOT NULL,
	zsl_id INT NOT NULL,
	sl_id INT NOT NULL,
	[NPOLIS] [nvarchar](20) NULL,
	[dr] [datetime] NULL,
	[ds1] [nvarchar](3) NULL,
	[PROFIL] [int] NULL,
	datez_1 DATETIME,
	datez_2 DATETIME)
	
DECLARE @ztemp_gl TABLE(
	ZSLG_ID UNIQUEIDENTIFIER  NULL,
	zsl_id INT NOT NULL,
	sl_id INT NOT NULL,		
	datez_1 DATETIME,
	datez_2 DATETIME,
	zsl_id29 INT NOT NULL,
	sl_id29 INT NOT NULL,		
	date_1 DATETIME,
	date_2 DATETIME)


INSERT INTO ztemp_301 (ZSLG_ID, zsl_id, sl_id, [NPOLIS],[dr],[ds1],[PROFIL], datez_1, datez_2)
SELECT ZSL_ID, zsl.id, sl.id, p.NPOLIS, dr, LEFT(ds1, 3)ds1, sl.PROFIL, zsl.DATE_Z_1, zsl.DATE_Z_2
FROM [D3_ZSL_OMS] zsl
JOIN [D3_SL_OMS] sl ON sl.d3_zslid = zsl.id
JOIN D3_pacient_OMS p ON d3_pid = p.id
WHERE zsl.id IN ( SELECT zsl.Id
					FROM[D3_ZSL_OMS] zsl
					JOIN [D3_SL_OMS] sl ON sl.d3_zslid = zsl.id AND sl.P_CEL25 = '1.0'
					JOIN D3_pacient_OMS p ON d3_pid = p.id
					WHERE zsl.D3_SCID = @D3_SCID AND OS_SLUCH_REGION IS NULL 
					--AND zsl.EXP_COMENT = 'МЭК -Посещение в обращении 5.1.4'
					--AND zsl.EXP_COMENT LIKE '%Посещения должны быть объеденены в обращения%'
					--AND sl.IDDOKT IN ('137-881-294 00', '034-574-091 51') --AND RSLT = 301  --AND sl.PROFIL NOT IN (63,85,86,87,88,89,90) 
					AND (zsl.PR_NOV IS NULL OR zsl.PR_NOV = 0)
					AND IDSP in (25,29) --AND zsl.ZSL_ID IN ('834672C3-86BB-44BF-A3CD-02447BAB9706','DDDCA872-5570-40A5-99CA-DE2E6B03611C', '14086D3B-1300-4B90-8201-FBBF6B28189B','688FCFB3-A9C9-44B5-9976-68D3B21308A1')
					GROUP BY zsl.id
					HAVING COUNT(*) = 1)
					
INSERT INTO @ztemp_301_1 (ZSLG_ID, zsl_id, sl_id, [NPOLIS],[dr],[ds1],[PROFIL], datez_1, datez_2)
SELECT *
FROM ztemp_301
WHERE zsl_id IN (
SELECT MAX(zsl_id)zsl_id
FROM ztemp_301	
GROUP BY NPOLIS, ds1, PROFIL
HAVING COUNT(*) = 1)

DELETE FROM ztemp_301 WHERE ZSLG_ID IN (SELECT ZSLG_ID FROM @ztemp_301_1)

DECLARE @ZSLG_ID UNIQUEIDENTIFIER, @ZSLG_ID_1 UNIQUEIDENTIFIER
DECLARE @zsl_id INT, @sl_id INT, @zsl_id_1 INT, @sl_id_1 INT,  @NPOLIS NVARCHAR(20), @NPOLIS_1 NVARCHAR(20), @dr DATETIME, @ds1 [nvarchar](3), @ds1_1 [nvarchar](3), @PROFIL [int], @PROFIL_1 [int]
DECLARE @datez_1 DATETIME, @datez_2 DATETIME,  @datez_1_1 DATETIME, @datez_2_1 DATETIME
SET @NPOLIS_1 = '';
DECLARE vendor_cursor CURSOR FOR 
	SELECT t.NPOLIS, t.dr, t.ds1, t.PROFIL
	FROM ztemp_301 AS t	
	GROUP BY t.NPOLIS, t.dr, t.ds1, t.PROFIL 	

OPEN vendor_cursor
FETCH NEXT FROM vendor_cursor INTO @NPOLIS,@dr,@ds1,@PROFIL
WHILE @@FETCH_STATUS = 0
BEGIN	
	INSERT INTO @ztemp_gl (ZSLG_ID,    zsl_id,   sl_id,    datez_1,     datez_2,    zsl_id29, sl_id29,  date_1,   date_2)
	EXEC p_join_visit @NPOLIS,@dr,@ds1,@PROFIL
	
	INSERT INTO @ztemp_301_2 (ZSLG_ID,zsl_id,sl_id,[NPOLIS],[dr],[ds1],[PROFIL],datez_1,datez_2)
	EXEC p_join_visit_1 @NPOLIS,@dr,@ds1,@PROFIL
	
	FETCH NEXT FROM vendor_cursor INTO @NPOLIS,@dr,@ds1,@PROFIL
END;
CLOSE vendor_cursor;
DEALLOCATE vendor_cursor;

--SELECT * FROM @ztemp_gl ORDER BY ZSLG_ID

DECLARE @zsl_id29 INT, @sl_id29 INT
DECLARE @date_1 DATETIME, @date_2 DATETIME 
DECLARE vendor_cursor1 CURSOR FOR 
	SELECT *
	FROM @ztemp_gl AS z	
	
	OPEN vendor_cursor1

FETCH NEXT FROM vendor_cursor1 INTO @ZSLG_ID, @zsl_id, @sl_id, @datez_1, @datez_2,  @zsl_id29, @sl_id29, @date_1, @date_2;

WHILE @@FETCH_STATUS = 0
BEGIN
	PRINT @ZSLG_ID
	DECLARE @date_z_1 DATETIME, @date_z_2 DATETIME
	UPDATE D3_SL_OMS SET D3_ZSLID = @zsl_id, P_CEL25 = '3.0' WHERE id = @sl_id29
	UPDATE D3_SL_OMS SET                     P_CEL25 = '3.0' WHERE id = @sl_id
	UPDATE D3_ZSL_OMS SET IDSP = 25 WHERE id = @zsl_id
	SELECT @date_z_1 = dz.DATE_Z_1, @date_z_2 = dz.DATE_Z_2 FROM D3_ZSL_OMS AS dz WHERE dz.ID = @zsl_id
	IF(@date_2 > @date_z_2)
	BEGIN
		UPDATE D3_ZSL_OMS SET DATE_Z_2 = @date_2 WHERE ID = @zsl_id
	END	
	IF(@date_1 < @date_z_1)
	BEGIN
		UPDATE D3_ZSL_OMS SET DATE_Z_1 = @date_1 WHERE ID = @zsl_id
	END	
	UPDATE D3_USL_OMS SET D3_ZSLID = @zsl_id WHERE D3_ZSLID = @zsl_id29
	DELETE FROM D3_ZSL_OMS WHERE ID = @zsl_id29
				
	FETCH NEXT FROM vendor_cursor1 INTO @ZSLG_ID, @zsl_id, @sl_id, @datez_1, @datez_2,  @zsl_id29, @sl_id29, @date_1, @date_2;
END;
CLOSE vendor_cursor1;
DEALLOCATE vendor_cursor1;