WITH t3 as(			
		--кто был у врача в этом мес, но не был ранее в нашей мо				
		SELECT distinct t1.*	, CASE WHEN t2.npolis is null	THEN 1 ELSE 0 END pr_perv	
		FROM			
		(select	DISTINCT	s.iddokt,	
		kp.fam+' '+kp.im+' '+kp.ot vrach,p.fam, p.im,p.ot,p.dr,p.NPOLIS,date_z_2
		-- min(date_1) date_1		
					
		FROM [D3_SCHET_OMS] sch			
			inner join D3_PACIENT_OMS p on p.d3_scid=sch.id		
			inner join D3_ZSL_OMS zs on zs.D3_PID=p.id		
			 join D3_SL_OMS s on s.D3_ZSLID=zs.ID
			LEFT JOIN (select DISTINCT * from kokod_podr WHERE usl_ok=3 ) AS kp ON kp.IDDOCT=dbo.f_digit_only(iddokt) AND zs.usl_ok=kp.usl_ok
				
		where 			
			sch.[YEAR]=2022		
			and sch.month =7-- AND sch.id IN (2782,2783,2784)		
			----		
			and zs.usl_ok in (3)		
		
			and os_sluch_region is null
			AND zs.idsp IN (29,30)		
			AND date_z_2 BETWEEN '20220701' AND '20220731'	
			--AND dbo.f_digit_only(iddokt)  IN (15577536404)
		-- GROUP BY s.iddokt, kp.fam+' '+kp.im+' '+kp.ot, p.fam, p.im,p.ot,p.dr,p.NPOLIS	
		) t1			
		
			LEFT JOIN 		
			(select DISTINCT		
		p.fam, p.im,p.ot,p.dr,p.npolis--, date_1			
					
		FROM [D3_SCHET_OMS] sch			
			inner join D3_PACIENT_OMS p on p.d3_scid=sch.id		
			inner join D3_ZSL_OMS zs on zs.D3_PID=p.id		
			
			
		where 			
			 date_z_1 <'20220701' and year(date_z_2)=2022 ) t2 ON t2.npolis = t1.npolis OR (t2.fam = t1.fam AND t2.im=t1.im AND t1.ot=t2.ot AND t1.dr=t2.dr)		
		--WHERE t2.npolis is null	
)



SELECT DISTINCT * 
FROM t3
--	--вычитаю тех, кто из них был ранее, но не у нее в августе		
					
--LEFT JOIN 
--(select	DISTINCT		
--		p.fam, p.im,p.ot,p.dr,p.npolis, DATE_1		
					
--		FROM [D3_SCHET_OMS] sch			
--			inner join D3_PACIENT_OMS p on p.d3_scid=sch.id		
--			inner join D3_ZSL_OMS zs on zs.D3_PID=p.id		
--			 join D3_SL_OMS s on s.D3_ZSLID=zs.ID
		
				
--		where 			
--			sch.[YEAR]=2021		
--			and sch.month =8	
--			----		
--			and zs.usl_ok in (3)		
			
--			AND date_z_2 BETWEEN '20210801' AND '20210831'	
--			AND dbo.f_digit_only(iddokt) not IN (15577536404)	
--		) t4	ON (t3.npolis = t4.npolis OR (t3.fam = t4.fam AND t3.im=t4.im AND t3.ot=t4.ot AND t3.dr=t4.dr)	)
--		           AND t4.date_1<t3.date_1	
--		WHERE t4.npolis is null			
					
					
	
