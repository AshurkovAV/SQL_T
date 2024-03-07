
      
--WITH perv AS (
	SELECT t1.*
	INTO temp_pervich_app_2023_1_3
	from
	
	(
		select	DISTINCT		
				--kp.fam+' '+kp.im+' '+kp.ot [врач приема],
				p.fam,p.im,p.ot,p.dr,isnull(p.NPOLIS,p.ENP) npolis,  MIN(date_z_1) date_min
		FROM [D3_SCHET_OMS] sch			
			inner join D3_PACIENT_OMS p on p.d3_scid=sch.id		
			inner join D3_ZSL_OMS zs on zs.D3_PID=p.id		
			join D3_SL_OMS s on s.D3_ZSLID=zs.ID
			--LEFT JOIN kokod_podr AS kp ON kp.IDDOCT=dbo.f_digit_only(s.iddokt) AND kp.usl_ok=3
		where 
			zs.usl_ok in (3)		
			and idsp in (29,30)
			and os_sluch_region is null
			AND date_z_2 BETWEEN '20230101' AND '20230331'	
			AND s.ds1 LIKE 'C%'
		
		GROUP BY
		-- kp.fam+' '+kp.im+' '+kp.ot,
		 p.fam, p.im,p.ot,p.dr,isnull(p.NPOLIS,p.ENP)
		) t1			
		--					
		LEFT JOIN 		
			(select DISTINCT		
					p.fam, p.im,p.ot,p.dr,p.npolis	
					FROM [D3_SCHET_OMS] sch			
						inner join D3_PACIENT_OMS p on p.d3_scid=sch.id		
						inner join D3_ZSL_OMS zs on zs.D3_PID=p.id		
			     	where	 date_z_1 <'20230101'
			) t2 
			ON t2.npolis = t1.npolis OR (t2.fam = t1.fam AND t2.im=t1.im AND t1.ot=t2.ot AND t1.dr=t2.dr)		
		
--WHERE t2.npolis is null		
      --)	
      
      
--SELECT * 
--FROM perv_160822 
     

