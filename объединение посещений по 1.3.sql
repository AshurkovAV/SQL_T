DROP TABLE ztemp_13
CREATE TABLE ztemp_13 (
	ZSLG_ID UNIQUEIDENTIFIER NOT NULL,
	zsl_id INT NOT NULL,
	sl_id INT NOT NULL,
	[NPOLIS] [nvarchar](20) NULL,
	[dr] [datetime] NULL,
	[ds1] [nvarchar](5) NULL,
	[PROFIL] [int] NULL,
	datez_1 DATETIME,
	datez_2 DATETIME)
DECLARE @p INT = 23402

DECLARE @zsl_id_1 INT, @sl_id_1 INT,  @NPOLIS NVARCHAR(20), @NPOLIS_1 NVARCHAR(20), @dr DATETIME, @ds1 [nvarchar](5), @ds1_1 [nvarchar](3), @PROFIL [int], @PROFIL_1 [int]

DECLARE @fam NVARCHAR(50), @im NVARCHAR(50), @ot NVARCHAR(50)
DECLARE @datez_1 DATETIME, @datez_2 DATETIME,  @datez_1_1 DATETIME, @datez_2_1 DATETIME

DECLARE vendor_cursor CURSOR FOR 
	SELECT dpo.FAM, dpo.IM, dpo.OT, dpo.DR, dso.DS1, dpo.NPOLIS, dso.PROFIL
		FROM D3_PACIENT_OMS AS dpo
		JOIN D3_ZSL_OMS AS dzo ON dzo.D3_PID = dpo.ID
		JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
	WHERE dzo.D3_SCID = @p AND dso.P_CEL = '1.3' 
	AND (dzo.PR_NOV = 0 OR dzo.PR_NOV IS NULL)
	GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, dso.DS1, dpo.NPOLIS, dso.PROFIL
    HAVING COUNT(*) > 1	

OPEN vendor_cursor
FETCH NEXT FROM vendor_cursor INTO @fam, @im, @ot, @dr, @ds1, @NPOLIS, @PROFIL
WHILE @@FETCH_STATUS = 0
BEGIN	
		DECLARE @slidg NVARCHAR (36), @zsl_id INT, @sl_id INT
		
		SELECT TOP 1 @sl_id = dso.ID, @zsl_id = dzo.ID, @slidg = dso.SL_ID
		FROM D3_ZSL_OMS AS dzo
		JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
		JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
		WHERE dpo.FAM = @fam AND dpo.IM = @im AND dpo.OT = @ot AND dpo.DR = @dr 
		AND dpo.NPOLIS = @NPOLIS 
		AND dso.DS1 =  @ds1
		AND dso.PROFIL = @PROFIL
		AND dzo.D3_SCID = @p
		AND dso.P_CEL25 = '1.3'
		AND (dzo.PR_NOV = 0 OR dzo.PR_NOV IS NULL)
		ORDER BY  [NPOLIS], dso.DATE_1 
		
		--PRINT @zsl_id
		UPDATE duo SET D3_SLID = @sl_id, D3_ZSLID = @zsl_id, D3_SLGID = @slidg 
		FROM D3_ZSL_OMS AS dzo
		JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
		JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
		JOIN D3_USL_OMS AS duo ON duo.D3_SLID = dso.ID
		WHERE dpo.FAM = @fam AND dpo.IM = @im AND dpo.OT = @ot AND dpo.DR = @dr 
		AND dpo.NPOLIS = @NPOLIS 
		AND dso.DS1 =  @ds1
		AND dso.PROFIL = @PROFIL
		AND dzo.D3_SCID = @p
		AND dso.P_CEL25 = '1.3'
		AND (dzo.PR_NOV = 0 OR dzo.PR_NOV IS NULL)
	
	FETCH NEXT FROM vendor_cursor INTO @fam, @im, @ot, @dr, @ds1, @NPOLIS, @PROFIL
END;
CLOSE vendor_cursor;
DEALLOCATE vendor_cursor;


DROP TABLE ztemp_du2
SELECT dzo.ID zslid, dso.ID slid, MIN(duo.DATE_IN)DATE_IN, MAX(duo.DATE_OUT)DATE_OUT
INTO ztemp_du2
FROM D3_ZSL_OMS AS dzo
	JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
		JOIN D3_USL_OMS AS duo ON duo.D3_SLID = dso.ID
WHERE dzo.D3_SCID = 23402
AND dzo.EXP_COMENT LIKE '%Значение поля ZL_LIST/ZAP/Z_SL/SL/USL/DATE_OUT не должно быть больше DATE_2%'
GROUP BY dzo.ID, dso.ID



UPDATE dzo SET dzo.DATE_Z_1 = DATE_IN, dzo.DATE_Z_2 = DATE_OUT, EXP_COMENT = NULL
FROM D3_ZSL_OMS AS dzo
	JOIN ztemp_du2 t ON dzo.ID = zslid
	
UPDATE dso SET dso.DATE_1 = DATE_IN, dso.DATE_2 = DATE_OUT
FROM D3_SL_OMS AS dso
	JOIN ztemp_du2 t ON dso.ID = slid
	
	UPDATE dzo SET  EXP_COMENT = NULL
FROM D3_ZSL_OMS AS dzo
	JOIN ztemp_du2 t ON dzo.ID = zslid
	



--SELECT *
--FROM ztemp_13
--ORDER BY zsl_id