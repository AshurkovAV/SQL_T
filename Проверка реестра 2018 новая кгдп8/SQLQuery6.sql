--проверка посещения на оплату ранее
DECLARE @p1 INT = 34
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
	where zsl.USL_OK=3 and OS_SLUCH_REGION is null and sl.PROFIL NOT IN (63,85,86,87,88,89,90) and zsl.D3_SCID = @p1

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

update zsl set EXP_COMENT = 'проверка посещения на оплату ранее'
from d3_zsl_oms zsl
where id in (SELECT ZID
	FROM @tt AS t
	group by zid, SUMV)