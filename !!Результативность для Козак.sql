--случаи с любыми целями, в которых диагноз или стоит признак выявлен впервые или характер Впервые в жизни установленное хроническое
Select  distinct
   p.NPOLIS as [Полис]    
  ,CASE WHEN (DATEDIFF(dd, DR, DATE_Z_1)/365.2524) > 18 THEN 'Взрослые'
ELSE 'Дети' END [ВзДети]
 , zs.DATE_Z_1 [дата начала]    
 , zs.DATE_Z_2 [дата окончания]    
 
  
  --, s.NHISTORY as [Номер истории]    
    
 
   , s.DS1 as [Диагноз в соответствии с МКБ-10]   
  
  , substring(os.[NameWithID], 0, 24 ) [особый случай регион]
  ,v025.[NameWithID] [цель посещения]
    , ds1_pr [выявлен впервые]
	,v027.[NameWithID] [характер заболевания]
		,case when dn=1 then  'состоит'
	      when dn=2 then  'взят'
		  when dn=3 then  'не подлежит диспансерному наблюдению' end 'д_учет'
FROM [D3_SCHET_OMS] sch                      inner join D3_PACIENT_OMS p on p.d3_scid=sch.id    
 inner join D3_ZSL_OMS zs on zs.D3_PID=p.id     
join D3_SL_OMS s on s.D3_ZSLID=zs.ID   
--join d3_usl_oms usl on usl.D3_SLID=s.id    
--join ( select distinct code_usl,name from [medicalServices] WHERE year(dataBegin) = 2022) ms on ms.[code_usl]=usl.code_usl     
--left join Yamed_Spr_UslCode y on y.ID=usl.vid_vme    
 left join [dbo].[D3_SANK_OMS] sank    
    on sank.[D3_ZSLID]=zs.id
    and sank.s_tip=1
left join f002 on f002.smocod=p.smo
 --LEFT JOIN kokod_podr AS kp ON kp.IDDOCT=dbo.f_digit_only(iddokt) AND zs.usl_ok=kp.usl_ok
 left join [OsobSluchDb] os on os.[Id]=zs.OS_SLUCH_REGION
 left join v025 on v025.[IDPC]=s.p_cel25
  left join v027 on v027.[IDCZ]=s.c_zab
where  sch.code_mo in (460026, 460006)   
     
  AND sch.YEAR=2021
  and zs.date_z_1 between '20210101' and '20211231'
 and zs.usl_ok=3
and sank.id is null
--and [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1)	>17
and s.profil not in (85,86,87,88,89,90,140,171,63)


--случаи с любыми целями, в которых диагноз или стоит признак выявлен впервые или характер Впервые в жизни установленное хроническое
Select  distinct
   p.NPOLIS as [Полис]    
  ,CASE WHEN (DATEDIFF(dd, DR, DATE_Z_1)/365.2524) > 18 THEN 'Взрослые'
ELSE 'Дети' END [ВзДети]
 , zs.DATE_Z_1 [дата начала]    
 , zs.DATE_Z_2 [дата окончания]    
 
  
  --, s.NHISTORY as [Номер истории]    
    
 
   , s.DS1 as [Диагноз в соответствии с МКБ-10]   
  
  , substring(os.[NameWithID], 0, 24 ) [особый случай регион]
  ,v025.[NameWithID] [цель посещения]
    , ds1_pr [выявлен впервые]
	,v027.[NameWithID] [характер заболевания]
		,case when dn=1 then  'состоит'
	      when dn=2 then  'взят'
		  when dn=3 then  'не подлежит диспансерному наблюдению' end 'д_учет'
FROM [D3_SCHET_OMS] sch                      
 inner join D3_PACIENT_OMS p on p.d3_scid=sch.id    
 inner join D3_ZSL_OMS zs on zs.D3_PID=p.id     
join D3_SL_OMS s on s.D3_ZSLID=zs.ID   
--join d3_usl_oms usl on usl.D3_SLID=s.id    
--join ( select distinct code_usl,name from [medicalServices] WHERE year(dataBegin) = 2022) ms on ms.[code_usl]=usl.code_usl     
--left join Yamed_Spr_UslCode y on y.ID=usl.vid_vme    
 left join [dbo].[D3_SANK_OMS] sank    
    on sank.[D3_ZSLID]=zs.id
    and sank.s_tip=1
left join f002 on f002.smocod=p.smo
 --LEFT JOIN kokod_podr AS kp ON kp.IDDOCT=dbo.f_digit_only(iddokt) AND zs.usl_ok=kp.usl_ok
 left join [OsobSluchDb] os on os.[Id]=zs.OS_SLUCH_REGION
 left join v025 on v025.[IDPC]=s.p_cel25
  left join v027 on v027.[IDCZ]=s.c_zab
where  sch.code_mo in (460026, 460006)   
     
  AND sch.YEAR=2022
  and zs.date_z_1 between '20220101' and '20220630'
 and zs.usl_ok=3
and sank.id is null
--and [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1)	>17
and s.profil not in (85,86,87,88,89,90,140,171,63)
