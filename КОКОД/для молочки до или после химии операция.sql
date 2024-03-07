											
	select DISTINCT --nhistory,zsl.USL_OK,p.NPOLIS, sch.[MONTH]
	
	
	year,sch.month,nhistory, p.fam, p.im, p.ot, p.dr,									
	cast (zsl.USL_OK as nvarchar)+ ' '+v6.UMPNAME usl_ok,										
	cast(sl.DATE_1 as date) DATE_1,cast(sl.DATE_2 as date)DATE_2,										
							
	case when  KsgKpg.N_KSG is not null then   KsgKpg.N_KSG 										
	else v018.hvidname										
	end namess,
	
	y.NameWithID,
	date_in  'date_oper'										
	--, onkusl.usl_tip						
	--, LekPr.CODE_SH
	,MIN(LekPr.DATE_INJ) 'DATE_HIM'	,	
	CASE WHEN DATE_IN -	MIN(LekPr.DATE_INJ) <0 THEN 'POSLE'	
	     WHEN DATE_IN -	MIN(LekPr.DATE_INJ) >0 THEN 'DO'	
	     WHEN DATE_IN -	MIN(LekPr.DATE_INJ) =0 THEN 'VMESTE'	
	     ELSE 'NET INFO V REESTRE O HIM'
	     END		
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
join D3_ONK_SL_OMS OnkSl on OnkSl.D3_SLID=sl.id 											
--left join D3_B_DIAG_OMS BDiag on BDiag.D3_ONKSLID=OnkSl.ID 											
--left join D3_B_PROT_OMS BProt on BProt.D3_ONKSLID=OnkSl.ID 											
 join D3_ONK_USL_OMS OnkUsl on OnkUsl.D3_ONKSLID=OnkSl.ID 											
left join N013 n013 on n013.id_tlech=Onkusl.usl_tip											
left join D3_LEK_PR_OMS LekPr on LekPr.D3_ONKUSLID=OnkUsl.id 											
left join n020 n20 on n20.ID_LEKP=lekpr.REGNUM and sl.DATE_2 between n20.DATEBEG and isnull(n20.DATEEND,'20991231')											
left join D3_KSG_KPG_OMS KsgKpg on KsgKpg.D3_SLID=sl.id											
left join v023 v23 on v23.K_KSG=ksgkpg.N_KSG and sl.DATE_2 between v23.DATEBEG and isnull(v23.dateend,'20991231')											
											
left join D3_SL_KOEF_OMS SlKoef on SlKoef.D3_KSGID=KsgKpg.ID											
--left join D3_CRIT_OMS Crit on Crit.D3_KSGID=ksgkpg.id											
--left join v024 v24 on v24.IDDKK=lekpr.CODE_SH and sl.DATE_2 between v24.DATEBEG and isnull(v24.dateend,'20991231')											
left join D3_USL_OMS usl on sl.id=usl.D3_SLID											
--left JOIN D3_SANK_OMS AS sa ON sa.D3_ZSLID=zsl.id AND s_tip=1											
---------------------------------------------------------------------------											
left join[V019] v019 on cast(v019.IDHM as int)=sl.metod_hmp  											
				   --------------------------------с 21 года----------------							
				                              and 							
											cast(case when year(zsl.date_z_2)=2020 then v019.IDMODP else  sl.MP_HMP end as nvarchar) =cast(v019.IDMODP as nvarchar)
											and sl.VID_HMP=HVID
											-- метод ВМП-- метод ВМП
									   AND zsl.DATE_z_2>=v019.DATEBEG		
									   AND zsl.DATE_z_2<=isnull(v019.dateend,'21000101')		
				   left join v018 v018 on v019.HVID=V018.idhvid                                 -- вид ВМП							
									   AND zsl.DATE_z_2>=V018.DATEBEG		
									   AND zsl.DATE_z_2<=isnull(v018.dateend,'21000101')		

left join Yamed_Spr_UslCode y on y.ID=usl.code_usl
	
		where 									
		
			
			 YEAR(date_z_2)=2021							
										
			and zsl.usl_ok in (1)	
			AND zsl.VIDPOM=32							
			--and sch.SchetType like '%C%'								
			and sch.code_mo='460061'	
			AND sl.podr LIKE '460061106002'	
			AND sl.METOD_HMP=1080	
			 AND sch.id in (Select 
				--sch.month,nschet,
				id

				FROM [D3_SCHET_OMS] sch  
				WHERE YEAR>=2021  AND sch.nschet LIKE '%сдан%'
				)	
				AND (code_usl not LIKE 'A08.30.013'	AND usl.CODE_USL not LIKE 'A11.12.003')			
			--AND usl_tip=2
	GROUP BY year,sch.month,nhistory, p.fam, p.im, p.ot, p.dr,									
	cast (zsl.USL_OK as nvarchar)+ ' '+v6.UMPNAME ,										
	cast(sl.DATE_1 as date) ,cast(sl.DATE_2 as date),										
							
	case when  KsgKpg.N_KSG is not null then   KsgKpg.N_KSG 										
	else v018.hvidname										
	end ,
	
	y.NameWithID,
	date_in  