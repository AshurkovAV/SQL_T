Select --sum(sumv)

--DISTINCT
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
 -- ,p.d3_scid
  ,idsp
  , sump, oplata
  ,dsko.IDSL, dsko.Z_SL--, case when zs.FOR_POM=1 THEN 'covid' end
  -- , s.NHISTORY as [Номер истории]
  --, s.PODR as [Подразделение]
  -- , s.DS1 as [Диагноз в соответствии с МКБ-10]
  , s.NHISTORY, s.DATE_1,u.CODE_USL
FROM [D3_SCHET_OMS] sch                  
 inner join D3_PACIENT_OMS p on p.d3_scid=sch.id
 inner join D3_ZSL_OMS zs on zs.D3_PID=p.id AND sch.code_mo=460061 
   join D3_SL_OMS s on s.D3_ZSLID=zs.ID 
left JOIN D3_USL_OMS u ON u.D3_SLID=s.id
 LEFT JOIN D3_CONS_OMS AS c ON c.D3_SLID=s.id
 JOIN D3_KSG_KPG_OMS ksg ON ksg.D3_SLID=s.ID
 LEFT JOIN D3_SL_KOEF_OMS AS dsko
          ON dsko.D3_KSGID = ksg.ID
-- and   sch.id in  (10676)
join V009 rz on rz.IDRMP=zs.RSLT
left join F011 doc on doc.Id=p.DOCTYPE
WHERE   sch.month=4
 AND sch.YEAR=2023 
 AND zs.USL_OK=1
 AND (ksg.SL_K=1 OR u.CODE_USL LIKE 'A26.08.008.001')
 --and zs.OS_SLUCH_REGION=40 
 --AND s.DATE_1>='07.04.2023' 
 --AND NOT (c.PR_CONS IS NULL OR c.PR_CONS=0 )
 
ORDER BY s.DATE_1 desc