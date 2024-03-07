SELECT distinct sch.id AS shit,p.smo,zs.ID AS zslid,s.NHISTORY,s.kd, s.id AS slid, ou.ID AS ouid, lek.code_sh,v024.DKKNAME,  zs.DATE_Z_2, lek.REGNUM,n020.MNN, lek.DATE_INJ
FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
  and sch.year=2020
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id    and zs.usl_ok in (1,2) --AND zs.id=20906231
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID   
 --join D3_KSG_KPG_OMS ksg on ksg.D3_SLID=s.id  --and ksg.N_KSG in (select id from @tt)
 join D3_ONK_SL_OMS onk on onk.D3_SLID=s.id
JOIN D3_ONK_USL_OMS AS ou ON ou.D3_ONKSLID=onk.ID AND ou.USL_TIP IN (2,4)
 JOIN D3_LEK_PR_OMS AS lek ON lek.D3_ONKUSLID=ou.ID
 JOIN v024 ON v024.IDDKK=lek.CODE_SH
LEFT JOIN n020 ON n020.ID_LEKP=lek.REGNUM AND isnull(YEAR(n020.DATEEND),2020)=YEAR(zs.date_z_2)
 -- JOIN [N021] n021 ON n021.CODE_SH=t.CODE_SH AND n021.ID_LEKP=t.REGNUM AND isnull(YEAR(n021.DATEEND),2020)=YEAR(t.date_z_2)
 -- LEFT JOIN [N021] n21 ON n21.CODE_SH=t.CODE_SH AND isnull(YEAR(n21.DATEEND),2020)=YEAR(t.date_z_2)
WHERE  lek.code_sh in ( 'sh121',
'sh197',
'sh233',
'sh274',
'sh398',
'sh567')
