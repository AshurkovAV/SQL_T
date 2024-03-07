--update sl set sl.COMENTSL=''
select zsl.id,p.fam,code_usl, sl.COMENTSL, ysu.NameWithID
FROM D3_PACIENT_OMS p
			inner join D3_ZSL_OMS zsl on zsl.D3_PID=p.id 
				inner join D3_SL_OMS sl on sl.D3_ZSLID=zsl.ID
				 JOIN d3_usl_oms usl ON usl.D3_SLID=sl.id
				 LEFT JOIN Yamed_Spr_Usl804 AS ysu ON ysu.ID=usl.vid_vme
				 WHERE zsl.ID IN (6785961,
6788127,
6788264,
6794317,
6797424,
6783919,
6785701,
6796957,
6798229,
6785243,
6793138,
6795667,
6798465,
6784251,
6785766,
6786418,
6794277,
6786147,
6793434) --AND fam LIKE  'Гончарова'
ORDER BY p.fam