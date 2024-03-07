--42000, 66000,  29000,  70000,  15000, 46000,24000, 82000				
Select DISTINCT				
 sch.YEAR[Год]				
--,sch.month as [Месяц]				
,CASE WHEN f002.tf_okato  in (35000) THEN 'Крым' ELSE [name_tfp]	end			
, s.podr,
k.name,case when zs.vidpom=32 then 'вмп' else 'не вмп' end vidpom,s.nhistory,						
	case when  Ksg.N_KSG is not null then   Ksg.N_KSG 										
	else v018.hvidname										
	end namess
		
--,count(zs.id) [количество]				
-- ,sum(sumv) [сумма] 				
 -- ,case when p.smo like '46%' then p.smo else '46' end as [Плательщик]				
 --, p.SMO as [Страховая компания]				
 -- , p.fam+' '+p.im+' '+isnull(p.ot,'') as [ФИО]				
 --,p.W as [Пол]				
 -- ,p.DR as [Дата рождения]				
 --  , convert(nvarchar(150),(case when p.DOCTYPE=14  then 'Паспорт РФ'				
 -- when p.DOCTYPE=3 then 'Св-во о рождении'				
 -- else doc.DocName end)) + ' ' + convert(nvarchar,(p.DOCSER)) + ' ' + convert(nvarchar,(p.DOCNUM)) as [Данные документа удостоверяющего личность]				
 -- , p.NPOLIS as [Полис]				
 -- , p.SNILS as [Снилс]				
 -- , zs.DATE_Z_1 [дата начала]				
 -- , zs.DATE_Z_2 [дата окончания]				
 --  , zs.VIDPOM as [Вид помощи]				
 -- , zs.USL_OK as [Условия оказания мед. помощи]				
				
 -- , zs.SUMV as [Стоимость оказанной мед. помощи]				
 -- ,zs.RSLT AS [Результат]				
 -- , rz.RMPNAME as [Результат обращения за мед помощью]				
 -- ,zs.PR_NOV [признак переподачи]				
				
				
 -- ,zs.d3_scid				
 -- ,p.d3_scid				
  --,idsp				
  -- , s.NHISTORY as [Номер истории]				
  --, s.PODR as [Подразделение]				
  -- , s.DS1 as [Диагноз в соответствии с МКБ-10]				
				
FROM [D3_SCHET_OMS] sch                  				
 inner join D3_PACIENT_OMS p on p.d3_scid=sch.id				
 inner join D3_ZSL_OMS zs on zs.D3_PID=p.id AND sch.code_mo=460061 		
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID 
    left JOIN D3_KSG_KPG_OMS AS ksg ON ksg.D3_SLID=s.id
     left join v023 on v023.K_KSG=ksg.n_ksg and s.date_2 between v023.DATEBEG and isnull(v023.DATEEND,'20211231')		
left join f002 on f002.[smocod]=p.smo 				
		left join [dbo].[D3_SANK_OMS] sank 		
				on sank.[D3_ZSLID]=zs.id
				and sank.s_tip=1
	left join v006 on v006.IDUMP=zs.USL_OK			
	left join f001 on f001.tf_okato=f002.tf_okato
	   left join KOKOD_OTD k on k.kod_otd=s.podr	
	 	
	left join[V019] v019 on cast(v019.IDHM as int)=s.metod_hmp  											
				   --------------------------------с 21 года----------------							
				                              and 							
											cast(case when year(zs.date_z_2)=2020 then v019.IDMODP else  s.MP_HMP end as nvarchar) =cast(v019.IDMODP as nvarchar)
											and s.VID_HMP=HVID
											-- метод ВМП-- метод ВМП
									   AND zs.DATE_z_2>=v019.DATEBEG		
									   AND zs.DATE_z_2<=isnull(v019.dateend,'21000101')			
									    left join v018 v018 on v019.HVID=V018.idhvid                                 -- вид ВМП							
									   AND zs.DATE_z_2>=V018.DATEBEG		
									   AND zs.DATE_z_2<=isnull(v018.dateend,'21000101')					   		
where f002.tf_okato not in (38000)--(42000, 66000,  29000,  70000,  15000, 46000,24000, 82000)				
--and sankk.id is null	
 and sch.id in  (Select 
						--sch.month,nschet,
						id

						FROM [D3_SCHET_OMS] sch  
						WHERE YEAR=2021 AND (nschet LIKE 'дешевые' or nschet LIKE '%сдан%')
			)			
			AND zs.USL_OK=1