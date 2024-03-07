
Select --DISTINCT
 sch.SchetType as [Тип счета]
,sch.month as [Месяц]
  ,sch.YEAR[Год]
  ,case when p.smo like '46%' then p.smo else '46' end as [Плательщик]
 , p.SMO as [Страховая компания]
  , p.fam+' '+p.im+' '+isnull(p.ot,'') as [ФИО]
 ,p.W as [Пол]
  ,p.DR as [Дата рождения]
   , convert(nvarchar(150),(case when p.DOCTYPE=14  then 'Паспорт РФ'
  when p.DOCTYPE=3 then 'Св-во о рождении'
  else doc.DocName end)) + ' ' + convert(nvarchar,(p.DOCSER)) + ' ' + convert(nvarchar,(p.DOCNUM)) as [Данные документа удостоверяющего личность]
  , p.NPOLIS as [Полис]
  , p.SNILS as [Снилс]
  , zs.DATE_Z_1 [дата начала]
  , zs.DATE_Z_2 [дата окончания]
   , zs.VIDPOM as [Вид помощи]
  , zs.USL_OK as [Условия оказания мед. помощи]

  , zs.SUMV as [Стоимость оказанной мед. помощи]
  ,zs.RSLT AS [Результат]
  , rz.RMPNAME as [Результат обращения за мед помощью]
  ,zs.PR_NOV [признак переподачи]


  ,zs.d3_scid
  ,p.d3_scid
  ,idsp
  -- , s.NHISTORY as [Номер истории]
  --, s.PODR as [Подразделение]
  -- , s.DS1 as [Диагноз в соответствии с МКБ-10]

FROM [D3_SCHET_OMS] sch                  
 inner join D3_PACIENT_OMS p on p.d3_scid=sch.id
 inner join D3_ZSL_OMS zs on zs.D3_PID=p.id AND sch.code_mo=460061 
 AND sch.month=9
 AND sch.YEAR=2023
--and   sch.id in (3744,3755,3756)
--AND sch.ID IN (686, 688, 682)

join V009 rz on rz.IDRMP=zs.RSLT
left join F011 doc on doc.Id=p.DOCTYPE
--order by schettype
WHERE p.SMO NOT LIKE '46%' AND  (zs.USL_OK IN (1,2) OR idsp = 28)
--where --zs.usl_ok=1 and sumv=33376.23
--(zs.sumv=32548.3 and zs.usl_ok=2)


and usl_ok=1
--order by sumv
--where zs.pr_nov=1 --and p.smo not like '46%'