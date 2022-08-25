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
sumv NUMERIC(15,2)
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
declare @sumv NUMERIC(15,2)


DECLARE vendor_cursor CURSOR FOR 

	select sl.id, zsl.id, pa.FAM, pa.IM, pa.OT, pa.DR, DS1, DATE_1, DATE_2, zsl.LPU, zsl.SUMV
	FROM D3_ZSL_OMS zsl
	join D3_SL_OMS sl on sl.d3_zslid=zsl.id
	join D3_PACIENT_OMS pa on pa.ID = zsl.D3_PID
	where sl.USL_OK in (1,2) and zsl.D3_SCID = 2071

OPEN vendor_cursor

FETCH NEXT FROM vendor_cursor INTO @id, @zid, @fam, @im, @ot, @dr, @ds, @date_1, @date_2, @lpu, @sumv;

WHILE @@FETCH_STATUS = 0
BEGIN

	IF(	select COUNT(*)
		FROM D3_ZSL zsl
		join D3_SL sl on sl.d3_zslid=zsl.id
		join D3_PACIENT pa on pa.ID = zsl.D3_PID
		left join D3_SANK s on sl.ID = s.D3_ZSLID
		where sl.id <> @id and  (s.S_TIP in (2,3) or s.S_TIP is null) and (s.S_OSN not like '4.6.1.*' or s.S_OSN is null)
			   and sl.USL_OK in (1,2) and FAM = @fam and IM = @im and OT = @ot and DR = @DR
			   and DATE_1 = @DATE_1 and DATE_2 = @DATE_2 and zsl.LPU = @lpu) > 0

	insert into @tt values (@id, @zid, @fam, @im, @ot, @dr, @ds, @date_1, @date_2, @lpu, @sumv)

	FETCH NEXT FROM vendor_cursor INTO @id, @zid, @fam, @im, @ot, @dr, @ds, @date_1, @date_2, @lpu, @sumv;
end;
CLOSE vendor_cursor;
DEALLOCATE vendor_cursor;
SELECT ZID, SUMV, '' com 
FROM @tt AS t
group by zid, SUMV