
SELECT nam_mok,[Месяц забора материала],name, COUNT(*) [количество услуг]
FROM
(
Select --sum(sumv)

--s.iddokt,u.CODE_MD
distinct
 sch.NSchet as [Тип счета], zs.NPR_DATE, zs.NPR_MO, f003.nam_mok
,MONTH(zs.date_z_2) as [Месяц забора материала], sch.[MONTH][месяц подачи в тфомс]
 -- ,sch.YEAR[Год]
  ,case when p.smo like '46%' then p.smo else '46' end as [Плательщик]   
 , p.SMO as [Страховая компания]
  , p.fam,p.im,isnull(p.ot,'') ot
 ,p.W as [Пол]
  ,p.DR as [Дата рождения]
  -- , convert(nvarchar(150),(case when p.DOCTYPE=14  then 'Паспорт РФ'
  --when p.DOCTYPE=3 then 'Св-во о рождении'
  --else doc.DocName end)) + ' ' + convert(nvarchar,(p.DOCSER)) + ' ' + convert(nvarchar,(p.DOCNUM)) as [Данные документа удостоверяющего личность]
  , p.NPOLIS as [Полис]
  --, p.SNILS as [Снилс]
  , zs.DATE_Z_1 [дата начала]
  , zs.DATE_Z_2 [дата окончания]
 --  , zs.VIDPOM as [Вид помощи]
  --, zs.USL_OK as [Условия оказания мед. помощи],

 --p.fam,  zs.DATE_Z_1 [дата начала]
 -- , zs.DATE_Z_2 [дата окончания],
  ,zs.id-- zs.SUMV as [Стоимость оказанной мед. помощи]
  --,zs.RSLT AS [Результат]
 -- , zs.ISHOD
 -- ,zs.PR_NOV [признак переподачи]

-- , s.iddokt, u.CODE_MD
--,zs.ishod
-- , u.id
 ,u.code_usl
 ,ms.name
 ,u.VID_VME
 , y.name [fed_kod]

  ,zs.OPLATA, zs.SUMV--, zs.SUMP

 --,	replace(replace(zs.EXP_COMENT, CHAR(10), ''), CHAR(13), '') [комментарий мэк]

FROM [D3_SCHET_OMS] sch                  
 inner join D3_PACIENT_OMS p on p.d3_scid=sch.id
 inner join D3_ZSL_OMS zs on zs.D3_PID=p.id AND sch.code_mo=460061 
 --AND sch.month=5
 AND sch.YEAR=2022  
 --and sch.id in (4137,7074,7075,8235,8236,4357,5379,5380,5513,5596,5602,6855,6856)
  join D3_SL_OMS s on s.D3_ZSLID=zs.ID 
  JOIN D3_USL_OMS u ON u.D3_SLID=s.id


join V009 rz on rz.IDRMP=zs.RSLT
left join F011 doc on doc.Id=p.DOCTYPE
LEFT JOIN f003 ON f003.mcod=zs.NPR_MO
--WHERE iddokt is  NULL --AND sch.SchetType LIKE 'H'
--WHERE (ds1 NOT BETWEEN 'C00' AND 'D09.z') and ds1 NOT BETWEEN 'D45' AND 'D47.z'
 JOIN medicalServices AS ms ON ms.code_usl=u.CODE_USL AND u.DATE_IN >=ms.dataBegin AND u.DATE_OUT<=ISNULL(ms.dataEnd,'20991231') AND ms.code_usl  BETWEEN 'R01.001.008' AND 'R01.001.036'
left join Yamed_Spr_UslCode y on y.ID=u.vid_vme	
--CalcRegUslLis
--WHERE npr_date<>date_2
--WHERE zs.ISHOD<>304
--WHERE zs.ishod<>304 
------ms.ishod<> zs.ishod
--s.IDDOKT IS null
--WHERE p.npolis LIKE '4670050885000154
--WHERE zs.sumv IS NULL --AND u.VID_VME LIKE 'A26.19.011'

--ORDER BY p.npolis,vid_vme, date_in


--SELECT * from medicalServices
			--WHERE zs.EXP_COMENT IS NOT null
				--zs.EXP_COMENT LIKE '% В Федер. регистре COVID19 отсутствует соответствующая запись%'
				--
				--zs.EXP_COMENT LIKE '%Диагноз в услуге должен быть указан до подрубрики, если подрубрика предусмотрена МКБ-10%'
				--OR zs.EXP_COMENT LIKE '%МЭК - Недопустимое заполнение поля DS_ONK при основном диагнозе Z03.1%'
				--OR zs.EXP_COMENT LIKE '%Неуточнен код МКБ10 до четвертого знака в услуге %'*/
--WHERE isnull(sumv,0)=0
--WHERE zs.id=4739311
-- zs.EXP_COMENT LIKE '%номер полиса%' OR zs.EXP_COMENT LIKE '%ENP%' OR zs.EXP_COMENT LIKE '%vpolis%' OR zs.EXP_COMENT LIKE '%временный полис%'
----ds1 LIKE 'U07%'
--WHERE --oplata=2  
--zs.ishod<>304
--WHERE zs.EXP_COMENT like 'МЭК - Данные ЗЛ в СРЗ%'
--WHERE zs.EXP_COMENT LIKE '%code_md%'-- OR zs.EXP_COMENT LIKE '%ENP%' OR zs.EXP_COMENT LIKE '%vpolis%' OR zs.EXP_COMENT LIKE '%временный полис%' 
--ms.code_usl IS NULL --AND vid_vme LIKE 'A09.28.009%' 
--OR sumv IS NULL
--ORDER BY vid_vme
--zs.NPR_MO=460026
--u.CODE_MD IS null
WHERE sch.NSCHET NOT LIKE 'подано ранее' --AND MONTH(zs.DATE_Z_2)=8
--sch.id IN (4137,7074,7075,8235,8236,4357,5379,5380,5513,5596,5602,6855,6856)
AND zs.npr_mo in (460030,460023,460017,460055,460006,460066,460026,460013,460008,460036,460042)
) t
GROUP BY  nam_mok,[Месяц забора материала],NAME
ORDER BY nam_mok,[Месяц забора материала],NAME