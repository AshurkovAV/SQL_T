


Select DISTINCT	sch.id AS schit	,usl.code_usl,usl.DATE_IN ,usl.DATE_OUT	,	
 sch.nschet				
,sch.month as [Месяц]				
  ,sch.YEAR[Год]				
  ,case when p.smo like '46%' then f002.nam_smok else 'ТФОМС' end as [Плательщик]				
 , p.SMO as [Страховая компания]				
 -- , p.fam+' '+p.im+' '+isnull(p.ot,'') as [ФИО]				
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
  -- , s.DS1 as [Диагноз в соответствии с МКБ-10]				
				
FROM [D3_SCHET_OMS] sch                  				
 inner join D3_PACIENT_OMS p on p.d3_scid=sch.id				
 inner join D3_ZSL_OMS zs on zs.D3_PID=p.id 				
join D3_SL_OMS s on s.D3_ZSLID=zs.ID 				
join d3_usl_oms usl on usl.D3_SLID=s.id				
left join  [medicalServices] ms on ms.[code_usl]=usl.code_usl 	AND usl.DATE_IN >=ms.dataBegin AND usl.DATE_OUT<=ISNULL(ms.dataEnd,'20991231')			
left join Yamed_Spr_UslCode y on y.ID=usl.vid_vme				
	--left join [ELMEDICINENEWFOND].[dbo].[D3_SANK_OMS] sank 			
	--			on sank.[D3_ZSLID]=zs.id
	--			and sank.s_tip=1
left join f002 on f002.smocod=p.smo
 LEFT JOIN kokod_podr AS kp ON kp.IDDOCT=dbo.f_digit_only(iddokt) AND zs.usl_ok=kp.usl_ok
where  sch.code_mo=460061 				
       
		--AND sch.month=6 and   sch.id in (6916,6917)
		AND sch.YEAR=2023
		AND sch.id IN (17381,17382)--16122,15105,16139)
		--AND sch.id IN (SELECT DISTINCT-- month,
		--               sch.id FROM D3_SCHET_OMS AS sch 
		--               where sch.NSCHET LIKE '%%' AND year=2022)
		--and   sch.id in (4351,4352)
		--and month(zs.date_z_2)=4
--and sch.id in (3122,3121,3117)	
		 and zs.usl_ok=3		
		-- and sank.id is null		
		 and usl.code_usl like 'R01.001.006'	
		 AND ms.id IS null