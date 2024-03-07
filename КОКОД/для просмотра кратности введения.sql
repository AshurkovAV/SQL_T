--
SELECT distinct sch.id,
     zs.ID AS zsl,
     s.nhistory,--s.METOD_HMP,
     lek.CODE_SH,
     v024.DKKNAME,
     lek.REGNUM as Regnum,
     n020.MNN,
     onkusl.ID AS onkUslID, onkusl.usl_tip
     ,lek.DATE_INJ
  FROM [D3_SCHET_OMS] sch 
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
                 -- and SCH.id IN (472)
                  and sch.year=2021-- and sch.month=12
                 -- AND sch.id IN (751)
                  --AND ( p.SMO NOT LIKE '46%' OR p.smo IN (46006,46002,46007))
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id 
  join D3_SL_OMS s on s.D3_ZSLID=zs.ID
  join D3_ONK_SL_OMS OnkSl on OnkSl.D3_SLID=s.id                
  INNER join D3_ONK_USL_OMS OnkUsl on OnkUsl.D3_ONKSLID=OnkSl.ID 
  left JOIN D3_LEK_PR_OMS AS lek ON lek.D3_ONKUSLID= OnkUsl.id
  LEFT JOIN v024 ON v024.IDDKK=lek.CODE_SH AND v024.[DATEEND]	IS null	
  LEFT JOIN N020 ON n020.ID_LEKP=lek.REGNUM AND N020.[DATEEND]	IS null

WHERE lek.REGNUM IS not null and code_sh like 'sh%' and zs.vidpom=32--zs.date_z_2>'20201228'-- and zs.date_z_2>'20201210'--AND zs.date_z_2<='20201012'--and zs.id in (368954,368964)
ORDER BY zs.id