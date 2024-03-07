			
declare @p1 int =873			
Select --distinct zs.ID, zs.SUMV,'' com
--при лечении онкозаболеваний стоит 
 sch.id, sch.schettype,zs.ID, zs.SUMV,'' com ,s.nhistory,ksg.n_ksg,v023.NameWithID,DS1_T			
FROM [D3_SCHET_OMS] sch			
join D3_PACIENT_OMS p on p.d3_scid=sch.id 			
			and sch.year=2021 AND sch.month=11-- sch.id in (2840,2843,2844)
			--and sch.id=@p1
join D3_ZSL_OMS zs on zs.D3_PID=p.id AND zs.usl_ok IN (1,2) --AND p.smo=46006			
join D3_SL_OMS s on s.D3_ZSLID=zs.ID			
left join D3_KSG_KPG_OMS ksg on ksg.D3_SLID=s.id			
left join D3_ONK_SL_OMS onk on onk.D3_SLID=s.id--	AND DS1_T IN (0,1,2)		
--left join D3_ONK_USL_OMS ou on ou.D3_ONKSLID=onk.id			
left join v023 on v023.K_KSG=ksg.n_ksg and s.date_2 between v023.DATEBEG and isnull(v023.DATEEND,'20201231')			
where ds_onk=1 			
----group by zs.ID, zs.SUMV,s.nhistory,ksg.n_ksg,v023.NameWithID			
--and (
--            (
--                      (ksg.n_ksg like 'st19%' 
--			          or ksg.n_ksg like 'st08%'
--		            	or ksg.n_ksg like 'ds08%'
--			           or ksg.n_ksg like 'ds19%')
--                                      and v023.[N_KSG] not like '%замена порт системы%'
--			 ) 
			 
			 --or zs.vidpom=32 
			 --)
			 --700136