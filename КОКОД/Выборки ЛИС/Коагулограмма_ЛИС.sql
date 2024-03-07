--коагулограмма B03.005.006
	
--BEGIN TRAN 
--commit tran
--INSERT INTO tmp_D3_USL_OMS_koagul 			
SELECT f003.nam_mok, 
	npolis, 
	sch.id AS schid_old,
	p.fam,
	p.im,
	p.ot,
	p.dr,
	p.ID D3_PID,
	sch.id AS sch_id, 
	--usl.VID_VME,
	zs.ISHOD,
	usl.D3_SLID,
	usl.D3_ZSLID,
	usl.D3_SLGID,
	usl.IDSERV,
	usl.LPU,
	usl.PROFIL,
	usl.VID_VME,
	usl.DET,
	usl.DATE_IN,
	usl.DATE_OUT,
	usl.DS,
	usl.CODE_USL,
	usl.KOL_USL,
	usl.SUMV_USL,
	usl.PRVS,
	usl.CODE_MD,
	usl.VERS_SPEC,
	usl.PRVS_VERS	
	
FROM	   D3_SCHET_OMS sch                  
inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
								and sch.year=2022 
							    and sch.month=9 
							    AND sch.id IN (8516)
inner join D3_ZSL_OMS zs on zs.D3_PID=p.id  and zs.D3_SCID=sch.id --and zs.usl_ok in (1,2) --AND zs.id=20906231
join	   D3_SL_OMS s on s.D3_ZSLID=zs.ID 
JOIN	   d3_usl_oms usl ON usl.D3_SLID=s.id
left join  Yamed_Spr_UslCode u on u.id=usl.vid_vme
LEFT JOIN  f003 ON f003.mcod=zs.NPR_MO

WHERE usl.VID_VME = 'B03.005.006'

--ORDER BY fam, im, ot

/*
SELECT *
FROM tmp_D3_USL_OMS_koagul
*/


SELECT  *
FROM D3_USL_OMS usl 
WHERE usl.D3_SLID = 11862170
--FOR UPDATE 


--BEGIN TRAN 
/*UPDATE D3_USL_OMS 
SET TARIF = NULL,
	sumv_usl = 0.00
WHERE D3_SLID = 11862170	
*/
--commit tran

