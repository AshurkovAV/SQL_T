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
  -- , s.NHISTORY as [Номер истории]
  --, s.PODR as [Подразделение]
  -- , s.DS1 as [Диагноз в соответствии с МКБ-10]

from d3_zsl_oms zs
join D3_PACIENT_OMS p on zs.d3_pid = p.id 
join  [D3_SCHET_OMS] sch on sch.id = zs.d3_scid 

--AND sch.ID IN (686, 688, 682)

join V009 rz on rz.IDRMP=zs.RSLT
left join F011 doc on doc.Id=p.DOCTYPE
--WHERE date_z_2<='20200926'
where zs.d3_scid IN (1247,1248,1258) AND sch.code_mo=460061 AND sch.month=11 AND sch.YEAR=2020
----and zs.RSLT<>105 and 
--(zs.sumv<15150 and zs.usl_ok=1 or zs.sumv<34000 and zs.usl_ok=2)