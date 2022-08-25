DECLARE @ID INT = 2115 --id счета
SELECT pa.FAM, pa.IM, pa.OT, dr, zsl.DATE_Z_1, 
sd.NameWithID
FROM D3_PACIENT_OMS pa	
join D3_ZSL_OMS zsl on pa.ID = zsl.D3_PID	
join D3_SL_OMS sl on sl.d3_zslid=zsl.id
JOIN D3_USL_OMS AS du ON sl.ID = du.D3_SLID
LEFT JOIN Yamed_Spr_MedicalEmployee AS sd ON sl.IDDOKT = sd.SNILS
WHERE 
--du.VID_VME != 'A06.20.004' 
--AND 
zsl.D3_SCID = @ID
AND zsl.OS_SLUCH_REGION = 38 --22
ORDER BY zsl.DATE_Z_1