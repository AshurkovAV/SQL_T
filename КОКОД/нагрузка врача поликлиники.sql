
Select 
 f003.nam_mok [наименование МО]
 ,YEAR(zs.DATE_Z_2)[Год оказания]
,month(zs.DATE_Z_2) as [Месяц оказания]
, v002.NameWithID [профиль врачи]
 , s.IDDOKT [снилс врача]
  ,COUNT(DISTINCT zs.id) as [количество зак случаев, поданных на оплату]
  ,COUNT(distinct p.NPOLIS) as [количество пациентов]


FROM [D3_SCHET_OMS] sch                  
 inner join D3_PACIENT_OMS p on p.d3_scid=sch.id
 inner join D3_ZSL_OMS zs on zs.D3_PID=p.id --AND sch.code_mo=460061 
 --AND sch.month=3

 
  join D3_SL_OMS s on s.D3_ZSLID=zs.ID 
  LEFT JOIN f003 ON f003.mcod=sch.CODE_MO
  LEFT JOIN v002 ON v002.IDPr=s.PROFIL

--CalcRegUslLis
WHERE   YEAR(zs.DATE_Z_2) BETWEEN 2021 AND 2022 
AND zs.usl_ok=3
AND ISNULL(zs.PR_NOV,0)=0
AND (code_mo=460061 OR (code_mo NOT LIKE '460061' AND s.profil IN (60)))
AND idsp<>28
GROUP BY  f003.nam_mok 
 ,YEAR(zs.DATE_Z_2)
,month(zs.DATE_Z_2)
, v002.NameWithID
 , s.IDDOKT 