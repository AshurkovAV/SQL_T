--В ФИО есть символы отличные от букв
Select 
DISTINCT
 sch.id,
 sch.NSchet as [Тип счета], zs.NPR_DATE, zs.NPR_MO, f003.nam_mok
,sch.month as [Месяц]
,sch.YEAR[Год]
,case when p.smo like '46%' then p.smo else '46' end as [Плательщик]   
, p.SMO as [Страховая компания]
,p.VPOLIS, p.SPOLIS, p.NPOLIS, p.enp, p.SMO
,p.fam,p.im,isnull(p.ot,'') 
,p.W as [Пол]
       --,tmp1.enp, tmp1.smo, tmp1.[Отчество], tmp1.[Фамилия], tmp1.[Имя]
 ,p.DR as [Дата рождения]
 , p.NPOLIS as [Полис]
 , p.SNILS as [Снилс]
 , zs.DATE_Z_1 [дата начала]
 , zs.DATE_Z_2 [дата окончания]
 , zs.VIDPOM as [Вид помощи]
 , zs.USL_OK as [Условия оказания мед. помощи],

 p.fam,  zs.DATE_Z_1 [дата начала]
 , zs.DATE_Z_2 [дата окончания],
 zs.id, zs.SUMV as [Стоимость оказанной мед. помощи]
 ,zs.RSLT AS [Результат]
 ,zs.ISHOD
 ,s.iddokt, u.CODE_MD
 ,zs.ishod
 ,u.id
 ,u.code_usl
 ,u.VID_VME
 ,y.name

 ,zs.OPLATA, zs.SUMV, zs.SUMP
 ,p.DOCTYPE, p.DOCSER, p.DOCNUM, p.OKATOG, p.OKATOP, p.DOCDATE, p.DOCORG
 ,p.VPOLIS 
 ,p.ID
 ,zs.OS_SLUCH
 ,p.DOCTYPE, p.DOCSER, p.DOCNUM, p.DOCDATE, p.DOCORG
 
 --,zs.EXP_COMENT
 --,tmp1.enp, tmp1.smo, tmp1.[Отчество], tmp1.[Фамилия], tmp1.[Имя]
 --,tmp2.NPOLIS, tmp2.smo, tmp2.[Отчество], tmp2.Фамилия
--*/
FROM [D3_SCHET_OMS] sch                  
 inner join D3_PACIENT_OMS p on p.d3_scid=sch.id
 inner join D3_ZSL_OMS zs on zs.D3_PID=p.id AND sch.code_mo=460061 
											AND sch.YEAR=2023 
											and sch.id in (10759)
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID 
 JOIN D3_USL_OMS u ON u.D3_SLID=s.id
 join V009 rz on rz.IDRMP=zs.RSLT
 left join F011 doc on doc.Id=p.DOCTYPE
 LEFT JOIN f003 ON f003.mcod=zs.NPR_MO
 LEFT  JOIN medicalServices AS ms ON ms.code_usl=u.CODE_USL AND u.DATE_IN >=ms.dataBegin AND u.DATE_OUT<=ISNULL(ms.dataEnd,'20991231') AND ms.code_usl  BETWEEN 'R01.001.008' AND 'R01.001.036'
 left join Yamed_Spr_UslCode y on y.ID=u.vid_vme	

WHERE p.fam LIKE '%[^А-Яа-я]%'
  or p.im LIKE '%[^А-Яа-я]%'
  or p.ot LIKE '%[^А-Яа-я]%'
  OR p.im LIKE '%емое значение:%'