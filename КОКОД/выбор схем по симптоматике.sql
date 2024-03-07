	select DISTINCT --nhistory,zsl.USL_OK,p.NPOLIS, sch.[MONTH]
	
	
	year,--sch.month,--,sch.NSCHET,										
	--sl.id,onkusl.id as onk_id,	
	MONTH(date_z_2) AS [Месяц лечения],
	k.name,									
	P.w,										
	p.npolis,										
	--f2.nam_smok,										
	--sch.year,sch.month,										
	cast (zsl.USL_OK as nvarchar)+ ' '+v6.UMPNAME usl_ok,										
	cast(sl.DATE_1 as date) DATE_1,cast(sl.DATE_2 as date)DATE_2,										
	sl.NHISTORY,										
	sl.DS1,										
	--m.ds_name,										
	case when zsl.VIDPOM=32 then 'ВМП' ELSE 'КСГ' end names,										
	case when  KsgKpg.N_KSG is not null then   KsgKpg.N_KSG 										
										
	end namess										
	,										
	--v23.N_KSG,										
	sl.sum_m,										
	OnkUsl.usl_tip,										
	n013.TLech_NAME,										
	--,										
	lekpr.CODE_SH,										
	v24.DKKNAME										
	 ,STUFF((										
	 SELECT '; '+ n2.MNN +' - '+ cast(cast (lek.DATE_INJ as date) as nvarchar)+';' 										
	 FROM D3_LEK_PR_OMS Lek										
      left join n020 n2 on n2.ID_LEKP=lek.REGNUM AND YEAR(n2.DATEBEG)=2020--and sl.DATE_2 between n2.DATEBEG and isnull(n2.DATEEND,'20991231') 											
	  WHERE  Lek.D3_ONKUSLID=OnkUsl.id 										
	  --and lek.id=lekpr.id										
	  FOR XML PATH(''), TYPE).value('.','varchar(max)'),1,1,' ') [dv]										
	--,n20.MNN +' - '+ cast(cast (lekpr.DATE_INJ as date) as nvarchar)+';' as dv										
	--lekpr.DATE_INJ,										
	--,zsl.SANK_IT,										
	,OnkSl.WEI масса,										
	 OnkSl.HEI рост,										
	 onksl.bsa	[Площадь поверхности тела (м2)],
	 zsl.kd_z									
											
	--into   ztemp_onko_kokod*/										
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
left join D3_NAPR_OMS napr on napr.D3_SLID=Sl.id 											
left join D3_CONS_OMS cons on cons.d3_slid=sl.id 											
left join D3_NAZ_OMS Naz on Naz.D3_SLID=sl.ID											
left join M001_oplata_status m on m.idds=sl.ds1 --and m.ACTUAL=1											
----OnkSl---------------------------------------------											
left join D3_ONK_SL_OMS OnkSl on OnkSl.D3_SLID=sl.id 											
left join D3_B_DIAG_OMS BDiag on BDiag.D3_ONKSLID=OnkSl.ID 											
left join D3_B_PROT_OMS BProt on BProt.D3_ONKSLID=OnkSl.ID 											
left join D3_ONK_USL_OMS OnkUsl on OnkUsl.D3_ONKSLID=OnkSl.ID 											
left join N013 n013 on n013.id_tlech=Onkusl.usl_tip											
left join D3_LEK_PR_OMS LekPr on LekPr.D3_ONKUSLID=OnkUsl.id 											
left join n020 n20 on n20.ID_LEKP=lekpr.REGNUM and sl.DATE_2 between n20.DATEBEG and isnull(n20.DATEEND,'20991231')											
left join D3_KSG_KPG_OMS KsgKpg on KsgKpg.D3_SLID=sl.id											
left join v023 v23 on v23.K_KSG=ksgkpg.N_KSG and sl.DATE_2 between v23.DATEBEG and isnull(v23.dateend,'20991231')											
											
left join D3_SL_KOEF_OMS SlKoef on SlKoef.D3_KSGID=KsgKpg.ID											
left join D3_CRIT_OMS Crit on Crit.D3_KSGID=ksgkpg.id											
left join v024 v24 on v24.IDDKK=lekpr.CODE_SH and sl.DATE_2 between v24.DATEBEG and isnull(v24.dateend,'20991231')											
left join D3_USL_OMS usl on sl.id=usl.D3_SLID		
left join KOKOD_OTD k on k.kod_otd=sl.podr									
left JOIN D3_SANK_OMS AS sa ON sa.D3_ZSLID=zsl.id AND s_tip=1											
---------------------------------------------------------------------------											
		
		where 									
		(	ksgkpg.N_KSG IN ('st36.012','ds36.006')		
		     AND 	 OnkUsl.USL_TIP IN (2)					
			and YEAR>=2023																
			and sch.month between 5 and 9		
			AND YEAR(zsl.DATE_Z_2)=2023-- AND MONTH(zsl.DATE_Z_2) BETWEEN  AND 12-- период оказания						
																	  
			)								
			and zsl.usl_ok in (2)	AND LekPr.CODE_SH LIKE 'sh9003'								
			and sch.code_mo='460061'								
		