--BEGIN TRAN --commit tran
--DELETE  FROM cr
SELECT --distinct onkusl1.USL_TIP, onkusl1.id
  DISTINCT zsl.id as ID, zsl.sumv as SUMV 
  --sl.METOD_HMP,
  ,onkusl2.USL_TIP,crit
FROM [D3_SCHET_OMS] sch
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
    inner join D3_ZSL_OMS zsl on zsl.D3_PID=p.id and zsl.D3_SCID=sch.id
      inner join D3_SL_OMS sl on sl.D3_ZSLID=zsl.ID
        inner join D3_ONK_SL_OMS OnkSl on OnkSl.D3_SLID=sl.id 
          left join D3_ONK_USL_OMS OnkUsl on OnkUsl.D3_ONKSLID=OnkSl.ID AND onkusl.USL_TIP=2
             inner join D3_ONK_USL_OMS OnkUsl2 on OnkUsl2.D3_ONKSLID=OnkSl.ID 
 JOIN D3_KSG_KPG_OMS AS  ksg ON ksg.D3_SLID=sl.ID 
 JOIN D3_CRIT_OMS AS cr ON cr.D3_KSGID=ksg.ID AND (cr.crit LIKE 'Sh%' or crit LIKE 'gem%')
 left JOIN v023 v23 ON v23.K_KSG=ksg.N_KSG AND year(v23.DATEBEG)>=2019 AND v23.DATEend IS NULL
where
  p.D3_SCID = 2612
  ----------------
--AND onkusl.ID IS NULL 
--AND onkusl1.USL_TIP=5  -- удал€ю неспецифическое лечение
--AND onkusl1.USL_TIP=6 --AND onkusl2.USL_TIP=1 -- удал€ю неспецифическое лечение
