
      
--WITH perv AS (
	SELECT t1.*
	INTO perv_neonko_200622_22
	from
	--неонко диагнозы
	(
		select	distinct p.fam,p.im,p.ot,p.dr,isnull(p.NPOLIS,p.ENP) npolis--,  MIN(date_z_1) date_min
		FROM [D3_SCHET_OMS] sch			
			inner join D3_PACIENT_OMS p on p.d3_scid=sch.id		
			inner join D3_ZSL_OMS zs on zs.D3_PID=p.id		
			join D3_SL_OMS s on s.D3_ZSLID=zs.ID
			--LEFT JOIN kokod_podr AS kp ON kp.IDDOCT=dbo.f_digit_only(s.iddokt) AND kp.usl_ok=3
		where 
			zs.usl_ok in (3)		
			and idsp in (29,30)
			and os_sluch_region is null
			AND date_z_2 BETWEEN '20220101' AND '20221231'	
			AND 
				 (ds1 not BETWEEN 'C00' AND 'D09' 
							 AND 
				 ds1 not BETWEEN 'D45' AND 'D47%'
				 ) 
				
			 
		-- GROUP BY  p.im,p.ot,p.dr,isnull(p.NPOLIS,p.ENP)
		) t1			
		--					
		LEFT JOIN 	
		--onko	так и не стало до конца (до текущего момента)
			(select DISTINCT		
					p.fam, p.im,p.ot,p.dr,p.npolis	
					FROM [D3_SCHET_OMS] sch			
						inner join D3_PACIENT_OMS p on p.d3_scid=sch.id		
						inner join D3_ZSL_OMS zs on zs.D3_PID=p.id		
						join D3_SL_OMS s on s.D3_ZSLID=zs.ID
			     	where	 date_z_1 >'20220101' --AND p.npolis='4658040826000302'
			     	      AND 
							 (ds1 BETWEEN 'C00' AND 'D09' 
										 OR
							 ds1 BETWEEN 'D45' AND 'D47%'
							 ) 
			) t2 
			ON t2.npolis = t1.npolis OR (t2.fam = t1.fam AND t2.im=t1.im AND t1.ot=t2.ot AND t1.dr=t2.dr)		
		
WHERE t2.npolis is null		
    --  )	
      
  ---    
SELECT t1.*,t2.name, t2.kol_vo_usl 
FROM perv_neonko_200622_22 t1
LEFT JOIN 
(Select DISTINCT  p.fam,p.im,isnull(p.ot,'') ot,p.dr,p.npolis, ms.name, COUNT(DISTINCT s.NHISTORY) [kol_vo_usl]
 FROM [D3_SCHET_OMS] sch                  
 inner join D3_PACIENT_OMS p on p.d3_scid=sch.id
 inner join D3_ZSL_OMS zs on zs.D3_PID=p.id AND sch.code_mo=460061 
  join D3_SL_OMS s on s.D3_ZSLID=zs.ID AND 
				 (ds1 not BETWEEN 'C00' AND 'D09' 
							 AND 
				 ds1 not BETWEEN 'D45' AND 'D47%'
				 ) 
  JOIN D3_USL_OMS u ON u.D3_SLID=s.id AND (u.CODE_USL LIKE 'R01.001.001%' OR u.CODE_USL LIKE 'R01.001.002%')
LEFT JOIN f003 ON f003.mcod=zs.NPR_MO
--WHERE iddokt is  NULL --AND sch.SchetType LIKE 'H'
--WHERE (ds1 NOT BETWEEN 'C00' AND 'D09.z') and ds1 NOT BETWEEN 'D45' AND 'D47.z'
 JOIN medicalServices AS ms ON ms.code_usl=left(u.CODE_USL,11) AND u.DATE_IN >=ms.dataBegin AND u.DATE_OUT<=ISNULL(ms.dataEnd,'20991231') 
 WHERE p.npolis IN (SELECT npolis FROM perv_neonko_200622_22)
 GROUP BY p.fam,p.im,isnull(p.ot,'') ,p.dr,p.npolis, ms.name
	)    t2 ON  t2.npolis = t1.npolis OR (t2.fam = t1.fam AND t2.im=t1.im AND t1.ot=t2.ot AND t1.dr=t2.dr)	 

---
SELECT t1.*,t2.name, t2.kol_vo_usl 
FROM perv_neonko_200622 t1
LEFT JOIN 
(Select DISTINCT  p.fam,p.im,isnull(p.ot,'') ot,p.dr,p.npolis, ms.name, COUNT(DISTINCT s.NHISTORY) [kol_vo_usl]
 FROM [D3_SCHET_OMS] sch                  
 inner join D3_PACIENT_OMS p on p.d3_scid=sch.id
 inner join D3_ZSL_OMS zs on zs.D3_PID=p.id AND sch.code_mo=460061 
  join D3_SL_OMS s on s.D3_ZSLID=zs.ID AND 
				 (ds1 not BETWEEN 'C00' AND 'D09' 
							 AND 
				 ds1 not BETWEEN 'D45' AND 'D47%'
				 ) 
  JOIN D3_USL_OMS u ON u.D3_SLID=s.id AND (u.CODE_USL LIKE 'R01.001.001%' OR u.CODE_USL LIKE 'R01.001.002%')
LEFT JOIN f003 ON f003.mcod=zs.NPR_MO
--WHERE iddokt is  NULL --AND sch.SchetType LIKE 'H'
--WHERE (ds1 NOT BETWEEN 'C00' AND 'D09.z') and ds1 NOT BETWEEN 'D45' AND 'D47.z'
 JOIN medicalServices AS ms ON ms.code_usl=left(u.CODE_USL,11) AND u.DATE_IN >=ms.dataBegin AND u.DATE_OUT<=ISNULL(ms.dataEnd,'20991231') 
 WHERE p.npolis IN (SELECT npolis FROM perv_neonko_200622)
 GROUP BY p.fam,p.im,isnull(p.ot,'') ,p.dr,p.npolis, ms.name
	)    t2 ON  t2.npolis = t1.npolis OR (t2.fam = t1.fam AND t2.im=t1.im AND t1.ot=t2.ot AND t1.dr=t2.dr)	


--SELECT * FROM  medicalServices 