DECLARE @SchetID INT = 2092
declare @tt1 table(
rn int,
id int,
fam varchar(50),
im varchar(50),
ot varchar(50),
DR datetime,
NPOLIS varchar(20),
lpu nvarchar(6),
profil int, 
DS varchar(50),
DATE_1 datetime,
DATE_2 datetime)

declare @rn int
declare @id int
declare @fam varchar(50)
declare @im varchar(50)
declare @ot varchar(50)
declare @DR datetime
declare @NPOLIS varchar(20)
declare @lpu nvarchar(6)
declare @profil int
declare @DS varchar(50)
declare @DATE_1 datetime
declare @DATE_2 datetime


DECLARE vendor_cursor CURSOR FOR 
SELECT ROW_NUMBER() OVER (PARTITION BY zsl.id ORDER BY zsl.id) RN,
    zsl.id, pa.FAM, pa.IM, pa.OT, pa.DR, pa.NPOLIS, zsl.lpu, sl.PROFIL, sl.DS1, DATE_Z_1, DATE_Z_2
FROM D3_ZSL_OMS zsl
JOIN D3_SL_OMS sl ON sl.d3_zslid=zsl.id
JOIN D3_SCHET_OMS sc ON sc.id=zsl.D3_SCID
JOIN D3_PACIENT_OMS pa ON pa.ID = zsl.D3_PID
LEFT join D3_SANK_OMS sa ON zsl.ID = sa.D3_ZSLID AND sa.ID IS NULL
WHERE zsl.USL_OK = 3 AND zsl.OS_SLUCH_REGION IS NULL AND zsl.LPU <> 460061 
    AND sl.PROFIL NOT IN (63,85,86,87,88,89,90) AND P_CEL25='1.0'  
    AND sc.ID = @SchetID

OPEN vendor_cursor

FETCH NEXT FROM vendor_cursor INTO @rn, @id, @fam, @im, @ot, @dr, @npolis, @lpu, @profil, @ds, @date_1, @date_2;
WHILE @@FETCH_STATUS = 0
BEGIN

INSERT INTO @tt1
SELECT  1, zsl.id, pa.FAM, pa.IM, pa.OT, pa.DR, pa.NPOLIS, zsl.lpu, sl.PROFIL, sl.DS1, DATE_Z_1, DATE_Z_2
FROM D3_ZSL_OMS zsl
JOIN D3_SL_OMS sl ON sl.d3_zslid=zsl.id
JOIN D3_SCHET_OMS sc ON sc.id=zsl.D3_SCID
JOIN D3_PACIENT_OMS pa ON pa.ID = zsl.D3_PID
LEFT JOIN D3_SANK_OMS sa ON zsl.ID = sa.D3_ZSLID AND sa.ID IS NULL
WHERE zsl.USL_OK = 3 AND zsl.OS_SLUCH_REGION IS NULL
    AND ((FAM = @fam AND IM = @im AND OT = @ot AND DR = @DR) OR (NPOLIS = @NPOLIS))
    AND sl.PROFIL = @profil AND DS1 LIKE @DS AND P_CEL25 = '1.0' AND @rn=1
    AND @DATE_1-DATE_Z_2<=15 AND DATE_Z_2 < @DATE_2 AND zsl.id<>@id AND zsl.lpu=@lpu

IF (SELECT @@ROWCOUNT) > 0 
INSERT INTO @tt1 
VALUES (@rn, @id, @fam, @im, @ot, @dr, @NPOLIS, @lpu, @profil, @ds, @date_1, @date_2)

FETCH NEXT FROM vendor_cursor INTO @rn, @id, @fam, @im, @ot, @dr, @NPOLIS, @lpu, @profil, @ds, @date_1, @date_2;
--print @id
END;
CLOSE vendor_cursor;
DEALLOCATE vendor_cursor;

SELECT DISTINCT id, fam, im, ot, DR, NPOLIS, lpu, profil, DS, DATE_1, DATE_2
FROM @tt1
ORDER BY fam, im, ot, id