--Ó·ÌÓ‚ËÚ¸ —Õ»À— ‚‡˜‡
UPDATE usl
   SET CODE_MD  = '199-802-041 07'

/*SELECT DISTINCT  f003.nam_mok, npolis, sch.id AS schid_old,p.fam,p.im,p.ot,p.dr,
--zs.id izslid, s.id slid,p.ID D3_PID
--INTO ztemp_lis_dnr_072022
				sch.id AS sch_id, zs.id AS zs_id, usl.CODE_USL, usl.VID_VME /*,ms.ishod*/,zs.ISHOD,
				usl.D3_ZSLID		--, usl
				,usl.CODE_MD
*/
FROM	   [D3_SCHET_OMS] sch                  
inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
								and sch.year=2022 
							    and sch.month=9 
							    AND sch.id IN (8501)
inner join D3_ZSL_OMS zs on zs.D3_PID=p.id  and zs.[D3_SCID]=sch.id --and zs.usl_ok in (1,2) --AND zs.id=20906231
join	   D3_SL_OMS s on s.D3_ZSLID=zs.ID 
JOIN	   d3_usl_oms usl ON usl.D3_SLID=s.id
left join  Yamed_Spr_UslCode u on u.id=usl.vid_vme
LEFT JOIN  f003 ON f003.mcod=zs.NPR_MO

WHERE 
	f003.nam_mok = 'Œ¡”« " ”–— ¿ﬂ √Œ–¡ŒÀ‹Õ»÷¿ π2"'
	AND usl.CODE_MD LIKE '199%'
	--AND usl.CODE_MD = '123--95-5-3 63'
	--AND p.fam = '«‚ÓÌ‡∏‚‡'
--ORDER BY fam, im, ot