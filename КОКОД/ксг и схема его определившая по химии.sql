		select DISTINCT 			
		 [отделение]	
		    	,[схема],[ксг]	
	 , COUNT(DISTINCT t1.NHISTORY) [количество случаев], COUNT(DISTINCT t1.npolis) [количество пациентов]			
	 from
	 (	
	select DISTINCT 			
		CASE WHEN  sl.PODR	in ('460061206014') THEN 'ХТО2'	
		     WHEN  sl.PODR	in ('460061106006') THEN 'ХТО1'	
		     ELSE 'остальные отделения' END [отделение]	, sl.NHISTORY,  p.npolis	
		    	,lekpr.CODE_SH [схема],CASE when ksgkpg.N_KSG IS NULL THEN 'вмп' ELSE ksgkpg.N_KSG+' '+v23.N_KSG END [ксг]--,spr.*	
		--   , COUNT(DISTINCT sl.NHISTORY) [количество случаев], COUNT(DISTINCT p.npolis) [количество пациентов]		
				
	FROM [D3_SCHET_OMS] sch                  			
left join D3_PACIENT_OMS p on p.d3_scid=sch.id 				
left join f003 f on f.mcod=sch.code_mo				
left join f002 f2 on f2.smocod=p.smo				
left join D3_ZSL_OMS zsl on zsl.D3_PID=p.id and zsl.D3_SCID=sch.id				
left join v006 v6 on v6.IDUMP=zsl.USL_OK				
left join v008 v8 on v8.IDVMP=zsl.VIDPOM				
left join v014 v14 on v14.IDFRMMP=zsl.FOR_POM				
left join v009 v9 on v9.IDRMP=zsl.RSLT				
left join v012 v12 on v12.id=zsl.ISHOD				
--SL---------------------------------------------------------------------				
left join D3_SL_OMS sl on sl.D3_ZSLID=zsl.ID				
left join v025 v25 on v25.IDPC=sl.P_CEL25				
left join v002 v2 on v2.IDPR=sl.PROFIL and sl.DATE_2 between v2.DATEBEG and isnull(v2.DATEEND,'20991231')				
left join M001_oplata_status m on m.idds=sl.ds1 --and m.ACTUAL=1				
				
left join D3_KSG_KPG_OMS KsgKpg on KsgKpg.D3_SLID=sl.id				
left join v023 v23 on v23.K_KSG=ksgkpg.N_KSG and sl.DATE_2 between v23.DATEBEG and isnull(v23.dateend,'20991231')				
				
left join D3_CRIT_OMS Crit on Crit.D3_KSGID=ksgkpg.id				
				
----OnkSl---------------------------------------------				
join D3_ONK_SL_OMS OnkSl on OnkSl.D3_SLID=sl.id				
join D3_ONK_USL_OMS OnkUsl on OnkUsl.D3_ONKSLID=OnkSl.ID 				
left join N013 n013 on n013.id_tlech=Onkusl.usl_tip				
join D3_LEK_PR_OMS LekPr on LekPr.D3_ONKUSLID=OnkUsl.id 				
left join v024 v24 on v24.IDDKK=lekpr.CODE_SH and sl.DATE_2 between v24.DATEBEG and isnull(v24.dateend,'20991231')				
left join n020 n20 on n20.ID_LEKP=lekpr.REGNUM and sl.DATE_2 between n20.DATEBEG and isnull(n20.DATEEND,'20991231')				
				
left join KOKOD_OTD k on k.kod_otd=sl.podr				
 join ksg_code_sh_2023 spr on spr.ksg=KsgKpg.N_KSG and date_z_2 between spr.DateBEG and spr.DateEND and lekpr.CODE_SH=spr.code_sh				
join (	 select DISTINCT 			
		     CASE WHEN  sl.PODR	in ('460061206014') THEN 'ХТО2'	
		     WHEN  sl.PODR	in ('460061106006') THEN 'ХТО1'	
		     ELSE 'остальные отделения' END [отделение]	, sl.NHISTORY,  p.npolis--, 	LekPr.Code_sh,CASE when ksgkpg.N_KSG IS NULL THEN 'вмп' ELSE ksgkpg.N_KSG+' '+v23.N_KSG END
		   	FROM [D3_SCHET_OMS] sch                  			
            left join D3_PACIENT_OMS p on p.d3_scid=sch.id 
            left join D3_ZSL_OMS zsl on zsl.D3_PID=p.id and zsl.D3_SCID=sch.id	
            --SL---------------------------------------------------------------------				
            left join D3_SL_OMS sl on sl.D3_ZSLID=zsl.ID
            left join D3_KSG_KPG_OMS KsgKpg on KsgKpg.D3_SLID=sl.id		
            left join D3_CRIT_OMS Crit on Crit.D3_KSGID=ksgkpg.id		
            ----OnkSl---------------------------------------------				
            join D3_ONK_SL_OMS OnkSl on OnkSl.D3_SLID=sl.id				
            join D3_ONK_USL_OMS OnkUsl on OnkUsl.D3_ONKSLID=OnkSl.ID
            join D3_LEK_PR_OMS LekPr on LekPr.D3_ONKUSLID=OnkUsl.id 				
            left join v024 v24 on v24.IDDKK=lekpr.CODE_SH and sl.DATE_2 between v24.DATEBEG and isnull(v24.dateend,'20991231')
            left join KOKOD_OTD k on k.kod_otd=sl.podr	
            left join v023 v23 on v23.K_KSG=ksgkpg.N_KSG and sl.DATE_2 between v23.DATEBEG and isnull(v23.dateend,'20991231')		
            where 		
			YEAR(zsl.date_z_2)=2023	
			and zsl.usl_ok in (1,2)	
			and sch.code_mo =460061	
			and lekpr.REGNUM	is not null
			and onkusl.usl_tip=2	
			and sl.PODR	in ('460061106006','460061206014')			
             group by 	 CASE WHEN  sl.PODR	in ('460061206014') THEN 'ХТО2'	
		                      WHEN  sl.PODR	in ('460061106006') THEN 'ХТО1'	
		                      ELSE 'остальные отделения' END	, sl.NHISTORY,  p.npolis
             Having count(distinct LekPr.Code_sh)>1		
		) t on 	t.[отделение]=	CASE WHEN  sl.PODR	in ('460061206014') THEN 'ХТО2'	
		     WHEN  sl.PODR	in ('460061106006') THEN 'ХТО1'	
		     ELSE 'остальные отделения' END
			 and 	sl.NHISTORY=t.NHISTORY and  p.npolis=t.npolis
		where 		
			YEAR(zsl.date_z_2)=2023	
			and zsl.usl_ok in (1,2)	
			and sch.code_mo =460061	
			and lekpr.REGNUM	is not null
			and onkusl.usl_tip=2	
			and sl.PODR	in ('460061106006','460061206014')
			and lekpr.CODE_SH not like 'gem%'

 --group by 	 CASE WHEN  sl.PODR	in ('460061206014') THEN 'ХТО2'	
	--	                      WHEN  sl.PODR	in ('460061106006') THEN 'ХТО1'	
	--	                      ELSE 'остальные отделения' END,lekpr.CODE_SH,CASE when ksgkpg.N_KSG IS NULL THEN 'вмп' ELSE ksgkpg.N_KSG+' '+v23.N_KSG END 		

union
--одна схема
							
	select DISTINCT 						
		CASE WHEN  sl.PODR	in ('460061206014') THEN 'ХТО2'				
		     WHEN  sl.PODR	in ('460061106006') THEN 'ХТО1'				
		     ELSE 'остальные отделения' END [отделение]	, sl.NHISTORY,  p.npolis				
		    	,lekpr.CODE_SH [схема],CASE when ksgkpg.N_KSG IS NULL THEN 'вмп' ELSE ksgkpg.N_KSG+' '+v23.N_KSG END [ксг]--,spr.*				
		   --, COUNT(DISTINCT sl.NHISTORY) [количество случаев], COUNT(DISTINCT p.npolis) [количество пациентов]					
							
	FROM [D3_SCHET_OMS] sch                  						
left join D3_PACIENT_OMS p on p.d3_scid=sch.id 							
left join f003 f on f.mcod=sch.code_mo							
left join f002 f2 on f2.smocod=p.smo							
left join D3_ZSL_OMS zsl on zsl.D3_PID=p.id and zsl.D3_SCID=sch.id							
left join v006 v6 on v6.IDUMP=zsl.USL_OK							
left join v008 v8 on v8.IDVMP=zsl.VIDPOM							
left join v014 v14 on v14.IDFRMMP=zsl.FOR_POM							
left join v009 v9 on v9.IDRMP=zsl.RSLT							
left join v012 v12 on v12.id=zsl.ISHOD							
--SL---------------------------------------------------------------------							
left join D3_SL_OMS sl on sl.D3_ZSLID=zsl.ID							
left join v025 v25 on v25.IDPC=sl.P_CEL25							
left join v002 v2 on v2.IDPR=sl.PROFIL and sl.DATE_2 between v2.DATEBEG and isnull(v2.DATEEND,'20991231')							
left join M001_oplata_status m on m.idds=sl.ds1 --and m.ACTUAL=1							
							
left join D3_KSG_KPG_OMS KsgKpg on KsgKpg.D3_SLID=sl.id							
left join v023 v23 on v23.K_KSG=ksgkpg.N_KSG and sl.DATE_2 between v23.DATEBEG and isnull(v23.dateend,'20991231')							
							
left join D3_CRIT_OMS Crit on Crit.D3_KSGID=ksgkpg.id							
							
----OnkSl---------------------------------------------							
join D3_ONK_SL_OMS OnkSl on OnkSl.D3_SLID=sl.id							
join D3_ONK_USL_OMS OnkUsl on OnkUsl.D3_ONKSLID=OnkSl.ID 							
left join N013 n013 on n013.id_tlech=Onkusl.usl_tip							
join D3_LEK_PR_OMS LekPr on LekPr.D3_ONKUSLID=OnkUsl.id 							
left join v024 v24 on v24.IDDKK=lekpr.CODE_SH and sl.DATE_2 between v24.DATEBEG and isnull(v24.dateend,'20991231')							
left join n020 n20 on n20.ID_LEKP=lekpr.REGNUM and sl.DATE_2 between n20.DATEBEG and isnull(n20.DATEEND,'20991231')							
							
left join KOKOD_OTD k on k.kod_otd=sl.podr							
left join ksg_code_sh_2023 spr on spr.ksg=KsgKpg.N_KSG and date_z_2 between spr.DateBEG and spr.DateEND and Crit.CRIT=spr.code_sh							
join (	 select DISTINCT 						
		     CASE WHEN  sl.PODR	in ('460061206014') THEN 'ХТО2'				
		     WHEN  sl.PODR	in ('460061106006') THEN 'ХТО1'				
		     ELSE 'остальные отделения' END [отделение]	, sl.NHISTORY,  p.npolis--, 	LekPr.Code_sh,CASE when ksgkpg.N_KSG IS NULL THEN 'вмп' ELSE ksgkpg.N_KSG+' '+v23.N_KSG END			
		   	FROM [D3_SCHET_OMS] sch                  				
            left join D3_PACIENT_OMS p on p.d3_scid=sch.id 							
            left join D3_ZSL_OMS zsl on zsl.D3_PID=p.id and zsl.D3_SCID=sch.id							
            --SL---------------------------------------------------------------------							
            left join D3_SL_OMS sl on sl.D3_ZSLID=zsl.ID							
            left join D3_KSG_KPG_OMS KsgKpg on KsgKpg.D3_SLID=sl.id							
            left join D3_CRIT_OMS Crit on Crit.D3_KSGID=ksgkpg.id							
            ----OnkSl---------------------------------------------							
            join D3_ONK_SL_OMS OnkSl on OnkSl.D3_SLID=sl.id							
            join D3_ONK_USL_OMS OnkUsl on OnkUsl.D3_ONKSLID=OnkSl.ID							
            join D3_LEK_PR_OMS LekPr on LekPr.D3_ONKUSLID=OnkUsl.id 							
            left join v024 v24 on v24.IDDKK=lekpr.CODE_SH and sl.DATE_2 between v24.DATEBEG and isnull(v24.dateend,'20991231')							
            left join KOKOD_OTD k on k.kod_otd=sl.podr							
            left join v023 v23 on v23.K_KSG=ksgkpg.N_KSG and sl.DATE_2 between v23.DATEBEG and isnull(v23.dateend,'20991231')							
            where 							
			YEAR(zsl.date_z_2)=2023				
			and zsl.usl_ok in (1,2)				
			and sch.code_mo =460061				
			and lekpr.REGNUM	is not null			
			and onkusl.usl_tip=2				
			and sl.PODR	in ('460061106006','460061206014')			
             group by 	 CASE WHEN  sl.PODR	in ('460061206014') THEN 'ХТО2'					
		                      WHEN  sl.PODR	in ('460061106006') THEN 'ХТО1'				
		                      ELSE 'остальные отделения' END	, sl.NHISTORY,  p.npolis				
             Having count(distinct LekPr.Code_sh)=1							
		) t on 	t.[отделение]=	CASE WHEN  sl.PODR	in ('460061206014') THEN 'ХТО2'		
		     WHEN  sl.PODR	in ('460061106006') THEN 'ХТО1'				
		     ELSE 'остальные отделения' END					
			 and 	sl.NHISTORY=t.NHISTORY and  p.npolis=t.npolis			
		where 					
			YEAR(zsl.date_z_2)=2023				
			and zsl.usl_ok in (1,2)				
			and sch.code_mo =460061				
			and lekpr.REGNUM	is not null			
			and onkusl.usl_tip=2				
			and sl.PODR	in ('460061106006','460061206014')			
							
union			
--гемоп
		
select DISTINCT 			
		CASE WHEN  sl.PODR	in ('460061206014') THEN 'ХТО2'	
		     WHEN  sl.PODR	in ('460061106006') THEN 'ХТО1'	
		     ELSE 'остальные отделения' END [отделение]	, sl.NHISTORY,  p.npolis	
		    	,lekpr.CODE_SH [схема],CASE when ksgkpg.N_KSG IS NULL THEN 'вмп' ELSE ksgkpg.N_KSG+' '+v23.N_KSG END [ксг]	
		--   , COUNT(DISTINCT sl.NHISTORY) [количество случаев], COUNT(DISTINCT p.npolis) [количество пациентов]		
				
	FROM [D3_SCHET_OMS] sch                  			
left join D3_PACIENT_OMS p on p.d3_scid=sch.id 				
left join f003 f on f.mcod=sch.code_mo				
left join f002 f2 on f2.smocod=p.smo				
left join D3_ZSL_OMS zsl on zsl.D3_PID=p.id and zsl.D3_SCID=sch.id				
left join v006 v6 on v6.IDUMP=zsl.USL_OK				
left join v008 v8 on v8.IDVMP=zsl.VIDPOM				
left join v014 v14 on v14.IDFRMMP=zsl.FOR_POM				
left join v009 v9 on v9.IDRMP=zsl.RSLT				
left join v012 v12 on v12.id=zsl.ISHOD				
--SL---------------------------------------------------------------------				
left join D3_SL_OMS sl on sl.D3_ZSLID=zsl.ID				
left join v025 v25 on v25.IDPC=sl.P_CEL25				
left join v002 v2 on v2.IDPR=sl.PROFIL and sl.DATE_2 between v2.DATEBEG and isnull(v2.DATEEND,'20991231')				
left join M001_oplata_status m on m.idds=sl.ds1 --and m.ACTUAL=1				
				
left join D3_KSG_KPG_OMS KsgKpg on KsgKpg.D3_SLID=sl.id				
left join v023 v23 on v23.K_KSG=ksgkpg.N_KSG and sl.DATE_2 between v23.DATEBEG and isnull(v23.dateend,'20991231')				
				
left join D3_CRIT_OMS Crit on Crit.D3_KSGID=ksgkpg.id				
				
----OnkSl---------------------------------------------				
join D3_ONK_SL_OMS OnkSl on OnkSl.D3_SLID=sl.id				
join D3_ONK_USL_OMS OnkUsl on OnkUsl.D3_ONKSLID=OnkSl.ID 				
left join N013 n013 on n013.id_tlech=Onkusl.usl_tip				
join D3_LEK_PR_OMS LekPr on LekPr.D3_ONKUSLID=OnkUsl.id 				
left join v024 v24 on v24.IDDKK=lekpr.CODE_SH and sl.DATE_2 between v24.DATEBEG and isnull(v24.dateend,'20991231')				
left join n020 n20 on n20.ID_LEKP=lekpr.REGNUM and sl.DATE_2 between n20.DATEBEG and isnull(n20.DATEEND,'20991231')				
				
left join KOKOD_OTD k on k.kod_otd=sl.podr				
		
join (	 select DISTINCT 			
		     CASE WHEN  sl.PODR	in ('460061206014') THEN 'ХТО2'	
		     WHEN  sl.PODR	in ('460061106006') THEN 'ХТО1'	
		     ELSE 'остальные отделения' END [отделение]	, sl.NHISTORY,  p.npolis--, 	LekPr.Code_sh,CASE when ksgkpg.N_KSG IS NULL THEN 'вмп' ELSE ksgkpg.N_KSG+' '+v23.N_KSG END
		   	FROM [D3_SCHET_OMS] sch                  			
            left join D3_PACIENT_OMS p on p.d3_scid=sch.id 
            left join D3_ZSL_OMS zsl on zsl.D3_PID=p.id and zsl.D3_SCID=sch.id	
            --SL---------------------------------------------------------------------				
            left join D3_SL_OMS sl on sl.D3_ZSLID=zsl.ID
            left join D3_KSG_KPG_OMS KsgKpg on KsgKpg.D3_SLID=sl.id		
            left join D3_CRIT_OMS Crit on Crit.D3_KSGID=ksgkpg.id		
            ----OnkSl---------------------------------------------				
            join D3_ONK_SL_OMS OnkSl on OnkSl.D3_SLID=sl.id				
            join D3_ONK_USL_OMS OnkUsl on OnkUsl.D3_ONKSLID=OnkSl.ID
            join D3_LEK_PR_OMS LekPr on LekPr.D3_ONKUSLID=OnkUsl.id 				
            left join v024 v24 on v24.IDDKK=lekpr.CODE_SH and sl.DATE_2 between v24.DATEBEG and isnull(v24.dateend,'20991231')
            left join KOKOD_OTD k on k.kod_otd=sl.podr	
            left join v023 v23 on v23.K_KSG=ksgkpg.N_KSG and sl.DATE_2 between v23.DATEBEG and isnull(v23.dateend,'20991231')		
            where 		
			YEAR(zsl.date_z_2)=2023	
			and zsl.usl_ok in (1,2)	
			and sch.code_mo =460061	
			and lekpr.REGNUM	is not null
			and onkusl.usl_tip=2	
			and sl.PODR	in ('460061106006','460061206014')			
             group by 	 CASE WHEN  sl.PODR	in ('460061206014') THEN 'ХТО2'	
		                      WHEN  sl.PODR	in ('460061106006') THEN 'ХТО1'	
		                      ELSE 'остальные отделения' END	, sl.NHISTORY,  p.npolis
             Having count(distinct LekPr.Code_sh)>1		
		) t on 	t.[отделение]=	CASE WHEN  sl.PODR	in ('460061206014') THEN 'ХТО2'	
		     WHEN  sl.PODR	in ('460061106006') THEN 'ХТО1'	
		     ELSE 'остальные отделения' END
			 and 	sl.NHISTORY=t.NHISTORY and  p.npolis=t.npolis
		where 		
			YEAR(zsl.date_z_2)=2023	
			and zsl.usl_ok in (1,2)	
			and sch.code_mo =460061	
			and lekpr.REGNUM	is not null
			and onkusl.usl_tip=2	
			and sl.PODR	in ('460061106006','460061206014')
			and lekpr.CODE_SH  like 'gemop%'
) t1
group by  [отделение]	
		    	,[схема],[ксг]