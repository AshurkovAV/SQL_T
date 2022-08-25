DECLARE @p INT = 2111
UPDATE zs SET idsp = 9
FROM [D3_ZSL_OMS] zs
	inner join [D3_SL_OMS] sl on zs.id=sl.[D3_ZSLID]
where 
	zs.D3_SCID = @p
	and zs.usl_ok in (3)
	and zs.OS_SLUCH_REGION is null
	and sl.PROFIL in (63,85,86,87,88,89,90,171)
	and zs.idsp not in (9)
	
UPDATE zs SET IDSP = 41
FROM [D3_ZSL_OMS] zs
	inner join [D3_SL_OMS] sl on zs.id=sl.[D3_ZSLID]
where 
	zs.D3_SCID = @p
	and zs.usl_ok in (3)
	and zs.OS_SLUCH_REGION is null
	AND sl.P_CEL25 = '1.1' AND zs.FOR_POM = 2
	AND zs.IDSP != 41 and sl.PROFIL NOT IN (63,85,86,87,88,89,90,171) 

--диспансерное наблюдение там где не стои, ставим всем эндокринолакам состоит по просьбе эндокринологов
UPDATE sl SET dn = 1
FROM [D3_ZSL_OMS] zs
	inner join [D3_SL_OMS] sl on zs.id=sl.[D3_ZSLID]
where 
	zs.D3_SCID = @p
	and zs.usl_ok in (3)
	and zs.OS_SLUCH_REGION is null
	AND sl.P_CEL25 = '1.3' 
	and sl.PROFIL IN (122, 97) and sl.[DN] is NULL
	
--добавляем код направившей мо если нет
UPDATE zs SET zs.NPR_MO = 460026
from D3_ZSL_OMS zs
where zs.D3_SCID = @p
	and zs.NPR_MO is NULL
	
update sl set DET = 0  
FROM [D3_ZSL_OMS] zs
  inner join [D3_SL_OMS] sl on zs.id=sl.[D3_ZSLID]
where zs.D3_SCID = @p
  and sl.DET=1
  and sl.PROFIL not in (17,18,19,20,21,55,86,68,83,131)
  
--Недопустимое выставление НЕдетского профиля МП при sl.det=1
UPDATE sl SET det = 0	
FROM [D3_ZSL_OMS] zs
	inner join [D3_SL_OMS] sl on zs.id=sl.[D3_ZSLID]
where zs.D3_SCID = 2111
	and sl.DET=1
	and sl.PROFIL not in (17,18,19,20,21,55,86,68,83,131)  
  
--  UPDATE duo SET DET = 1
--FROM D3_ZSL_OMS AS dzo
--JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
--JOIN D3_USL_OMS AS duo ON duo.D3_SLID = dso.ID
--WHERE dzo.D3_SCID = @p 
--AND dzo.OS_SLUCH_REGION = 11
--AND duo.VID_VME = 'A05.10.004'