DECLARE @D3_SCID INT = 2077
select zsl.ID, 		
pa.FAM,PA.im,pa.ot,zsl.date_z_1,zsl.DATE_Z_2,		
zsl.SUMV, 'ХНИЗ допускаются только в III-а группе здоровья.' com		
FROM D3_ZSL_OMS zsl		
JOIN D3_PACIENT_OMS pa on zsl.D3_PID = pa.ID		
join D3_SL_OMS sl on sl.d3_zslid=zsl.id		
where zsl.D3_SCID = @D3_SCID and zsl.OS_SLUCH_REGION in (22,23) 		
	  and RSLT in (317,318, 352,353,356,358)	
	  and (DS1 between 'I00' and 'I99.9' or DS1 between 'J40' and 'J99.9' or DS1 between 'C00' and 'C99.9' or 	
		   DS1 between 'D00' and 'D48.9' or DS1 between 'E11%' and 'E14.9')
--group by zsl.ID, zsl.SUMV		
union		
select zsl.ID,		
pa.FAM,PA.im,pa.ot,zsl.date_z_1,zsl.DATE_Z_2,		
 zsl.SUMV, 'III-а группа здоровья допускается только при ХНИЗ.' com		
FROM D3_ZSL_OMS zsl		
JOIN D3_PACIENT_OMS pa on zsl.D3_PID = pa.ID		
join D3_SL_OMS sl on sl.d3_zslid=zsl.id		
where zsl.D3_SCID = @D3_SCID and zsl.OS_SLUCH_REGION in (22,23) 		
	  and RSLT in (355,357)	
	  and not (DS1 between 'I00' and 'I99.9' or DS1 between 'J40' and 'J99.9' or DS1 between 'C00' and 'C99.9' or 	
		       DS1 between 'D00' and 'D48.9' or DS1 between 'E11' and 'E14.9')
--group by zsl.ID, zsl.SUMV		
