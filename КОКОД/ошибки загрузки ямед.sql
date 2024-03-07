--BEGIN TRAN --commit tran
--UPDATE sl SET kd=NULL
--UPDATE zs SET kd_z=NULL
SELECT distinct zs.id AS zslid, p.id pid, zsl_id, p.smo, p.VPOLIS, p.npolis, p.docser, p.docnum, p.docorg, p.docdate, p.doctype, sl.P_PER, sl.P_CEL25, kd_z, kd, sump, oplata, zs.usl_ok
--INTO temp_udal_336?
FROM [D3_SCHET_OMS] sch													
		inner join D3_PACIENT_OMS p on p.d3_scid=sch.id											
		inner join D3_ZSL_OMS zs on zs.D3_PID=p.id	
INNER JOIN D3_SL_OMS AS sl
          ON sl.D3_ZSLID = zs.ID
--join V009 rz on rz.IDRMP=zs.RSLT
--left join F011 doc on doc.Id=p.DOCTYPE
--LEFT JOIN f003 ON f003.mcod=zs.NPR_MO
--WHERE iddokt is  NULL --AND sch.SchetType LIKE 'H'
--WHERE (ds1 NOT BETWEEN 'C00' AND 'D09.z') and ds1 NOT BETWEEN 'D45' AND 'D47.z'
--left JOIN medicalServices AS ms ON ms.code_usl=u.CODE_USL AND u.DATE_IN >=ms.dataBegin AND u.DATE_OUT<=ISNULL(ms.dataEnd,'20991231') AND ms.code_usl  BETWEEN 'R01.001.008' AND 'R01.001.036'
--left join Yamed_Spr_UslCode y on y.ID=u.vid_vme	
--LEFT JOIN temp_mur_8_2038 AS tm ON tm.
WHERE sch.id=9040 AND zs.USL_OK NOT IN  (1,2) AND (sl.kd IS NOT NULL OR zs.kd_z IS not NULL)


--select * from temp_mur_8_2038 WHERE D3_SCID=8644,