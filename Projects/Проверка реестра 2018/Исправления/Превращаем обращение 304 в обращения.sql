DECLARE @D3_SCID INT = 2059

DECLARE @ztemp_301 TABLE(
	ZSLG_ID UNIQUEIDENTIFIER NOT NULL,
	zsl_id INT NOT NULL,
	sl_id INT NOT NULL,
	[NPOLIS] [nvarchar](20) NULL,
	[dr] [datetime] NULL,
	[ds1] [nvarchar](3) NULL,
	[PROFIL] [int] NULL,
	datez_1 DATETIME,
	datez_2 DATETIME
)
---Все у кого проставлено обращение и результат лечение завершено, но одно посящение внутри обращения и это косяк
INSERT INTO @ztemp_301 (ZSLG_ID, zsl_id, sl_id, [NPOLIS],[dr],[ds1],[PROFIL], datez_1, datez_2)
SELECT ZSL_ID, zsl.id, sl.id, p.NPOLIS, dr, LEFT(ds1, 3)ds1, sl.PROFIL, zsl.DATE_Z_1, zsl.DATE_Z_2
FROM [D3_ZSL] zsl
JOIN [D3_SL] sl ON sl.d3_zslid = zsl.id
JOIN pacient p ON d3_pid = p.id
WHERE zsl.id IN ( SELECT zsl.Id
					FROM[D3_ZSL] zsl
					JOIN [D3_SL] sl ON sl.d3_zslid = zsl.id AND sl.P_CEL = '3.0'
					JOIN pacient p ON d3_pid = p.id
					WHERE zsl.D3_SCID = @D3_SCID AND OS_SLUCH_REGION IS NULL AND RSLT = 304 AND sl.PROFIL NOT IN (85,86,87,88,89,90) 
					AND IDSP = 30
					GROUP BY zsl.id
					HAVING COUNT(*) = 1) --AND zsl.ZSL_ID = '8D8B5EE1-B5DB-4A2A-B49B-4BCA740C4CAE'

DECLARE @ztemp_gl TABLE(
	ZSLG_ID UNIQUEIDENTIFIER NOT NULL,
	zsl_id INT NOT NULL,
	sl_id INT NOT NULL,
	[NPOLIS] [nvarchar](20) NULL,
	[dr] [datetime] NULL,
	[ds1] [nvarchar](3) NULL,
	[PROFIL] [int] NULL,
	datez_1 DATETIME,
	datez_2 DATETIME
)

INSERT INTO @ztemp_gl (ZSLG_ID, zsl_id, sl_id, [NPOLIS],[dr],[ds1],[PROFIL], datez_1, datez_2)
SELECT *
FROM @ztemp_301 AS zg
WHERE zg.ZSLG_ID IN (
SELECT MAX(zg.ZSLG_ID )ZSLG_ID
FROM @ztemp_301 AS zg
GROUP BY zg.NPOLIS, zg.dr, zg.PROFIL, zg.ds1
HAVING COUNT (*) = 1 )

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
					WHERE zsl.D3_SCID = @D3_SCID AND OS_SLUCH_REGION IS NULL AND RSLT = 304 AND sl.PROFIL NOT IN (85,86,87,88,89,90) 
					AND IDSP = 29
					GROUP BY zsl.id
					HAVING COUNT(*) = 1)

--SELECT z.ZSLG_ID, z.zsl_id, z.sl_id, z.datez_1, z.datez_2, z2.zsl_id AS zsl_id29, z2.sl_id AS sl_id29, z2.date_1, z2.date_2
--	FROM @ztemp_gl AS z
--	JOIN @ztemp_2913 AS z2 ON z2.NPOLIS = z.NPOLIS AND z2.dr = z.dr AND z2.ds1 = z.ds1 AND z2.PROFIL = z.PROFIL AND z2.zsl_id != z.zsl_id
--	ORDER BY z.NPOLIS
	
	
DECLARE @zsl_id INT, @sl_id INT,  @zsl_id29 INT, @sl_id29 INT
DECLARE @datez_1 DATETIME, @datez_2 DATETIME, @date_1 DATETIME, @date_2 DATETIME 
DECLARE @ZSLG_ID UNIQUEIDENTIFIER
DECLARE vendor_cursor CURSOR FOR 
	SELECT z.ZSLG_ID, z.zsl_id, z.sl_id, z.datez_1, z.datez_2, z2.zsl_id AS zsl_id29, z2.sl_id AS sl_id29, z2.date_1, z2.date_2
	FROM @ztemp_gl AS z
	JOIN @ztemp_2913 AS z2 ON z2.NPOLIS = z.NPOLIS AND z2.dr = z.dr AND z2.ds1 = z.ds1 AND z2.PROFIL = z.PROFIL AND z2.zsl_id != z.zsl_id
	ORDER BY z.NPOLIS
	
	OPEN vendor_cursor

FETCH NEXT FROM vendor_cursor INTO @ZSLG_ID, @zsl_id, @sl_id, @datez_1, @datez_2,  @zsl_id29, @sl_id29, @date_1, @date_2;

WHILE @@FETCH_STATUS = 0
BEGIN
	--PRINT @ZSLG_ID
	DECLARE @date_z_1 DATETIME, @date_z_2 DATETIME
	UPDATE D3_SL SET D3_ZSLID = @zsl_id, P_CEL = '3.0' WHERE id = @sl_id29
	UPDATE D3_SL SET                     P_CEL = '3.0' WHERE id = @sl_id
	SELECT @date_z_1 = dz.DATE_Z_1, @date_z_2 = dz.DATE_Z_2 FROM D3_ZSL AS dz WHERE dz.ID = @zsl_id
	IF(@date_2 > @date_z_2)
	BEGIN
		UPDATE D3_ZSL SET DATE_Z_2 = @date_2 WHERE ID = @zsl_id
	END	
	IF(@date_1 < @date_z_1)
	BEGIN
		UPDATE D3_ZSL SET DATE_Z_1 = @date_1 WHERE ID = @zsl_id
	END	
	DELETE FROM D3_ZSL WHERE ID = @zsl_id29
				
	FETCH NEXT FROM vendor_cursor INTO @ZSLG_ID, @zsl_id, @sl_id, @datez_1, @datez_2,  @zsl_id29, @sl_id29, @date_1, @date_2;
END;
CLOSE vendor_cursor;
DEALLOCATE vendor_cursor;