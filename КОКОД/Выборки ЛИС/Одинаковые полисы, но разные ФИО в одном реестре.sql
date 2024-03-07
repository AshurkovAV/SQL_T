--Одинаковые полисы, но разные ФИО

SELECT p.fam, p.im, isnull(p.ot,''), p.DR as [Дата рождения], p.VPOLIS, p.SPOLIS, p.NPOLIS, p.enp, p.SMO
FROM [D3_SCHET_OMS] sch                  
 inner join D3_PACIENT_OMS p on p.d3_scid=sch.id and sch.year=2023 AND sch.id IN (12839)
 inner join D3_ZSL_OMS zs on zs.D3_PID=p.id  -- AND and sch.year=2023 and sch.id in (12839)
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID 
 JOIN D3_USL_OMS u ON u.D3_SLID=s.id
 join V009 rz on rz.IDRMP=zs.RSLT
 left join F011 doc on doc.Id=p.DOCTYPE
 LEFT JOIN f003 ON f003.mcod=zs.NPR_MO
 LEFT  JOIN medicalServices AS ms ON ms.code_usl=u.CODE_USL AND u.DATE_IN >=ms.dataBegin AND u.DATE_OUT<=ISNULL(ms.dataEnd,'20991231') AND ms.code_usl  BETWEEN 'R01.001.008' AND 'R01.001.036'
 left join Yamed_Spr_UslCode y on y.ID=u.vid_vme	
 JOIN 
	(SELECT distinct p.fam, p.im, p.ot, p.DR, p.VPOLIS, p.SPOLIS, p.NPOLIS, p.enp, p.SMO
	 FROM [D3_SCHET_OMS] sch                  
	 inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
		                            and sch.year=2023 AND sch.id IN (12839)
     inner join D3_ZSL_OMS zs on zs.D3_PID = p.id  and zs.[D3_SCID ] = sch.id    
	 join D3_SL_OMS s on s.D3_ZSLID = zs.ID 
	 JOIN d3_usl_oms usl ON usl.D3_SLID = s.id
	 JOIN medicalServices AS ms ON ms.code_usl = usl.CODE_USL AND usl.DATE_IN >= ms.dataBegin AND usl.DATE_OUT <= ISNULL(ms.dataEnd,'20221231')
     --where p.fam LIKE 'Воротн%'		
	 GROUP BY p.fam, p.im, p.ot, p.DR, p.VPOLIS, p.SPOLIS, p.NPOLIS, p.enp, p.SMO
	 --ORDER BY p.fam, p.im
	 --HAVING COUNT(*)>1
	) t  ON p.NPOLIS = t.NPOLIS 
	--ON p.fam = t.fam AND p.im = t.im AND p.ot = t.ot
--WHERE p.fam LIKE 'Воротн%'	

WHERE p.fam <> t.fam 
  AND p.im <> t.im 
  AND p.ot <> t.ot
  AND p.NPOLIS <> ''
  AND p.NPOLIS <> '1111111111111111'
  AND p.NPOLIS <> '0000000000000000'
GROUP BY p.fam, p.im, p.ot, p.DR, p.VPOLIS, p.SPOLIS, p.NPOLIS, p.enp, p.SMO  

