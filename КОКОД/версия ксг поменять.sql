--значение VER_KSG не соответствует дате окончания законченного случая
		declare @p1 int = 1585
		update KsgKpg set ver_ksg=2020
		--declare @p1 int = 1585
		--select 
		--	distinct zsl.id as ID,sl.id--, zsl.sumv as SUMV, '' com, p.fam,KsgKpg.ver_ksg,YEAR(zsl.date_z_2),year(sl.date_2)
		FROM [D3_SCHET_OMS] sch                  
			inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
				inner join D3_ZSL_OMS zsl on zsl.D3_PID=p.id and zsl.D3_SCID=sch.id
						inner join D3_SL_OMS sl on sl.D3_ZSLID=zsl.ID
							inner join D3_KSG_KPG_OMS KsgKpg on KsgKpg.D3_SLID=sl.id
		where 
			p.D3_SCID = @p1	
			---------------
			and ( KsgKpg.ver_ksg <>YEAR(sl.date_2))
			
--			 or zsl.id in (1268620,
--1270163))