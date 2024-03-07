
SELECT distinct sch.id,zs.zsl_id,  p.smo,p.fam,p.im,p.ot,p.dr,p.npolis,p.[ID_PAC],  s.nhistory, s.date_2,p.DOCORG ,p.DOCDATE--,sch.schettype,zs.id,s.SL_ID,s.TARIF,s.PROFIL,s.P_CEL25,zs.SUMV,s.NHISTORY,p.DOCDATE,p.DOCORG--,s.nhistory,case when p.smo LIKE '46%' THEN p.smo ELSE 'in' END smo,		
--s.nhistory,p.fam, p.im, p.ot, p.dr, zs.vozr,p.npolis, zs.date_z_2,usl.code_usl,--,	usl.VID_VME	,usl.DATE_IN,
--zs.RSLT,v009.RMPNAME,dso.s_com	, dso.s_osn	,zs.sumv,zs.sump,zs.usl_ok,s.P_CEL25, s.P_CEL,ds1--,usl.code_usl,usl.vid_vme
	FROM [D3_SCHET_OMS] sch	
		inner join D3_PACIENT_OMS p on p.d3_scid=sch.id
		inner join D3_ZSL_OMS zs on zs.D3_PID=p.id --AND zs.id=26661054

		inner join d3_sl_oms s on s.D3_ZSLID=zs.id
		--LEFT JOIN D3_USL_OMS AS usl ON usl.D3_SLID=s.id 
WHERE sch.code_mo=460061 AND 
sch.year=2020 AND sch.month=4 
--and sch.id in (308) 
AND p.VPOLIS<>3 AND   (p.DOCORG IS NULL OR p.DOCDATE is NULL)  --AND p.smo=46007-- (s.SL_ID LIKE '9E7C5FB3-8672-1B9C-E053-350AA8C084F0'--s.TARIF IS null
--GROUP BY sch.schettype--,sch.month