select
	sch.id,sl.podr,k. [name],p.fam,p.im,p.ot,p.dr,sl.ds1,sl.NHISTORY,DATE_Z_1,DATE_Z_2,usl.date_in,usl.CODE_USL,y.name,cr.CRIT,ksg.N_KSG
FROM [D3_SCHET_OMS] sch
		inner join [D3_PACIENT_OMS] p on sch.id=p.[D3_SCID]
									
		inner join [D3_ZSL_OMS] zs on p.id=zs.[D3_PID]
		inner join [D3_SL_OMS] sl on zs.id=sl.[D3_ZSLID]
		inner join D3_USL_OMS usl on usl.D3_SLID=sl.id 
		join D3_KSG_KPG_OMS ksg on ksg.D3_SLID=sl.id
		left join D3_CRIT_OMS cr on cr.D3_KSGID=ksg.id
		left join Yamed_Spr_UslCode y on y.ID=usl.CODE_USL
		--inner join D3_ONK_SL_OMS onk on onk.D3_SLID=sl.id
		--inner join D3_ONK_USL_OMS ou on ou.D3_ONKSLID=onk.id
		LEFT JOIN [KOKOD_OTD] k ON k.kod_otd=sl.podr
where sch.code_mo=460061 and sch.month=8 and sch.SchetType like 'C' AND sch.ID=625
      and (cr.CRIT is null or not (cr.CRIT  like 'нет' or cr.CRIT  like 'sh%' or cr.CRIT  like 'mt%' or cr.CRIT  like 'fr%'))
	  and code_usl not in ('A25.30.033.001')--)