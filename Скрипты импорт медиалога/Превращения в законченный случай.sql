DECLARE @D3_SCID INT = 2060

DECLARE @ztemp_301 TABLE(
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

---Все у кого проставлено обращение и результат лечение завершено, но одно посящение внутри обращения и это косяк
INSERT INTO @ztemp_301 (ZSLG_ID, zsl_id, sl_id, [NPOLIS],[dr],[ds1],[PROFIL], datez_1, datez_2)
SELECT ZSL_ID, zsl.id, sl.id, p.NPOLIS, dr, LEFT(ds1, 3)ds1, sl.PROFIL, zsl.DATE_Z_1, zsl.DATE_Z_2
FROM [D3_ZSL] zsl
JOIN [D3_SL] sl ON sl.d3_zslid = zsl.id
JOIN pacient p ON d3_pid = p.id
WHERE zsl.id IN ( SELECT zsl.Id
					FROM[D3_ZSL] zsl
					JOIN [D3_SL] sl ON sl.d3_zslid = zsl.id AND sl.P_CEL = '1.3'
					JOIN pacient p ON d3_pid = p.id
					WHERE zsl.D3_SCID = @D3_SCID AND OS_SLUCH_REGION IS NULL AND RSLT = 301 AND sl.DET = 1  --AND sl.PROFIL NOT IN (63,85,86,87,88,89,90) 
					AND IDSP = 29
					GROUP BY zsl.id
					HAVING COUNT(*) = 1) --AND zsl.id IN (23327,23330,23332,23328,23329,23331) --AND zsl.ZSL_ID = '3493724D-9BDE-4343-8B92-ABAAFF985F3D'

INSERT INTO @ztemp_301_1 (ZSLG_ID, zsl_id, sl_id, [NPOLIS],[dr],[ds1],[PROFIL], datez_1, datez_2)
SELECT *
FROM @ztemp_301
WHERE zsl_id IN (
SELECT MAX(zsl_id)zsl_id
FROM @ztemp_301	
GROUP BY NPOLIS, ds1, PROFIL
HAVING COUNT(*) = 1)

--INSERT INTO @ztemp_301_2 (ZSLG_ID, zsl_id, sl_id, [NPOLIS],[dr],[ds1],[PROFIL], datez_1, datez_2)
--SELECT t.*
--FROM @ztemp_301 AS t
--WHERE t.ZSLG_ID NOT IN (SELECT ZSLG_ID FROM @ztemp_301_1)
--ORDER BY t.NPOLIS, t.dr, t.datez_1

DECLARE @ZSLG_ID UNIQUEIDENTIFIER, @ZSLG_ID_1 UNIQUEIDENTIFIER
DECLARE @zsl_id INT, @sl_id INT, @zsl_id_1 INT, @sl_id_1 INT,  @NPOLIS NVARCHAR(20), @NPOLIS_1 NVARCHAR(20), @dr DATETIME, @ds1 [nvarchar](3) ,@PROFIL [int] 
DECLARE @datez_1 DATETIME, @datez_2 DATETIME,  @datez_1_1 DATETIME, @datez_2_1 DATETIME
SET @NPOLIS_1 = '';
DECLARE vendor_cursor CURSOR FOR 
	SELECT t.*
	FROM @ztemp_301 AS t
	WHERE t.ZSLG_ID NOT IN (SELECT ZSLG_ID FROM @ztemp_301_1)
	ORDER BY t.NPOLIS, t.dr, t.datez_1
	
	OPEN vendor_cursor

FETCH NEXT FROM vendor_cursor INTO @ZSLG_ID, @zsl_id, @sl_id, @NPOLIS,@dr,@ds1,@PROFIL, @datez_1, @datez_2

WHILE @@FETCH_STATUS = 0
BEGIN
	--PRINT @NPOLIS + ' ' + @NPOLIS_1
	IF(@NPOLIS_1 <> @NPOLIS)
	BEGIN
		SET @NPOLIS_1 = @NPOLIS
		SET @zsl_id_1 = @zsl_id
		SET @sl_id_1 = @sl_id	
		SET @ZSLG_ID_1 = @ZSLG_ID	
		SET @datez_1_1 = @datez_1
		SET @datez_2_1 = @datez_2
		INSERT INTO @ztemp_301_2 (  ZSLG_ID,  zsl_id,    sl_id,    NPOLIS,  dr,  ds1,  PROFIL,  datez_1, datez_2 ) 
						   VALUES(@ZSLG_ID_1, @zsl_id_1, @sl_id_1, @NPOLIS_1, @dr, @ds1, @PROFIL, @datez_1_1, @datez_2_1)
		--PRINT ' != ' --+ @ZSLG_ID
	END
	ELSE
	BEGIN
		--PRINT ' = ' --+ @ZSLG_ID
			INSERT INTO @ztemp_gl (ZSLG_ID,    zsl_id,   sl_id,    datez_1,     datez_2, zsl_id29, sl_id29,  date_1,  date_2)
						   VALUES(@ZSLG_ID_1, @zsl_id_1, @sl_id_1, @datez_1_1, @datez_2_1, @zsl_id, @sl_id, @datez_1, @datez_2)
		END
	
	
	FETCH NEXT FROM vendor_cursor INTO @ZSLG_ID, @zsl_id, @sl_id, @NPOLIS,@dr,@ds1,@PROFIL, @datez_1, @datez_2;
END;
CLOSE vendor_cursor;
DEALLOCATE vendor_cursor;

		
DECLARE @ztemp_2913 TABLE(
	zsl_id INT NOT NULL,
	sl_id INT NOT NULL,
	[NPOLIS] [nvarchar](20) NULL,
	[dr] [datetime] NULL,
	[ds1] [nvarchar](3) NULL,
	[PROFIL] [int] NULL,
	date_1 DATETIME,
	date_2 DATETIME
)

INSERT INTO @ztemp_2913(zsl_id, sl_id, [NPOLIS],[dr],[ds1],[PROFIL],date_1, date_2)
SELECT zsl.id, sl.id, p.NPOLIS, dr, LEFT(ds1, 3)ds1, sl.PROFIL, zsl.DATE_Z_1, zsl.DATE_Z_2
FROM [D3_ZSL] zsl
JOIN [D3_SL] sl ON sl.d3_zslid = zsl.id
JOIN pacient p ON d3_pid = p.id
WHERE zsl.id IN ( SELECT zsl.Id
					FROM[D3_ZSL] zsl
					JOIN [D3_SL] sl ON sl.d3_zslid = zsl.id AND sl.P_CEL = '1.3'
					JOIN pacient p ON d3_pid = p.id
					WHERE zsl.D3_SCID = @D3_SCID AND OS_SLUCH_REGION IS NULL AND RSLT != 301 AND sl.DET = 1 --AND sl.PROFIL NOT IN (63,85,86,87,88,89,90) 
					AND IDSP = 29
					GROUP BY zsl.id
					HAVING COUNT(*) = 1)

INSERT INTO @ztemp_gl (ZSLG_ID,    zsl_id,   sl_id,    datez_1,     datez_2, zsl_id29, sl_id29,  date_1,  date_2)
SELECT z.ZSLG_ID, z.zsl_id, z.sl_id, z.datez_1, z.datez_2, z2.zsl_id AS zsl_id29, z2.sl_id AS sl_id29, z2.date_1, z2.date_2
	FROM @ztemp_301_2 AS z
	JOIN @ztemp_2913 AS z2 ON z2.NPOLIS = z.NPOLIS AND z2.dr = z.dr AND z2.ds1 = z.ds1 AND z2.PROFIL = z.PROFIL AND z2.zsl_id != z.zsl_id
	ORDER BY z.NPOLIS

INSERT INTO @ztemp_gl (ZSLG_ID,    zsl_id,   sl_id,    datez_1,     datez_2, zsl_id29, sl_id29,  date_1,  date_2)
SELECT z.ZSLG_ID, z.zsl_id, z.sl_id, z.datez_1, z.datez_2, z2.zsl_id AS zsl_id29, z2.sl_id AS sl_id29, z2.date_1, z2.date_2
	FROM @ztemp_301_1 AS z
	JOIN @ztemp_2913 AS z2 ON z2.NPOLIS = z.NPOLIS AND z2.dr = z.dr AND z2.ds1 = z.ds1 AND z2.PROFIL = z.PROFIL AND z2.zsl_id != z.zsl_id
	ORDER BY z.NPOLIS
	
SELECT * FROM @ztemp_gl


--DECLARE @zsl_id29 INT, @sl_id29 INT
--DECLARE @date_1 DATETIME, @date_2 DATETIME 
--DECLARE vendor_cursor1 CURSOR FOR 
--	SELECT *
--	FROM @ztemp_gl AS z	
	
--	OPEN vendor_cursor1

--FETCH NEXT FROM vendor_cursor1 INTO @ZSLG_ID, @zsl_id, @sl_id, @datez_1, @datez_2,  @zsl_id29, @sl_id29, @date_1, @date_2;

--WHILE @@FETCH_STATUS = 0
--BEGIN
--	--PRINT @ZSLG_ID
--	DECLARE @date_z_1 DATETIME, @date_z_2 DATETIME
--	UPDATE D3_SL SET D3_ZSLID = @zsl_id, P_CEL = '3.0' WHERE id = @sl_id29
--	UPDATE D3_SL SET                     P_CEL = '3.0' WHERE id = @sl_id
--	UPDATE D3_ZSL SET IDSP = 30 WHERE id = @zsl_id
--	SELECT @date_z_1 = dz.DATE_Z_1, @date_z_2 = dz.DATE_Z_2 FROM D3_ZSL AS dz WHERE dz.ID = @zsl_id
--	IF(@date_2 > @date_z_2)
--	BEGIN
--		UPDATE D3_ZSL SET DATE_Z_2 = @date_2 WHERE ID = @zsl_id
--	END	
--	IF(@date_1 < @date_z_1)
--	BEGIN
--		UPDATE D3_ZSL SET DATE_Z_1 = @date_1 WHERE ID = @zsl_id
--	END	
--	UPDATE D3_USL SET D3_ZSLID = @zsl_id WHERE D3_ZSLID = @zsl_id29
--	DELETE FROM D3_ZSL WHERE ID = @zsl_id29
				
--	FETCH NEXT FROM vendor_cursor1 INTO @ZSLG_ID, @zsl_id, @sl_id, @datez_1, @datez_2,  @zsl_id29, @sl_id29, @date_1, @date_2;
--END;
--CLOSE vendor_cursor1;
--DEALLOCATE vendor_cursor1;