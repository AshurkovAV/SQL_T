
Select
distinct
 sch.NSchet as [Тип счета], zs.NPR_DATE, zs.NPR_MO, f003.nam_mok
,sch.month as [Месяц]
  ,sch.YEAR[Год]
  ,case when p.smo like '46%' then p.smo else '46' end as [Плательщик]   
 , p.SMO as [Страховая компания]
  , p.fam,p.im,isnull(p.ot,'') 
 ,p.W as [Пол]
  ,p.DR as [Дата рождения]
    , p.NPOLIS as [Полис]
  , p.SNILS as [Снилс]
  , zs.DATE_Z_1 [дата начала]
  , zs.DATE_Z_2 [дата окончания]
   , zs.VIDPOM as [Вид помощи]
  , zs.USL_OK as [Условия оказания мед. помощи],

 zs.DATE_Z_1 [дата начала]
  , zs.DATE_Z_2 [дата окончания],
  zs.id, zs.SUMV as [Стоимость оказанной мед. помощи]

 ,zs.PR_NOV [признак переподачи]

 , s.iddokt
 
 ,u.code_usl
 ,ms.name
 ,u.VID_VME
 , y.name

 

 
FROM [D3_SCHET_OMS] sch                  
 inner join D3_PACIENT_OMS p on p.d3_scid=sch.id
 inner join D3_ZSL_OMS zs on zs.D3_PID=p.id AND sch.code_mo=460061 
 --AND sch.month=11
 AND sch.YEAR=2024  
 and sch.id in (18444,18443,18452,18456)
  join D3_SL_OMS s on s.D3_ZSLID=zs.ID 
  JOIN D3_USL_OMS u ON u.D3_SLID=s.id


join V009 rz on rz.IDRMP=zs.RSLT
left join F011 doc on doc.Id=p.DOCTYPE
LEFT JOIN f003 ON f003.mcod=zs.NPR_MO
--WHERE iddokt is  NULL --AND sch.SchetType LIKE 'H'
--WHERE (ds1 NOT BETWEEN 'C00' AND 'D09.z') and ds1 NOT BETWEEN 'D45' AND 'D47.z'
left JOIN medicalServices AS ms ON ms.code_usl=u.CODE_USL  AND ms.code_usl='R01.001.006' AND YEAR(databegin)=2024
left join Yamed_Spr_UslCode y on y.ID=u.vid_vme	

WHERE u.code_usl='R01.001.006'



SELECT * FROM  medicalServices ms where ms.code_usl  BETWEEN 'R01.001.006' AND 'R01.001.006'