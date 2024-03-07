--аналитика услуг ЛИС
Select 
distinct
 f003.nam_mok
,sch.month as [Месяц]
  ,sch.YEAR[Год]
 ,u.code_usl
 ,ms.name
 ,u.VID_VME
 , y.name
 ,count(*) [количество],SUM(sumv) [сумма]

FROM [D3_SCHET_OMS] sch                  
 inner join D3_PACIENT_OMS p on p.d3_scid=sch.id
 inner join D3_ZSL_OMS zs on zs.D3_PID=p.id AND sch.code_mo=460061 
 AND sch.YEAR=2022  
 AND sch.[MONTH] IN (1, 2, 3, 4, 5, 6, 7, 8, 9)
  join D3_SL_OMS s on s.D3_ZSLID=zs.ID 
  JOIN D3_USL_OMS u ON u.D3_SLID=s.id


join V009 rz on rz.IDRMP=zs.RSLT
left join F011 doc on doc.Id=p.DOCTYPE
LEFT JOIN f003 ON f003.mcod=zs.NPR_MO
--WHERE iddokt is  NULL --AND sch.SchetType LIKE 'H'
--WHERE (ds1 NOT BETWEEN 'C00' AND 'D09.z') and ds1 NOT BETWEEN 'D45' AND 'D47.z'
left JOIN medicalServices AS ms ON ms.code_usl=u.CODE_USL AND u.DATE_IN >=ms.dataBegin AND u.DATE_OUT<=ISNULL(ms.dataEnd,'20991231') AND ms.code_usl  BETWEEN 'R01.001.008' AND 'R01.001.036'
left join Yamed_Spr_UslCode y on y.ID=u.vid_vme	

WHERE sch.id NOT IN (8578)  AND	sumv IS NOT null			--u.code_usl = 'R01.001.999' 

GROUP BY f003.nam_mok
		,sch.month 
  ,sch.YEAR
  ,u.code_usl
 ,ms.name
 ,u.VID_VME
 , y.name

 
--ORDER BY f003.nam_mok, sch.month 
  