declare @p1 int=2189
--- 'Диагноз z00.2 ставится пациентам от 3 до 14 лет включительно' com --osn=5.3.1.
---проставляем Z00.1 для детей до 3 лет
UPDATE sl SET ds1 = 'Z00.1'
FROM D3_ZSL_OMS zs
	join D3_SL_OMS sl on zs.id=sl.D3_ZSLID 
	join D3_PACIENT_OMS pa on pa.ID = zs.D3_PID
	--join D3_SCHET_OMS sch on sch.id=zs.d3_scid and sch.month=9
	--left join v002 v2 on v2.[IDPR]=sl.profil
where 
	zs.D3_SCID = @p1	
	and sl.profil not in (136,65,162,163,63,85,86,87,88,89,90,171) 
	and (dbo.f_GetAge(pa.dr,date_z_1)<3
		--or dbo.f_GetAge(pa.dr,date_z_1)>14
		)	
	and sl.ds1 like 'z00.2'
--- 'Диагноз z00.2 ставится пациентам от 3 до 14 лет включительно' com --osn=5.3.1.
---проставляем Z00.8 для >= 18 
UPDATE sl SET ds1 = 'Z00.8'
FROM D3_ZSL_OMS zs
	join D3_SL_OMS sl on zs.id=sl.D3_ZSLID 
	join D3_PACIENT_OMS pa on pa.ID = zs.D3_PID
	--join D3_SCHET_OMS sch on sch.id=zs.d3_scid and sch.month=9
	--left join v002 v2 on v2.[IDPR]=sl.profil
where 
	zs.D3_SCID = @p1	
	and sl.profil not in (136,65,162,163,63,85,86,87,88,89,90,171) 
	and (--dbo.f_GetAge(pa.dr,date_z_1)<3 or
		 dbo.f_GetAge(pa.dr,date_z_1)>=18
		)	
	and sl.ds1 like 'z00.2'	
-- 'Диагноз z00.2 ставится пациентам от 3 до 14 лет включительно' com --osn=5.3.1.
UPDATE sl set ds1 = 'Z00.3'
FROM D3_ZSL_OMS zs
	join D3_SL_OMS sl on zs.id=sl.D3_ZSLID 
	join D3_PACIENT_OMS pa on pa.ID = zs.D3_PID
	--join D3_SCHET_OMS sch on sch.id=zs.d3_scid and sch.month=9
	--left join v002 v2 on v2.[IDPR]=sl.profil
where 
	zs.D3_SCID = @p1	
	and sl.profil not in (136,65,162,163,63,85,86,87,88,89,90,171) 
	and ( dbo.f_GetAge(pa.dr,date_z_1)>14 AND dbo.f_GetAge(pa.dr,date_z_1)<18)	
	and sl.ds1 like 'z00.2'	
---'Диагноз z00.3 ставится пациентам от 15 до 17 лет включительно' 
---проставляем Z00.2
UPDATE sl SET ds1 = 'Z00.2'
FROM D3_ZSL_OMS zs
	join D3_SL_OMS sl on zs.id=sl.D3_ZSLID 
	join D3_PACIENT_OMS pa on pa.ID = zs.D3_PID
	--join D3_SCHET_OMS sch on sch.id=zs.d3_scid and sch.month=9
	--left join v002 v2 on v2.[IDPR]=sl.profil
where 
	zs.D3_SCID = @p1	
	and sl.profil not in (136,65,162,163,63,85,86,87,88,89,90,171) 
	and (dbo.f_GetAge(pa.dr,date_z_1)<15 or dbo.f_GetAge(pa.dr,date_z_1)>=18)
	and sl.ds1 like 'z00.3'		

--'Диагнозы z00.0 или z00.8 ставятся пациентам старше 18 лет включительно' com 
--проставляем Z00.3 
UPDATE sl SET DS1 = 'Z00.3'
FROM D3_ZSL_OMS zs
	join D3_SL_OMS sl on zs.id=sl.D3_ZSLID 
	join D3_PACIENT_OMS pa on pa.ID = zs.D3_PID
	--join D3_SCHET_OMS sch on sch.id=zs.d3_scid and sch.month=9
	--left join v002 v2 on v2.[IDPR]=sl.profil
where 
	zs.D3_SCID = @p1	
	and sl.profil not in (136,65,162,163,63,85,86,87,88,89,90,171) 
	and (dbo.f_GetAge(pa.dr,date_z_1)<18 AND dbo.f_GetAge(pa.dr,date_z_1)> 14)
	and (sl.ds1 like 'z00.0' or sl.ds1 like 'z00.8')