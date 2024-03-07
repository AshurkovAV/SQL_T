		--значение VER_KSG не соответствует дате окончания законченного случая
	UPDATE KsgKpg SET KsgKpg.ver_ksg=YEAR(zsl.date_z_2)
		--declare @p1 int = 190
		--select 
		--	distinct zsl.id as ID, zsl.sumv as SUMV, '' com,KsgKpg.ver_ksg ,YEAR(zsl.date_z_2)
		FROM [D3_SCHET_OMS] sch                  
			inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
				inner join D3_ZSL_OMS zsl on zsl.D3_PID=p.id and zsl.D3_SCID=sch.id
						inner join D3_SL_OMS sl on sl.D3_ZSLID=zsl.ID
							inner join D3_KSG_KPG_OMS KsgKpg on KsgKpg.D3_SLID=sl.id
		where 
			p.D3_SCID in (190,191)
			---------------
			and KsgKpg.ver_ksg <>YEAR(zsl.date_z_2)