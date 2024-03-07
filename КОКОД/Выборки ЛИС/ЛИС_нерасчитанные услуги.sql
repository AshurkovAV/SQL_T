SELECT t.VID_VME
 , t.name
 ,COUNT(*)
FROM
(
Select --sum(sumv)

--s.iddokt,u.CODE_MD
distinct
 sch.NSchet as [Тип счета], zs.NPR_DATE, zs.NPR_MO, f003.nam_mok
,sch.month as [Месяц]
  ,sch.YEAR[Год]
  ,case when p.smo like '46%' then p.smo else '46' end as [Плательщик]   
 , p.SMO as [Страховая компания]
  , p.fam,p.im,isnull(p.ot,'') ot
 ,p.W as [Пол]
  ,p.DR as [Дата рождения]

  , p.NPOLIS as [Полис]
  , p.SNILS as [Снилс]
  , zs.DATE_Z_1 [дата начала]
  , zs.DATE_Z_2 [дата окончания]
   , zs.VIDPOM as [Вид помощи]
  , zs.USL_OK as [Условия оказания мед. помощи]

  ,zs.id zslid, zs.SUMV as [Стоимость оказанной мед. помощи]
  ,zs.RSLT AS [Результат]
  , zs.ISHOD
 -- ,zs.PR_NOV [признак переподачи]

 , s.iddokt, u.CODE_MD

 , u.id
 ,u.code_usl
 ,ms.name [regname]
 ,u.VID_VME
 , y.name

  ,zs.OPLATA, zs.SUMV, zs.SUMP

 ,	replace(replace(zs.EXP_COMENT, CHAR(10), ''), CHAR(13), '') [комментарий мэк]

FROM [D3_SCHET_OMS] sch                  
 inner join D3_PACIENT_OMS p on p.d3_scid=sch.id
 inner join D3_ZSL_OMS zs on zs.D3_PID=p.id AND sch.code_mo=460061 
 --AND sch.month=5
 AND sch.YEAR=2022  
 and sch.id in (8967)
  join D3_SL_OMS s on s.D3_ZSLID=zs.ID 
  JOIN D3_USL_OMS u ON u.D3_SLID=s.id


join V009 rz on rz.IDRMP=zs.RSLT
left join F011 doc on doc.Id=p.DOCTYPE
LEFT JOIN f003 ON f003.mcod=zs.NPR_MO

--left JOIN medicalServices AS ms ON ms.code_usl=u.CODE_USL AND u.DATE_IN >=ms.dataBegin AND u.DATE_OUT<=ISNULL(ms.dataEnd,'20991231') AND ms.code_usl  BETWEEN 'R01.001.008' AND 'R01.001.036'
left JOIN medicalServices AS ms ON ms.code_usl=u.CODE_USL AND u.DATE_IN >=ms.dataBegin AND u.DATE_OUT<=ISNULL(ms.dataEnd,'20991231') AND ms.code_usl  BETWEEN 'R01.001.008' AND 'R01.001.036'
left join Yamed_Spr_UslCode y on y.ID=u.vid_vme	
WHERE sumv IS NULL
)t
GROUP BY t.VID_VME
 , t.name