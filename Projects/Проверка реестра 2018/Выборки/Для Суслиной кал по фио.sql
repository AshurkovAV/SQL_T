DECLARE @ID INT = 2898 --id счета
SELECT p.FAM, p.IM, p.OT, CAST(p.DR AS DATE) dr, CAST(zsl.DATE_Z_1 AS DATE) dat1, 
(SELECT ysme.NameWithID FROM Yamed_Spr_MedicalEmployee AS ysme WHERE ysme.SNILS = sl.IDDOKT)
FROM D3_ZSL_OMS AS zsl
JOIN D3_PACIENT_OMS AS p ON p.ID = zsl.D3_PID 
join D3_SL_OMS sl on sl.d3_zslid=zsl.id
JOIN D3_USL_OMS AS du ON sl.ID = du.D3_SLID
WHERE zsl.D3_SCID = @ID 
AND zsl.OS_SLUCH_REGION IN (47) AND du.VID_VME = 'A09.19.001'
AND zsl.PR_NOV = 0
ORDER BY DATE_Z_1