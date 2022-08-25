--повторное посещение центра здоровья

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
FROM D3_ZSL_OMS zsl
join D3_SL_OMS sl on sl.d3_zslid=zsl.id
JOIN D3_PACIENT_OMS pa on zsl.D3_PID = pa.ID
join D3_SCHET_OMS sc on zsl.D3_SCID = sc.ID
--left join D3_SANK_OMS s on zsl.ID = s.D3_ZSLID
where OS_SLUCH_REGION = 4 --and (s.S_TIP in (2,3) or s.S_TIP is null)
    AND sc.ID = 2077
Select ID, SUMV,'' com
from @tt 
where RN > 1 and ReestrMedOrgID = 2077
group by id, SUMV