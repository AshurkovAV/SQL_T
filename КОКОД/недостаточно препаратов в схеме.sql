
SELECT t1.*, t2.etal_kol
FROM
(select shit,zslid,slid,ouid,t.code_sh,t.date_z_2,t.nhistory,t.rslt, SUM(CASE WHEN n021.ID_LEKP=n21.ID_LEKP THEN 1 ELSE 0 END) AS real_kol
FROM 
--sch.id,zs.ID, s.id,lek.regnum,SUMV,lek.REGNUM, lek.CODE_SH, lek.REGNUM, n021.ID_LEKP, n21.ID_LEKP, CASE WHEN n021.ID_LEKP=n21.ID_LEKP THEN 1 ELSE 0 END 
--,ksg.N_KSG,'' com --ѕлощадь поверхности тела расчитана неверно
(SELECT distinct sch.id AS shit,zs.ID AS zslid, zs.date_z_2,s.id AS slid, ou.ID AS ouid, lek.REGNUM, lek.code_sh, nhistory, zs.rslt
FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
  and sch.year=2024 and sch.[MONTH]=1-- and sch.id in (13879,13881)
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id    and zs.usl_ok in (1,2) --AND zs.id=20906231
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID   
 --join D3_KSG_KPG_OMS ksg on ksg.D3_SLID=s.id  --and ksg.N_KSG in (select id from @tt)
 join D3_ONK_SL_OMS onk on onk.D3_SLID=s.id
JOIN D3_ONK_USL_OMS AS ou ON ou.D3_ONKSLID=onk.ID AND ou.USL_TIP IN (2,4)
 JOIN D3_LEK_PR_OMS AS lek ON lek.D3_ONKUSLID=ou.ID
  ) t
  JOIN [N021] n021 ON n021.CODE_SH=t.CODE_SH AND n021.ID_LEKP=t.REGNUM  AND  n021.DATEEND IS null
  LEFT JOIN [N021] n21 ON n21.CODE_SH=t.CODE_SH  AND  n21.DATEEND IS null
GROUP BY shit,zslid,slid,ouid, t.code_sh,t.date_z_2,t.nhistory , t.rslt) t1
 JOIN 
(SELECT  CODE_SH, COUNT(id_LEKP) etal_kol
 FROM N021_1 n021
 WHERE  n021.DATEEND IS null
GROUP BY  CODE_SH
) T2 ON T1.code_sh=t2.CODE_SH
WHERE real_kol<>etal_kol


--select count(*) from n021 where    year(datebeg)=2024