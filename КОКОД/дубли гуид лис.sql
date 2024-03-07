SELECT --sch.*,
sch.ID, sch.CODE, sch.[YEAR], sch.[MONTH], sch.NSCHET,
		zs.ID, zs.ZSL_ID, zs.D3_PID, zs.D3_PGID, zs.D3_SCID, zs.IDCASE,
		zs.DATE_Z_1, zs.DATE_Z_2, zs.SysDtChange
		,s.ID, s.D3_ZSLID, s.D3_ZSLGID, s.SL_ID, s.NHISTORY, s.DS1
		,u.ID, u.D3_SLID, u.D3_ZSLID, u.D3_SLGID, u.P_OTK, u.PRVS15, u.PRVS21,
		u.D3_USLGID
		
 
FROM [D3_SCHET_OMS] sch                  
 inner join D3_PACIENT_OMS p on p.d3_scid=sch.id
 inner join D3_ZSL_OMS zs on zs.D3_PID=p.id AND sch.code_mo=460061 
 --AND sch.month=5
 AND sch.YEAR=2023  
 and sch.id IN (/*9068*/ /*8909*/ /*9166*/ 9597 /*9230*/) --(8221)
  join D3_SL_OMS s on s.D3_ZSLID=zs.ID 
  JOIN D3_USL_OMS u ON u.D3_SLID=s.id


join V009 rz on rz.IDRMP=zs.RSLT
left join F011 doc on doc.Id=p.DOCTYPE
   --LEFT JOIN f003 ON f003.mcod=zs.NPR_MO
--WHERE iddokt is  NULL --AND sch.SchetType LIKE 'H'
--WHERE (ds1 NOT BETWEEN 'C00' AND 'D09.z') and ds1 NOT BETWEEN 'D45' AND 'D47.z'
left JOIN medicalServices AS ms ON ms.code_usl=u.CODE_USL AND u.DATE_IN >=ms.dataBegin AND u.DATE_OUT<=ISNULL(ms.dataEnd,'20991231') AND ms.code_usl  BETWEEN 'R01.001.008' AND 'R01.001.036'
left join Yamed_Spr_UslCode y on y.ID=u.vid_vme	

--WHERE zs.EXP_COMENT IS NOT NULL  /*LIKE '%МЭК - В СРЗ/ЦС найден след ДПФС:%'*/ --OR zs.EXP_COMENT LIKE '%ENP%' OR zs.EXP_COMENT LIKE '%vpolis%' OR zs.EXP_COMENT LIKE '%временный полис%' 
--WHERE zs.ISHOD = ''
WHERE --u.ID IN(11063283, 11609227)
--OR zs.ID = 15074407
--zs.ID IN (14389628, 15074407)
s.id IN (16384281, 17820128)
--zs.ID = 15074407    --15038794