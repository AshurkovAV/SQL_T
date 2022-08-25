--полный дубль в поликлинике по случаю(фио, др, профиль, диагноз до точки, дата начала лечения)кроме онко, опц и обл
DECLARE @pp1 int = 2155
--SELECT DISTINCT zsl.id as ID
--,sl.id, pa.FAM, pa.IM, pa.OT, pa.DR, zsl.D3_SCID
----	, sl.DATE_1, DATE_2
	--, zsl.LPU, zsl.SUMV, sl.profil,SUBSTRING(sl.ds1,1,3) as ds, oplata
--UPDATE zsl SET EXP_COMENT = 'полный дубль в поликлинике по случаю(фио, др, профиль, диагноз до точки, дата начала лечения)'
SELECT zsl.id
--INTO ztemp_01022019_dubl
FROM D3_ZSL_OMS zsl
	JOIN D3_SL_OMS sl on zsl.id=sl.D3_ZSLID AND zsl.D3_SCID IN (2136,2141,2146,2131,2127,2119,2115, 2111, 2095,2094,2083,2077,2071,2061,2060,2059,2057)
	JOIN D3_PACIENT_OMS pa on pa.ID = zsl.D3_PID
	JOIN (
	--ищем полные дубли
SELECT pa.FAM, pa.IM, pa.OT, pa.DR
	, DATE_1,zsl.lpu
	, sl.profil,SUBSTRING(sl.ds1,1,3) as ds
	FROM D3_ZSL_OMS zsl
	JOIN D3_SL_OMS sl on zsl.id=sl.D3_ZSLID AND OS_SLUCH_REGION IS NULL
	JOIN D3_PACIENT_OMS pa on pa.ID = zsl.D3_PID AND zsl.USL_OK IN(3) 
									AND pa.D3_SCID=@pp1
									AND sl.profil NOT IN (85,86,87,88,89,90,140,171) AND (zsl.PR_NOV IS NULL OR zsl.PR_NOV = 0)
	JOIN D3_SCHET_OMS sch on sch.id=pa.D3_SCID AND sch.CODE_MO NOT IN (460039,460061,460003)							 
GROUP BY pa.FAM, pa.IM, pa.OT, pa.DR
	, DATE_1 ,zsl.lpu	
	,  sl.profil,SUBSTRING(sl.ds1,1,3) 
	having count(*)>1

	) t	on 	pa.FAM=t.FAM	
	and 	pa.IM=t.IM		
	and pa.ot=t.ot
	and pa.dr=t.dr
	and sl.DATE_1=t.DATE_1
	and sl.profil=t.profil
	and zsl.lpu=t.lpu
	and SUBSTRING(sl.ds1,1,3)=t.ds
WHERE zsl.D3_SCID = @pp1
	--order by  pa.FAM, pa.IM, pa.OT, pa.DR
	
--	UPDATE dz SET dz.D3_SCID = 2133, dz.EXP_COMENT = 'полный дубль в поликлинике по случаю(фио, др, профиль, диагноз до точки, дата начала лечения)'
--FROM D3_ZSL_OMS dz 
--WHERE id IN (
--SELECT id
--FROM ztemp_01022019_dubl)