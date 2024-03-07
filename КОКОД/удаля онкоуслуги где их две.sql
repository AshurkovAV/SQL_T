
BEGIN TRAN --commit tran
DELETE  FROM OnkUsl1
--SELECT --distinct onkusl1.USL_TIP, onkusl1.id
--  DISTINCT ds1_t,zsl.id as ID, zsl.sumv as SUMV 
--  --sl.METOD_HMP,
--  ,onkusl1.USL_TIP
-- -- ,onkusl2.USL_TIP
--  ,v23.NameWithID
FROM [D3_SCHET_OMS] sch
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
    inner join D3_ZSL_OMS zsl on zsl.D3_PID=p.id and zsl.D3_SCID=sch.id
      inner join D3_SL_OMS sl on sl.D3_ZSLID=zsl.ID
        inner join D3_ONK_SL_OMS OnkSl on OnkSl.D3_SLID=sl.id 
          LEFT  join D3_ONK_USL_OMS OnkUsl1 on OnkUsl1.D3_ONKSLID=OnkSl.ID 
            --  inner join D3_ONK_USL_OMS OnkUsl2 on OnkUsl2.D3_ONKSLID=OnkSl.ID 
 left JOIN D3_KSG_KPG_OMS AS  ksg ON ksg.D3_SLID=sl.ID 
 left JOIN v023 v23 ON v23.K_KSG=ksg.N_KSG AND year(v23.DATEBEG)>=2019 AND v23.DATEend IS NULL
where
  p.D3_SCID IN (3744,3755,3756)
  ----------------
--and onkusl1.ID<>onkusl2.id
--and onkusl1.USL_TIP<>onkusl2.USL_TIP
AND onkusl1.USL_TIP= 6 -- удал€ю неспецифическое лечение
--AND onkusl1.USL_TIP=6 --AND onkusl2.USL_TIP=1 -- удал€ю неспецифическое лечение
--AND onkusl1.USL_TIP=2 --AND onkusl2.USL_TIP=1 -- удал€ю неспецифическое лечение
AND zsl.id IN (3723292,
3723292,
3723295,
3723295,
3723295,
3723295,
3723295,
3723295,
3723345,
3723345,
3723350,
3723350,
3723387,
3723387,
3723387,
3723458,
3723458,
3723508,
3723508,
3736338,
3736338,
3736338,
3736493,
3736493,
3736501,
3736501,
3736501,
3737062,
3737062,
3738026,
3738026,
3739420,
3739420,
3739420,
3740637,
3740637)