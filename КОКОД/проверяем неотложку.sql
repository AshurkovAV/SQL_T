Select --sum(sumv)

--s.iddokt,u.CODE_MD
distinct
 sch.NSchet as [Тип счета], zs.NPR_DATE, zs.NPR_MO
,sch.month as [Месяц]
  ,sch.YEAR[Год]
  ,case when p.smo like '46%' then p.smo else '46' end as [Плательщик]   
 , p.SMO as [Страховая компания]
  , p.fam,p.im,isnull(p.ot,'') 
 ,p.W as [Пол]
  ,p.DR as [Дата рождения]
  -- , convert(nvarchar(150),(case when p.DOCTYPE=14  then 'Паспорт РФ'
  --when p.DOCTYPE=3 then 'Св-во о рождении'
  --else doc.DocName end)) + ' ' + convert(nvarchar,(p.DOCSER)) + ' ' + convert(nvarchar,(p.DOCNUM)) as [Данные документа удостоверяющего личность]
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
  , zs.ISHOD

 
FROM [D3_SCHET_OMS] sch                  
 inner join D3_PACIENT_OMS p on p.d3_scid=sch.id
 inner join D3_ZSL_OMS zs on zs.D3_PID=p.id AND sch.code_mo=460061 
 --AND sch.month=11
 AND sch.YEAR=2024  
 and sch.MONTH=2
  join D3_SL_OMS s on s.D3_ZSLID=zs.ID 
WHERE s.P_CEL LIKE '1.1'
--OR s.PROFIL=18
  


