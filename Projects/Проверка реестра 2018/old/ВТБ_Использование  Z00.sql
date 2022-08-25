--Использование  Z00
declare @p1 int=2077
select zsl.ID, zsl.SUMV, 'Z00.0 у ребёнка' com
FROM D3_ZSL_OMS zsl
join D3_SL_OMS sl on sl.D3_ZSLid=zsl.id
join D3_PACIENT_OMS pa on pa.ID = zsl.D3_PID
where zsl.D3_SCID = @p1 and zzsl.usl_ok = 3 
	  and DATEDIFF(YEAR,dr,DATE_2) +(SIGN(DATEDIFF(DAY,dr,DATEADD(YEAR,YEAR(dr)-YEAR(DATE_2),DATE_2)))-1)/2<18 
	  and sl.DS1 = 'Z00.0'
group by zsl.id, zsl.SUMV
union
select zsl.ID, zsl.SUMV, 'Z00.1 не используется у детей более 3 лет' com
FROM D3_ZSL_OMS zsl
join D3_SL_OMS sl on sl.D3_ZSLid=zsl.id
join D3_PACIENT_OMS pa on pa.ID = zsl.D3_PID
where zsl.D3_SCID = @p1 and zzsl.usl_ok = 3 
	  and DATEDIFF(YEAR,dr,DATE_2) +(SIGN(DATEDIFF(DAY,dr,DATEADD(YEAR,YEAR(dr)-YEAR(DATE_2),DATE_2)))-1)/2>3 
	  and sl.DS1 = 'Z00.1'
group by zsl.id, zsl.SUMV
union
select zsl.ID, zsl.SUMV, 'Z00.2 используется у детей от 3 до 12 лет' com
FROM D3_ZSL_OMS zsl
join D3_SL_OMS sl on sl.D3_ZSLid=zsl.id
join D3_PACIENT_OMS pa on pa.ID = zsl.D3_PID
where zsl.D3_SCID = @p1 and zzsl.usl_ok = 3 
	  and DATEDIFF(YEAR,dr,DATE_2) +(SIGN(DATEDIFF(DAY,dr,DATEADD(YEAR,YEAR(dr)-YEAR(DATE_2),DATE_2)))-1)/2<3
	  and DATEDIFF(YEAR,dr,DATE_2) +(SIGN(DATEDIFF(DAY,dr,DATEADD(YEAR,YEAR(dr)-YEAR(DATE_2),DATE_2)))-1)/2>12	  
	  and sl.DS1 = 'Z00.2'
group by zsl.id, zsl.SUMV
union
select zsl.ID, zsl.SUMV, 'Z00.3 используется у детей от 12 до 17 лет' com
FROM D3_ZSL_OMS zsl
join D3_SL_OMS sl on sl.D3_ZSLid=zsl.id
join D3_PACIENT_OMS pa on pa.ID = zsl.D3_PID
where zsl.D3_SCID = @p1 and zzsl.usl_ok = 3 
	  and DATEDIFF(YEAR,dr,DATE_2) +(SIGN(DATEDIFF(DAY,dr,DATEADD(YEAR,YEAR(dr)-YEAR(DATE_2),DATE_2)))-1)/2<12
	  and DATEDIFF(YEAR,dr,DATE_2) +(SIGN(DATEDIFF(DAY,dr,DATEADD(YEAR,YEAR(dr)-YEAR(DATE_2),DATE_2)))-1)/2>17	  
	  and sl.DS1 = 'Z00.3'
group by zsl.id, zsl.SUMV
union
select zsl.ID, zsl.SUMV, 'Z00 у пациента не 1 группы здоровья' com
FROM D3_ZSL_OMS zsl
join D3_SL_OMS sl on sl.D3_ZSLid=zsl.id and sl.PROFIL in (57,97)
where zsl.D3_SCID = @p1 and OS_SLUCH_REGION in (1,7,9,11,17,22) 
		and RSLT not in (317,321,327,332,337,343,347) and sl.DS1 in ('Z00.0','Z00.1','Z00.2','Z00.3')
group by zsl.id, zsl.SUMV