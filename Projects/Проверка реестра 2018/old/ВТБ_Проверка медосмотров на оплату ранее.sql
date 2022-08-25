---ѕроверка медосмотров на оплату ранее
declare @p1 int = 2071
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
join D3_SCHET sc on zsl.D3_SCID = sc.ID
--left join D3_SANK_OMS s on zsl.ID = s.D3_ZSLID
where OS_SLUCH_REGION in (7,11,13,15,17,22) 
--and (s.S_TIP in (2,3) or s.S_TIP is null) 
and PROFIL in (97,68)
and sc.[YEAR] = (select TOP 1 [YEAR] FROM D3_SCHET where ID = @p1)

Select ID, SUMV, '' com 
from @tt 
where RN > 1 and ReestrMedOrgID = @p1
GROUP BY ID, SUMV