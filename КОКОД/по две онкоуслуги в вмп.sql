--BEGIN TRAN --commit tran
--DELETE  FROM OnkUsl1
SELECT --distinct onkusl1.USL_TIP, onkusl1.id
  DISTINCT zsl.id as ID, zsl.sumv as SUMV 
 ,sl.METOD_HMP,v019.HMNAME --вмп
  ,v23.NameWithID--ксг
 ,onkusl1.USL_TIP,onkusl2.USL_TIP
FROM [D3_SCHET_OMS] sch
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
    inner join D3_ZSL_OMS zsl on zsl.D3_PID=p.id and zsl.D3_SCID=sch.id
      inner join D3_SL_OMS sl on sl.D3_ZSLID=zsl.ID
        inner join D3_ONK_SL_OMS OnkSl on OnkSl.D3_SLID=sl.id 
          left join D3_ONK_USL_OMS OnkUsl1 on OnkUsl1.D3_ONKSLID=OnkSl.ID 
             inner join D3_ONK_USL_OMS OnkUsl2 on OnkUsl2.D3_ONKSLID=OnkSl.ID 
             left join V019 v019 on sl.METOD_HMP=v019.IDHM AND sl.DATE_2 BETWEEN v019.DATEBEG AND v019.DATEEND
left JOIN D3_KSG_KPG_OMS AS  ksg ON ksg.D3_SLID=sl.ID 
 --JOIN D3_CRIT_OMS AS cr ON cr.D3_KSGID=ksg.ID AND (cr.crit LIKE 'Sh%' or crit LIKE 'gem%')
 left JOIN v023 v23 ON v23.K_KSG=ksg.N_KSG AND year(v23.DATEBEG)>=2019 AND v23.DATEend IS NULL
where
  p.D3_SCID IN ( 3744,3755,3756)
  ----------------
  and onkusl1.ID<>onkusl2.id
 and onkusl1.USL_TIP<>onkusl2.USL_TIP
--AND sl.METOD_HMP NOT IN (1080,1081)
--AND onkusl1.USL_TIP IN (5,6)
----AND onkusl1.USL_TIP=5  -- удаляю неспецифическое лечение
--AND onkusl1.USL_TIP=6 --AND onkusl2.USL_TIP=1 -- удаляю неспецифическое лечение
------AND onkusl1.USL_TIP=2 --AND onkusl2.USL_TIP=1 -- удаляю неспецифическое лечение
--AND zsl.id IN (2616268,
--2616268,
--2620934,
--2620934,
--2625181,
--2625181,
--2631108,
--2631108


--)