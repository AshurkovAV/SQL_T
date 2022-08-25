DECLARE @p1 INT = 2061

SELECT *
FROM
(select sl.id, pa.FAM, pa.IM, pa.OT, pa.DR, DS1, DATE_1, DATE_2, sl.LPU, sl.SUMV
            from SLUCH sl
            join PACIENT pa on sl.PID = pa.ID
            join SCHET sc on sl.SCHET_ID = sc.ID
            left join SANK sa on sl.ID = sa.SLID and sa.ID is NULL
            where sl.USL_OK = 3 and sl.SCHET_ID = @p1) AS t_pol
INNER JOIN             
(SELECT sl.id, pa.FAM, pa.IM, pa.OT, pa.DR, DS1, DATE_1, DATE_2, sl.LPU, sl.SUMV 
from SLUCH sl
join PACIENT pa on sl.PID = pa.ID 
left join SANK sa on sl.ID = sa.SLID
where (sa.S_TIP in (2) or sa.S_TIP is null) and sl.USL_OK = 1 ) AS t_stac ON
t_pol.id <> t_stac.id AND t_pol.FAM = t_stac.fam and t_pol.IM = t_stac.im and t_pol.OT = t_stac.ot and t_pol.DR = t_stac.DR
and CAST(t_pol.DATE_1 AS DATE) < CAST(t_stac.DATE_2  AS DATE) and CAST(t_pol.DATE_2  AS DATE) > CAST(t_stac.DATE_2  AS DATE)