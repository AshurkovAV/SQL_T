DECLARE @ID INT = 3032 --id счета
--SELECT zsl.id
SELECT 
--pa.FAM, pa.IM, pa.OT, pa.DR,  
du.COMENTU
--,  zsl.ID 
,COUNT(*) 
FROM D3_PACIENT_OMS pa	
join D3_ZSL_OMS zsl on pa.ID = zsl.D3_PID	
join D3_SL_OMS sl on sl.d3_zslid=zsl.id
JOIN D3_USL_OMS AS du ON sl.ID = du.D3_SLID
LEFT JOIN Yamed_Spr_MedicalEmployee AS sd ON sl.IDDOKT = sd.SNILS
WHERE zsl.OS_SLUCH_REGION IN (47,49) 
AND zsl.D3_SCID = @ID
--AND du.COMENTU = 'Определение уровня глюкозы в крови экспресс-методом'
--AND du.P_OTK IS NOT NULL
AND du.NPL IS NOT NULL
--AND zsl.PR_NOV = 0
GROUP BY du.COMENTU--, zsl.ID