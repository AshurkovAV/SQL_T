
Select DISTINCT sch.NSCHET,p.smo,zs.id, zs.sumv,

   p.fam+' '+p.im+' '+isnull(p.ot,'') as [ФИО]
 ,p.W as [Пол]
  ,p.DR as [Дата рождения]
  
  , p.NPOLIS as [Полис]
 
  , zs.DATE_Z_1 [дата начала]
  , zs.DATE_Z_2 [дата окончания]
  
  , zs.USL_OK as [Условия оказания мед. помощи]

  
  ,zs.PR_NOV [признак переподачи]


, s.NHISTORY as [Номер истории]
  --, s.PODR as [Подразделение]
 , s.DS1 as [Диагноз в соответствии с МКБ-10]
, s.profil
, ms.name
FROM [D3_SCHET_OMS] sch                  
 inner join D3_PACIENT_OMS p on p.d3_scid=sch.id
 inner join D3_ZSL_OMS zs on zs.D3_PID=p.id AND sch.code_mo=460061  AND sch.id in (14950, 14951,14952)
--AND sch.ID IN (686, 688, 682)
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID   
 JOIN D3_USL_OMS u ON u.D3_SLID=s.id
 JOIN medicalServices AS ms ON ms.code_usl=u.CODE_USL AND u.DATE_IN >=ms.dataBegin AND u.DATE_OUT<=ISNULL(ms.dataEnd,'20991231')-- AND ms.code_usl  not BETWEEN 'R01.001.008' AND 'R01.001.036'

where dbo.[f_getage](p.dr, zs.date_z_1)<=17 and year(date_z_2)=2023 --AND isnull(zs.PR_NOV,0)=0 AND zs.idsp=28
