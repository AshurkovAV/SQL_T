 SELECT				
		DISTINCT		
		sch.id [idschet],zs.id,p.fam,p.im,p.ot,p.npolis,date_z_1,date_z_2,		
		sl.profil 
			
	   	,sl.ds1,iddokt
	   	,kp.fam+' '+kp.im+' '+kp.ot
	   	, rslt,v009.RMPNAME, ishod,v012.IZNAME
from
[D3_SCHET_OMS] sch			
		inner join D3_PACIENT_OMS p on p.d3_scid=sch.id		
		inner join D3_ZSL_OMS zs on zs.D3_PID=p.id		
		inner join D3_SL_OMS sl on sl.D3_ZSLID=zs.ID 
		join
		(
 SELECT				
		DISTINCT		
		sch.id,p.npolis,		
		sl.profil 
			
	   	, ds1,count(*) kol
	FROM [D3_SCHET_OMS] sch			
		inner join D3_PACIENT_OMS p on p.d3_scid=sch.id		
		inner join D3_ZSL_OMS zs on zs.D3_PID=p.id	
		inner join D3_SL_OMS sl on sl.D3_ZSLID=zs.ID	
		--LEFT JOIN [D3_USL_OMS] usl on usl.D3_SLID=sl.id 		
				
		--left join [D3_SANK_OMS] sank 		
		--		on sank.[D3_ZSLID]=zs.id
		--		and sank.s_tip=1
		left join [V006] v6 on v6.[IDUMP]=zs.usl_ok		
		LEFT JOIN v002 ON v002.IDPR=sl.PROFIL		
		left join f003 f3 on f3.mcod=sch.code_mo		
	where 			
		sch.[YEAR]=2022		
		and sch.month =12 and sch.id in (9162,9164)	
		----		
		and zs.usl_ok in (3)	
	
		and os_sluch_region is null
	
		and idsp=29	
		AND p_cel25 NOT LIKE '1.3'
	
		--AND dbo.f_digit_only(iddokt) not IN (13164550939,16221863346)
		group by sch.id,p.npolis,		
		sl.profil 
			
	   	, ds1

		having count(*)>1
		) t on t.npolis=p.npolis and sch.id=t.id and sl.profil=t.profil and sl.ds1=t.ds1
		left join v009 on v009.IDRMP=zs.rslt
		left join v012 on v012.Id=zs.ishod
		LEFT JOIN kokod_podr AS kp ON kp.IDDOCT=dbo.f_digit_only(iddokt) AND zs.usl_ok=kp.usl_ok
		where zs.usl_ok in (3)	
	
		and os_sluch_region is NULL
		--AND kp.fam IS null
		order by p.npolis, date_z_1