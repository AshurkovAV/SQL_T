--UPDATE zs SET sump=NULL

Select zs.NPR_MO, f003.nam_mok,  
case when p.smo like '46%' then p.smo else '46' end as [Плательщик]
 , p.SMO as [Страховая компания],
 p.fam+' '+p.im+' '+isnull(p.ot,'') as [ФИО]
,case when p.W=1 THEN  'М' else 'Ж' end as [Пол]
  ,p.DR as [Дата рождения]
  , convert(nvarchar(150),(case when p.DOCTYPE=14  then 'Паспорт РФ'
  when p.DOCTYPE=3 then 'Св-во о рождении'
  else doc.DocName end)) + ' ' + convert(nvarchar,(p.DOCSER)) + ' ' + convert(nvarchar,(p.DOCNUM)) as [Данные документа удостоверяющего личность]
  , p.SNILS as [Снилс]
    , p.NPOLIS as [Полис]
    , zs.VIDPOM as [Вид помощи]
    , zs.USL_OK as [Условия оказания мед. помощи]
    , s.DS1 as [Диагноз в соответствии с МКБ-10]
     , zs.DATE_Z_1 [дата начала]
  , zs.DATE_Z_2 [дата окончания]
      , v002.NameWithID [профиль мед помощи]
      ,v021.NameWithID [специальность врача]
      , rz.NameWithID as [Результат обращения за мед помощью]
       , s.tarif [тариф на оплату мед помощи]
      , zs.SUMV as [Стоимость оказанной мед. помощи]
      
FROM [D3_SCHET_OMS] sch                  
 inner join D3_PACIENT_OMS p on p.d3_scid=sch.id
 inner join D3_ZSL_OMS zs on zs.D3_PID=p.id AND sch.code_mo=460061 
 AND sch.month=2
 AND sch.YEAR=2023  and   sch.id in (9572,9456)

join V009 rz on rz.IDRMP=zs.RSLt
LEFT JOIN D3_SL_OMS AS s ON s.D3_ZSLID=zs.ID
left join F011 doc on doc.Id=p.DOCTYPE
LEFT JOIN v002 ON v002.IDPR=s.profil
LEFT JOIN v021 ON v021.IDSPEC=s.PRVS
LEFT JOIN f003 ON f003.mcod=zs.NPR_MO
