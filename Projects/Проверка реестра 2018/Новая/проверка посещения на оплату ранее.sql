--проверка посещения на оплату ранее
DECLARE @p1 INT = 2155
declare @tt table 
(
id int,
zid int,
fam varchar(50),
im varchar(50),
ot varchar(50),
DR datetime,
DS varchar(50),
DATE_2 datetime,
lpu nvarchar(6),
profil int,
sumv NUMERIC(15,2),
dschet datetime
)

declare @id int
declare @zid int
declare @fam varchar(50)
declare @im varchar(50)
declare @ot varchar(50)
declare @DR datetime
declare @DS varchar(50)
declare @DATE_2 datetime
declare @lpu nvarchar(6)
declare @profil int
declare @sumv NUMERIC(15,2)
declare @dschet datetime


DECLARE vendor_cursor CURSOR FOR 

	select sl.id, zsl.id, pa.FAM, pa.IM, pa.OT, pa.DR, DS1, DATE_2, zsl.LPU, sl.profil, zsl.SUMV, sc.DSCHET
	FROM D3_ZSL_OMS zsl
	join D3_SL_OMS sl on sl.d3_zslid=zsl.id
	join D3_SCHET_OMS sc on sc.id=zsl.D3_SCID
	join D3_PACIENT_OMS pa on pa.ID = zsl.D3_PID
	where zsl.USL_OK=3 and OS_SLUCH_REGION is null and sl.PROFIL NOT IN (63,85,86,87,88,89,90) and zsl.D3_SCID = @p1 AND (zsl.PR_NOV IS NULL OR zsl.PR_NOV = 0)

OPEN vendor_cursor

FETCH NEXT FROM vendor_cursor INTO @id, @zid, @fam, @im, @ot, @dr, @ds, @date_2, @lpu, @profil, @sumv, @dschet;

WHILE @@FETCH_STATUS = 0
BEGIN

	IF(	select COUNT(*)
		FROM D3_ZSL_OMS zsl
		join D3_SL_OMS sl on sl.d3_zslid=zsl.id
		join D3_PACIENT_OMS pa on pa.ID = zsl.D3_PID
		join D3_SCHET_OMS sc on sc.id=zsl.D3_SCID
		left join D3_SANK_OMS s on sl.ID = s.D3_ZSLID
		where sl.id <> @id
				and  (mek_count is null or MEK_COUNT=0)		
				--and (s.S_TIP in (2,3) or s.S_TIP is null) 
				and OS_SLUCH_REGION is null and sl.PROFIL NOT IN (63,85,86,87,88,89,90) and zsl.USL_OK=3 
				and FAM = @fam and IM = @im and OT = @ot and DR = @DR
				and DATE_2 = @DATE_2 and zsl.LPU = @lpu and sl.PROFIL=@profil and DSCHET<@dschet) > 0

	insert into @tt values (@id, @zid, @fam, @im, @ot, @dr, @ds, @date_2, @lpu, @profil, @sumv, @dschet)

	FETCH NEXT FROM vendor_cursor INTO @id, @zid, @fam, @im, @ot, @dr, @ds, @date_2, @lpu, @profil, @sumv, @dschet;
end;
CLOSE vendor_cursor;
DEALLOCATE vendor_cursor;

if OBJECT_ID('ztemp_stac') is not null drop table ztemp_stac
SELECT dzo.id zsl_id, dso.ID sl_id, dpo.ID D3_PID
INTO ztemp_stac
FROM D3_ZSL_OMS AS dzo 
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
JOIN @tt t ON t.FAM = dpo.FAM AND t.IM = dpo.IM AND t.OT = dpo.OT AND t.DR = dpo.DR AND t.PROFIL = dso.PROFIL AND t.DATE_2 = dso.DATE_2 
WHERE dzo.id IN (
SELECT ZID 
FROM @tt AS t
group by zid, SUMV)


SELECT * FROM ztemp_stac
--SELECT 
--(SELECT ysme.NameWithID
--   FROM Yamed_Spr_MedicalEmployee AS ysme WHERE ysme.SNILS = dso.IDDOKT), dso.DATE_1, dso.DATE_1, ds1, dpo.FAM, dpo.IM, dpo.OT, dso.ID, dzo.ID 
--from D3_ZSL_OMS AS dzo
--JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
--JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
--WHERE dso.ID IN (SELECT sl_id from ztemp_stac)

---!!!!!!Удаляем только одно посещение, возможно в дальшейшем получаем расформированное обращение, но и пусть т.к. это косяк.!!!!!!!!!!

--DELETE FROM D3_SL_OMS
--WHERE ID IN (SELECT sl_id FROM ztemp_stac)











--DELETE FROM D3_ZSL_OMS
--WHERE ID IN (SELECT zsl_id FROM ztemp_stac)

--DELETE FROM D3_PACIENT_OMS
--WHERE ID IN (SELECT D3_PID FROM ztemp_stac)




--UPDATE dzo SET dzo.D3_SCID = 2139, dzo.EXP_COMENT = 'проверка посещения на оплату ранее'
--FROM D3_ZSL_OMS AS dzo 
--WHERE id IN (
--SELECT ZID 
--FROM @tt AS t
--group by zid, SUMV)