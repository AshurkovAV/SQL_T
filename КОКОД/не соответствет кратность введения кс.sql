--select * from SCHEME_KS
--where ksg like 'st19.062'
SELECT v.*, CASE WHEN  code_sh_gr IN ('sh0121'
,'sh0209'
,'sh0398'
,'sh0557'
,'sh0615'
,'sh0620'
,'sh0670'
,'sh0717'
,'sh0770'
,'sh0779'
,'sh0780'
,'sh0868'
,'sh0906'
,'sh0998'
,'sh1044'
) THEN 'смотри предыдущие госпитализации' END pr
FROM
(
select t.*,spr.code_sh code_sh_gr,spr.quantity
from
(
select distinct sch.id AS shit,zs.ID AS zslid, s.id AS slid, ou.ID AS ouid,ksg.N_KSG,lek.code_sh,date_z_2, s.NHISTORy, COUNT(DISTINCT lek.DATE_INJ) AS kol_vved

--sch.id,zs.ID, s.id,lek.regnum,SUMV,lek.REGNUM, lek.CODE_SH, lek.REGNUM, n021.ID_LEKP, n21.ID_LEKP, CASE WHEN n021.ID_LEKP=n21.ID_LEKP THEN 1 ELSE 0 END 
--,ksg.N_KSG,'' com --Площадь поверхности тела расчитана неверно
--(SELECT distinct sch.id AS shit,zs.ID AS zslid, s.id AS slid, ou.ID AS ouid, lek.REGNUM, lek.code_sh
FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
  and sch.year=2024 and sch.month=1-- and sch.id in (11787,11789)
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id    and zs.usl_ok in (1) --AND zs.id=20906231
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID   
 left join D3_KSG_KPG_OMS ksg on ksg.D3_SLID=s.id  --and ksg.N_KSG in (select id from @tt)
 join D3_ONK_SL_OMS onk on onk.D3_SLID=s.id
 JOIN D3_ONK_USL_OMS AS ou ON ou.D3_ONKSLID=onk.ID AND ou.USL_TIP IN (2,4)
 JOIN D3_LEK_PR_OMS AS lek ON lek.D3_ONKUSLID=ou.ID
 --where date_z_2>'20210425'

 GROUP BY sch.id,zs.ID, s.id,ou.ID,ksg.N_KSG,lek.code_sh,date_z_2, s.NHISTORy
 ) t
 LEFT JOIN SCHEME_KS_2024 spr on spr.ksg=t.n_ksg and spr.code_sh=t.code_sh
 where kol_vved<>quantity
) v


--SELECT * FROM SCHEME_KS_2023
