--42000, 66000,  29000,  70000,  15000, 46000,24000, 82000				
Select DISTINCT				
 sch.YEAR[Год]				
,sch.month as [Месяц]				
,[name_tfp]				
, v006.UMPNAME			
--,count(zs.id) [количество]				
-- ,sum(sumv) [сумма] 				
 -- ,case when p.smo like '46%' then p.smo else '46' end as [Плательщик]				
 , p.SMO as [Страховая компания]				
  , p.fam+' '+p.im+' '+isnull(p.ot,'') as [ФИО]				
 --,p.W as [Пол]				
 -- ,p.DR as [Дата рождения]				
 --  , convert(nvarchar(150),(case when p.DOCTYPE=14  then 'Паспорт РФ'				
 -- when p.DOCTYPE=3 then 'Св-во о рождении'				
 -- else doc.DocName end)) + ' ' + convert(nvarchar,(p.DOCSER)) + ' ' + convert(nvarchar,(p.DOCNUM)) as [Данные документа удостоверяющего личность]				
 -- , p.NPOLIS as [Полис]				
 -- , p.SNILS as [Снилс]				
  , zs.DATE_Z_1 [дата начала]				
  , zs.DATE_Z_2 [дата окончания]				
   , zs.VIDPOM as [Вид помощи]				
  , zs.USL_OK as [Условия оказания мед. помощи]				
				
  , zs.SUMV as [Стоимость оказанной мед. помощи]				
  ,zs.RSLT AS [Результат]				
--  , rz.RMPNAME as [Результат обращения за мед помощью]				
  ,zs.PR_NOV [признак переподачи]				
				
				
 -- ,zs.d3_scid				
 -- ,p.d3_scid				
  --,idsp				
   , s.NHISTORY as [Номер истории]				
  , s.PODR as [Подразделение]				
   , s.DS1 as [Диагноз в соответствии с МКБ-10]				
				
FROM [D3_SCHET_OMS] sch                  				
 inner join D3_PACIENT_OMS p on p.d3_scid=sch.id				
 inner join D3_ZSL_OMS zs on zs.D3_PID=p.id AND sch.code_mo=460061 	
  join D3_SL_OMS s on s.D3_ZSLID=zs.ID 			
left join f002 on f002.[smocod]=p.smo 				
		left join [dbo].[D3_SANK_OMS] sank 		
				on sank.[D3_ZSLID]=zs.id
				and sank.s_tip=1
	left join v006 on v006.IDUMP=zs.USL_OK			
	left join f001 on f001.tf_okato=f002.tf_okato			
where f002.tf_okato in (42000, 66000,  29000,  70000,  15000, 46000,24000, 82000)				
and sank.id is null				
and sch.year=2021				
				
order by [name_tfp]	,sch.YEAR			
,sch.month 				
, v006.UMPNAME				
