--UPDATE zs SET sump=NULL
SELECT [Год],[Месяц],[Тип счета],  [Плательщик],[ед. обьём], os_schuch_name,COUNT(zslid) [количество зак сл], SUM([признак переподачи]) [из них переподано],SUM([Стоимость оказанной мед. помощи]) [Стоимость оказанной мед. помощи]
,isnull(SUM(CASE WHEN [признак переподачи]=1 THEN  [Стоимость оказанной мед. помощи] END),0) [Стоимость переподано]
FROM
(
Select --sum(sumv)

DISTINCT sch.id, sch.nschet, zs.id zslid,
 sch.SchetType as [Тип счета]
,sch.month as [Месяц]
  ,sch.YEAR[Год]
  ,case when p.smo like '46%' then p.smo else '46' end as [Плательщик]
 , p.SMO as [Страховая компания]
  , p.fam+' '+p.im+' '+isnull(p.ot,'') as [ФИО]
 ,p.W as [Пол]
  , CAST(dr AS DATE) [Дата рождения]
  --,p.DR as [Дата рождения]
   , convert(nvarchar(150),(case when p.DOCTYPE=14  then 'Паспорт РФ'
  when p.DOCTYPE=3 then 'Св-во о рождении'
  else doc.DocName end)) + ' ' + convert(nvarchar,(p.DOCSER)) + ' ' + convert(nvarchar,(p.DOCNUM)) as [Данные документа удостоверяющего личность]
  , p.NPOLIS as [Полис]
  , p.SNILS as [Снилс]
  ,CAST (date_z_1 AS DATE) [дата начала]
  --, zs.DATE_Z_1 [дата начала]
  ,CAST(date_z_2 AS DATE) [дата окончания]
  --, zs.DATE_Z_2 [дата окончания]
   , zs.VIDPOM as [Вид помощи]
  , zs.USL_OK as [Условия оказания мед. помощи]

  , zs.SUMV as [Стоимость оказанной мед. помощи]
  ,zs.RSLT AS [Результат]
  , rz.RMPNAME as [Результат обращения за мед помощью]
  ,zs.PR_NOV [признак переподачи]
  ,case when (idsp=29 and os_sluch_region is NULL) or os_sluch_region in (56,59,63) then 'профилактическое посещение' 
        when (idsp=30 and os_sluch_region is NULL) or os_sluch_region in (40,57) then 'oбращение по заболеванию' 
        when idsp=28 then ms.name 
        else v006.NameWithID end 'ед. обьём'


 -- ,zs.d3_scid
  --,p.d3_scid
  ,idsp
  , sump, oplata, isnull(osd.NameWithID,'') os_schuch_name, zs.OS_SLUCH_REGION
   , s.NHISTORY as [Номер истории]
  --, s.PODR as [Подразделение]
  -- , s.DS1 as [Диагноз в соответствии с МКБ-10]
  ,zs.EXP_COMENT
  ,s.P_CEL25
FROM [D3_SCHET_OMS] sch                  
 inner join D3_PACIENT_OMS p on p.d3_scid=sch.id
 inner join D3_ZSL_OMS zs on zs.D3_PID=p.id AND sch.code_mo=460061 
-- AND sch.month=6
 AND sch.YEAR=2023  and   sch.id in   (16149,16162,16161,16163,16164)-- (14926,14934,14935,14936,14937)
                                              
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID 				
        left join d3_usl_oms usl on usl.D3_SLID=s.id
        left join ( select distinct code_usl,name from [medicalServices] WHERE year(dataBegin) = 2022		
--and code_usl in ('R01.001.001','R01.001.001.001','R01.001.002','R01.001.002.001')				
) ms on ms.[code_usl]=usl.code_usl 
join V009 rz on rz.IDRMP=zs.RSLT
left join F011 doc on doc.Id=p.DOCTYPE
LEFT JOIN OsobSluchDb AS osd ON osd.Id = zs.OS_SLUCH_REGION
LEFT JOIN D3_SANK_OMS AS dso ON dso.D3_ZSLID=zs.id AND dso.s_tip=1
LEFT JOIN v006 ON v006.id=zs.USL_OK
WHERE dso.id IS NULL
) t 
GROUP BY [Год],[Месяц],[Тип счета], [Плательщик],[ед. обьём], os_schuch_name