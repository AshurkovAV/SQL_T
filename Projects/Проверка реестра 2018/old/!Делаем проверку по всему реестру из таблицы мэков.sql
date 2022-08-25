DECLARE @p1 INT = 2077
DECLARE @MekName NVARCHAR(150)
DECLARE @MekSQL NVARCHAR(MAX)
DECLARE @tab TABLE (
id INT,
sumv DECIMAL(15,2),
mekName NVARCHAR(500)	
)
/*******************************************
 * Чистим старые мэк
 *******************************************/
SET @MekSql = 'UPDATE dz SET dz.FLK_COMENT = NULL
FROM D3_ZSL AS dz
WHERE dz.D3_SCID = @p1 AND dz.FLK_COMENT LIKE ''МЭК%''' + char(10)
SET @MekSql = REPLACE(@MekSql, '@p1', @p1)	
PRINT @MekSql;

/*******************************************
 * Проставляем значения в услуги по стоматологии
 *******************************************/
SET @MekSql =
'UPDATE  du SET 
PROFIL = CASE WHEN du.PROFIL IS NULL THEN ds.PROFIL ELSE du.PROFIL END,  
 DET = CASE WHEN du.DET IS NULL THEN ds.DET ELSE du.DET END,
 DATE_IN = CASE WHEN du.DATE_IN IS NULL THEN ds.DATE_1 ELSE du.DATE_IN END,
 DATE_OUT = CASE WHEN du.DATE_OUT IS NULL THEN ds.DATE_2 ELSE du.DATE_OUT END,
 DS = CASE WHEN du.DS IS NULL THEN ds.DS1 ELSE du.DS END,
 PRVS = CASE WHEN du.PRVS IS NULL THEN ds.PRVS ELSE du.PRVS END,
 CODE_MD = CASE WHEN du.CODE_MD IS NULL THEN ds.IDDOKT ELSE du.CODE_MD END 

FROM [D3_ZSL] zsl
LEFT JOIN D3_SL AS ds ON zsl.ID = ds.D3_ZSLID
INNER JOIN D3_USL AS du ON du.D3_SLID=ds.ID AND zsl.ID=du.D3_ZSLID
WHERE zsl.D3_SCID = @p1 AND ds.PROFIL IN (85,86,87,88,89,90)
 AND zsl.OS_SLUCH_REGION IS NULL
 AND zsl.IDSP IN (29,30,9) go'  + char(10)
SET @MekSql = REPLACE(@MekSql, '@p1', @p1)	
PRINT @MekSql;


SET @MekSql =
'UPDATE ds SET DET = CASE WHEN (v.PRNAME LIKE ''%ДЕТ%'' OR v.PRNAME = ''ортодонтии'' OR v.PRNAME = ''педиатрии'' OR v.PRNAME = ''неонатологии'' ) THEN 1 ELSE 0 END
FROM D3_ZSL AS dz
JOIN D3_SL AS ds ON dz.id = ds.D3_ZSLID
LEFT JOIN V002 AS v ON ds.PROFIL = v.Id
WHERE dz.D3_SCID = @p1 AND ds.DET IS NULL go'  + char(10)
SET @MekSql = REPLACE(@MekSql, '@p1', @p1)	
PRINT @MekSql;

SET @MekSql =
'UPDATE dz SET VIDPOM = 12
FROM D3_ZSL AS dz
JOIN D3_SL AS ds ON dz.id = ds.D3_ZSLID
WHERE dz.D3_SCID = @p1 AND ds.PROFIL = 97 AND dz.VIDPOM != 12 go'  + char(10)
SET @MekSql = REPLACE(@MekSql, '@p1', @p1)	
PRINT @MekSql;

SET @MekSql =
'
declare @tt table(
RN int null,
ID int null,
SUMV numeric(15,2),
fam varchar(100) null,
im varchar(100) null,
ot varchar(100) null,
dr datetime null,
helpend datetime null,
ReestrMedOrgID int null,
os int null
)

insert into @tt
SELECT ROW_NUMBER() OVER (PARTITION BY fam, im, ot, dr, OS_SLUCH_REGION, DATE_Z_1, DATE_Z_2
                                       ORDER BY fam, im, ot, dr, DATE_Z_2, OS_SLUCH_REGION) RN, zsl.ID, SUMV, fam, im, ot, dr, DATE_Z_2, zsl.d3_SCID, OS_SLUCH_REGION
		FROM D3_ZSL zsl
		JOIN PACIENT pa on zsl.D3_PID = pa.ID
		join SCHET sc on zsl.D3_SCID = sc.ID		
		where OS_SLUCH_REGION in (7,9,11,13,15,17,22) 
		and sc.[YEAR] = (select TOP 1 [YEAR] FROM SCHET where ID = @p1)

UPDATE D3_ZSL SET FLK_COMENT = ''МЭК - Дублирование медосмотров''
WHERE ID IN (Select ID
from @tt 
where RN > 1 and ReestrMedOrgID = @p1
GROUP BY ID, SUMV) go'  + char(10)
SET @MekSql = REPLACE(@MekSql, '@p1', @p1)	
PRINT @MekSql;

SET @MekSql =
'
declare @tt table(
RN int null,
ID int null,
SUMV numeric(15,2),
fam varchar(100) null,
im varchar(100) null,
ot varchar(100) null,
dr datetime null,
helpend datetime null,
ReestrMedOrgID int null,
os int null
)

insert into @tt
SELECT ROW_NUMBER() OVER (PARTITION BY fam, im, ot, dr, profil, OS_SLUCH_REGION
                                       ORDER BY fam, im, ot, dr, DATE_Z_2, OS_SLUCH_REGION) RN, zsl.ID, SUMV, fam, im, ot, dr, DATE_Z_2, zsl.d3_SCID, OS_SLUCH_REGION
FROM D3_ZSL zsl
join D3_SL sl on sl.d3_zslid=zsl.id
JOIN PACIENT pa on zsl.D3_PID = pa.ID
join SCHET sc on zsl.D3_SCID = sc.ID
where OS_SLUCH_REGION = 9 
	and sc.[YEAR] in ((select TOP 1 [YEAR] FROM SCHET where ID = @p1), (select TOP 1 [YEAR] FROM SCHET where ID = @p1) -1)

UPDATE D3_ZSL SET FLK_COMENT = ''МЭК - ПО оплачен ранее в течении двух лет.''
WHERE ID IN (Select ID 
from @tt 
where RN > 1 and ReestrMedOrgID = @p1
GROUP BY ID, SUMV) go'  + char(10)
SET @MekSql = REPLACE(@MekSql, '@p1', @p1)	
PRINT @MekSql;

SET @MekSql =
'
declare @tt table(
RN int null,
ID int null,
SUMV numeric(15,2),
fam varchar(100) null,
im varchar(100) null,
ot varchar(100) null,
dr datetime null,
helpend datetime null,
ReestrMedOrgID int null,
os int null
)

insert into @tt
SELECT ROW_NUMBER() OVER (PARTITION BY fam, im, ot, dr, profil, OS_SLUCH_REGION
                                       ORDER BY fam, im, ot, dr, DATE_Z_2, OS_SLUCH_REGION) RN, zsl.ID, SUMV, fam, im, ot, dr, DATE_Z_2, zsl.d3_SCID, OS_SLUCH_REGION
FROM D3_ZSL zsl
join D3_SL sl on sl.d3_zslid=zsl.id
JOIN PACIENT pa on zsl.D3_PID = pa.ID
join SCHET sc on zsl.D3_SCID = sc.ID
where OS_SLUCH_REGION in (7,15,17,22) and PROFIL in (97,68)
and sc.[YEAR] = (select TOP 1 [YEAR] FROM SCHET where ID = @p1)

UPDATE D3_ZSL SET FLK_COMENT = ''МЭК - Медосмотр оплачен ранее.''
WHERE ID IN (Select ID 
from @tt 
where RN > 1 and ReestrMedOrgID = @p1
GROUP BY ID, SUMV) go'  + char(10)
SET @MekSql = REPLACE(@MekSql, '@p1', @p1)	
PRINT @MekSql;

SET @MekSql =
'
declare @tt table(
RN int null,
ID int null,
SUMV numeric(15,2),
fam varchar(100) null,
im varchar(100) null,
ot varchar(100) null,
dr datetime null,
helpend datetime null,
ReestrMedOrgID int null,
os int null
)
insert into @tt
SELECT ROW_NUMBER() OVER (PARTITION BY fam, im, ot, dr, OS_SLUCH_REGION
ORDER BY fam, im, ot, dr, OS_SLUCH_REGION, DATE_2) RN, sl.ID, SUMV, fam, im, ot, dr, DATE_2, zsl.D3_SCID, OS_SLUCH_REGION
FROM D3_ZSL zsl
join D3_SL sl on sl.d3_zslid=zsl.id
JOIN PACIENT pa on zsl.D3_PID = pa.ID
join SCHET sc on zsl.D3_SCID = sc.ID
where OS_SLUCH_REGION = 4
		and sc.[YEAR] = (select TOP 1 [YEAR] FROM SCHET where ID = @p1)

UPDATE D3_ZSL SET FLK_COMENT = ''Повторное посещение центра здоровья''
WHERE ID IN (Select ID 
from @tt 
where RN > 1 and ReestrMedOrgID = @p1
group by id, SUMV) go'  + char(10)
SET @MekSql = REPLACE(@MekSql, '@p1', @p1)	
PRINT @MekSql;

DECLARE vendor_cursor CURSOR FOR 
	SELECT MekName, MekSQL FROM [Yamed_ExpSpr_MekAlg] m WHERE [MekSQLParametr] = 1
	
OPEN vendor_cursor

FETCH NEXT FROM vendor_cursor INTO @MekName, @MekSQL

WHILE @@FETCH_STATUS = 0
BEGIN	
	SET @MekSql = REPLACE(@MekSql, '@p1', @p1)	
	--SET @MekSql = REPLACE(@MekSql, ', zsl.SUMV, '''' com', '')
	--SET @MekSql = 'update D3_ZSL set flk_coment=''' + @MekName + ''' ' + char(10) + 'WHERE id IN (' + char(10) + @MekSql 
	--SET @MekSql = REPLACE(@MekSql, 'group by zsl.ID, zsl.SUMV', 'group by zsl.ID, zsl.SUMV)')
 	DECLARE @strInsert NVARCHAR(500) = 'DECLARE @tab TABLE (
id INT, sumv DECIMAL(15,2), mekName NVARCHAR(500) ) 
INSERT INTO @tab(id,sumv,mekName)' + char(10)
	DECLARE @query NVARCHAR(MAX) =  @strInsert + @MekSQL + char(10) + 
	'UPDATE D3_ZSL SET FLK_COMENT = ''' + 'МЭК -' + @MekName + '''' + char(10) +
     'WHERE ID IN (SELECT id FROM @tab) '+ char(10) + 'GO'+ char(10)
	PRINT @query
	--EXECUTE sp_executesql @query
	
	--SELECT * FROM  @tab
	FETCH NEXT FROM vendor_cursor INTO @MekName, @MekSQL;
END;
CLOSE vendor_cursor;
DEALLOCATE vendor_cursor;

SET @MekSql =
'
declare @tt table
(
id int,
zid int,
fam varchar(50),
im varchar(50),
ot varchar(50),
DR datetime,
DS varchar(50),
DATE_1 datetime,
DATE_2 datetime,
lpu nvarchar(6),
sumv numeric(15,2)
)

declare @id int
declare @zid int
declare @fam varchar(50)
declare @im varchar(50)
declare @ot varchar(50)
declare @DR datetime
declare @DS varchar(50)
declare @DATE_1 datetime
declare @DATE_2 datetime
declare @lpu nvarchar(6)
declare @sumv numeric(15,2)

DECLARE vendor_cursor CURSOR FOR 

	select sl.id, zsl.id, pa.FAM, pa.IM, pa.OT, pa.DR, DS1, DATE_1, DATE_2, zsl.LPU, zsl.SUMV
	FROM D3_ZSL zsl
	join D3_SL sl on sl.d3_zslid=zsl.id
	join PACIENT pa on pa.ID = zsl.D3_PID
	where sl.USL_OK = 3 and zsl.D3_SCID = @p1
			and (zsl.os_sluch_region<>6 or zsl.os_sluch_region is null)

OPEN vendor_cursor

FETCH NEXT FROM vendor_cursor INTO @id, @zid, @fam, @im, @ot, @dr, @ds, @date_1, @date_2, @lpu, @sumv;

WHILE @@FETCH_STATUS = 0
BEGIN

	IF(	select COUNT(*)
		FROM sluch zsl
		join PACIENT pa on pa.ID = zsl.PID
		left join D3_SANK_OMS s on zsl.ID = s.D3_ZSLID
		where (s.S_TIP in (2,3) or s.S_TIP is null) 
				and zsl.USL_OK = 1 and FAM = @fam and IM = @im and OT = @ot and DR = @DR  
            	  and DATE_1 < @DATE_2 and DATE_2 > @DATE_2) > 0

        insert into @tt values (@id, @zid, @fam, @im, @ot, @dr, @ds, @date_1, @date_2, @lpu, @sumv)


	FETCH NEXT FROM vendor_cursor INTO @id, @zid, @fam, @im, @ot, @dr, @ds, @date_1, @date_2, @lpu, @sumv;
end;
CLOSE vendor_cursor;
DEALLOCATE vendor_cursor;


UPDATE D3_ZSL SET FLK_COMENT = ''Перекрест поликлиника стационар''
WHERE ID IN (Select ID 
FROM @tt AS t
group by zid, SUMV)'  + char(10)
SET @MekSql = REPLACE(@MekSql, '@p1', @p1)	
PRINT @MekSql;