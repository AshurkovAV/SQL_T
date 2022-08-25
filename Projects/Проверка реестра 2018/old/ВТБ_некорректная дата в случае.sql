--некорректная дата в случае
select zsl.ID,
		 p.fam,
		 p.IM,
		 p.ot,
		 p.DR,
		 p.NPOLIS,
		 zsl.DATE_Z_1,
		 zsl.Date_z_2,
		  --sl.DATE_1,
		  -- sl.DATE_2,	 
		 --u.DATE_IN,
		 --u.DATE_OUT,
		 --sl.DS1,
		 'Некорректная дата в случае.' com
FROM D3_ZSL_OMS zsl
inner join D3_PACIENT_OMS p on zsl.D3_PID=p.ID
						and zsl.d3_SCID = 2077
--join D3_SL sl on sl.d3_zslid=zsl.id	
where zsl.ID in (select zsl.ID
					FROM  D3_ZSL_OMS zsl
					join D3_SL_OMS sl on sl.d3_zslid=zsl.id
					where (sl.DATE_1<zsl.DATE_Z_1 or sl.DATE_2<zsl.DATE_Z_1 or sl.DATE_2>zsl.DATE_Z_2 or sl.DATE_1>zsl.DATE_Z_2) AND zsl.OS_SLUCH_REGION IS NULL
					group by zsl.ID
)
order by zsl.ID