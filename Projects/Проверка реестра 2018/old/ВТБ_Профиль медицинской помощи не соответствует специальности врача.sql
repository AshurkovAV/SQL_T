--ѕрофиль медицинской помощи не соответствует специальности врача
select zsl.ID,
		 p.fam,
		 p.IM,
		 p.ot,
		 p.DR,
		 p.NPOLIS,
		 zsl.DATE_Z_1,
		 zsl.Date_z_2,
		 
		 'ѕрофиль медицинской помощи не соответствует специальности врача' com
FROM D3_ZSL zsl
inner join PACIENT p on zsl.D3_PID=p.ID
						and zsl.d3_SCID = 2071
--join D3_SL sl on sl.d3_zslid=zsl.id	
		where zsl.ID in (SELECT zsl.id
		FROM D3_ZSL zsl
		join D3_SL sl on sl.d3_zslid=zsl.id
		LEFT JOIN V015_V002 v ON v.CodProf = sl.PROFIL AND v.CodSpec = sl.PRVS
		WHERE zsl.D3_SCID =2061 AND v.ID IS NULL
		group by zsl.id
)
order by zsl.ID