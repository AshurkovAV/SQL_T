
select [Месяц],[Плательщик],name, 				
count(id),sum([Стоимость оказанной мед. помощи]) [Стоимость оказанной мед. помощи]				
from				
(				
Select DISTINCT				
 sch.SchetType as [Тип счета]				
,sch.month as [Месяц]				
  ,sch.YEAR[Год]				
  ,case when p.smo like '46%' then f002.nam_smok else 'ТФОМС' end as [Плательщик]				
 , p.SMO as [Страховая компания]				
 , p.fam+' '+p.im+' '+isnull(p.ot,'') as [ФИО]
  , s.DS1 as [Диагноз в соответствии с МКБ-10]				
-- ,p.W as [Пол]				
  --,p.DR as [Дата рождения]				
  -- , convert(nvarchar(150),(case when p.DOCTYPE=14  then 'Паспорт РФ'				
  --when p.DOCTYPE=3 then 'Св-во о рождении'				
 -- else doc.DocName end)) + ' ' + convert(nvarchar,(p.DOCSER)) + ' ' + convert(nvarchar,(p.DOCNUM)) as [Данные документа удостоверяющего личность]				
 -- , p.NPOLIS as [Полис]				
 -- , p.SNILS as [Снилс]				
 --- , zs.DATE_Z_1 [дата начала]				
 -- , zs.DATE_Z_2 [дата окончания]				
  -- , zs.VIDPOM as [Вид помощи]				
 -- , zs.USL_OK as [Условия оказания мед. помощи]				
  , zs.SUMV as [Стоимость оказанной мед. помощи]				
 -- ,zs.RSLT AS [Результат]				
  --, rz.RMPNAME as [Результат обращения за мед помощью]				
  ,zs.PR_NOV [признак переподачи]				
  ,ms.name				
  ,y.namewithid				
  --, s.NHISTORY as [Номер истории]				
  ,zs.id				
  --, s.PODR as [Подразделение]				
			
				
FROM [D3_SCHET_OMS] sch                  				
 inner join D3_PACIENT_OMS p on p.d3_scid=sch.id				
 inner join D3_ZSL_OMS zs on zs.D3_PID=p.id 				
join D3_SL_OMS s on s.D3_ZSLID=zs.ID 				
join d3_usl_oms usl on usl.D3_SLID=s.id				
join ( select distinct code_usl,name from [medicalServices] WHERE year(dataBegin) = 2021) ms on ms.[code_usl]=usl.code_usl 				
left join Yamed_Spr_UslCode y on y.ID=usl.vid_vme				
	--left join [ELMEDICINENEWFOND].[dbo].[D3_SANK_OMS] sank 			
	--			on sank.[D3_ZSLID]=zs.id
	--			and sank.s_tip=1
left join f002 on f002.smocod=p.smo
where  sch.code_mo=460061 				
       
		AND sch.month=10 --and   sch.id in (2949,2950,2952)
		AND sch.YEAR=2021
		--and month(zs.date_z_2)=4
--and sch.id in (3122,3121,3117)	
		 and zs.usl_ok=3		
		-- and sank.id is null		
		 and usl.code_usl like 'R01%'	
		-- AND (ds1  LIKE 'U07%'	OR ds1  LIKE 'J18%')
		AND (ds1  LIKE 'z03%'	)
		 ) t		
		 group by [Месяц],[Плательщик],name		
