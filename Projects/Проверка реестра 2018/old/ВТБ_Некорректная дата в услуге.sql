--некорректная дата в услуге
select zsl.ID,
		 p.fam,
		 p.IM,
		 p.ot,
		 p.DR,
		 p.NPOLIS,
		 zsl.DATE_Z_1,
		 zsl.Date_z_2,
		 -- sl.DATE_1,
		 --  sl.DATE_2,	 
		 --u.DATE_IN,
		 --u.DATE_OUT,
		 --sl.DS1,
		 'некорректная дата в услуге' com
FROM D3_ZSL_OMS zsl
inner join D3_PACIENT_OMS p on zsl.D3_PID=p.ID
			
where zsl.ID in (select zsl.ID
	FROM D3_ZSL_OMS zsl
	join D3_SL_OMS sl on sl.d3_zslid=zsl.id
	join D3_USL_OMS u on sl.ID = u.D3_SLID
	where zsl.d3_SCID = 2077 and (u.DATE_IN > sl.DATE_2 or u.DATE_OUT > sl.DATE_2 or u.DATE_IN > u.DATE_OUT 
										or u.DATE_IN > zsl.DATE_Z_2 or u.DATE_OUT > zsl.DATE_Z_2) AND npl <>4
	group by zsl.ID)
order by zsl.ID