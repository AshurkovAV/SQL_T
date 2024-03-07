select	DISTINCT	s.iddokt, ds1,
		kp.fam+' '+kp.im+' '+kp.ot vrach,p.fam, p.im,p.ot,p.dr,p.NPOLIS,  date_1		
					
		FROM [D3_SCHET_OMS] sch			
			inner join D3_PACIENT_OMS p on p.d3_scid=sch.id		
			inner join D3_ZSL_OMS zs on zs.D3_PID=p.id		
			 join D3_SL_OMS s on s.D3_ZSLID=zs.ID
			LEFT JOIN (select DISTINCT * from kokod_podr WHERE usl_ok=3 ) AS kp ON kp.IDDOCT=dbo.f_digit_only(iddokt) AND zs.usl_ok=kp.usl_ok
				
		where 			
			sch.[YEAR]=2023	
			and sch.month =7 AND sch.id IN (15046)		
			----		
			and zs.usl_ok in (3)		
		
			and os_sluch_region=40
			AND zs.idsp IN (29,30)		
			--AND date_z_2 BETWEEN '20220601' AND '20220630'	
			--AND dbo.f_digit_only(iddokt)  IN (15577536404)
		-- GROUP BY s.iddokt, kp.fam+' '+kp.im+' '+kp.ot, p.fam, p.im,p.ot,p.dr,p.NPOLIS	