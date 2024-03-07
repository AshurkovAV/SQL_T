select 
	DISTINCT sch.id, zsl.id as ID, zsl.sumv as SUMV, '' com,ksgkpg.SL_K, ksgkpg.IT_SL, dsko.* 
FROM [D3_SCHET_OMS] sch                  
	left join D3_PACIENT_OMS p on p.d3_scid=sch.id 
		left join D3_ZSL_OMS zsl on zsl.D3_PID=p.id and zsl.D3_SCID=sch.id
			left join D3_SL_OMS sl on sl.D3_ZSLID=zsl.ID
				left join D3_KSG_KPG_OMS KsgKpg on KsgKpg.D3_SLID=sl.id 
				LEFT JOIN D3_SL_KOEF_OMS AS dsko
				         ON dsko.D3_KSGID = KsgKpg.ID
WHERE sch.id=171 AND dsko.IDSL=91