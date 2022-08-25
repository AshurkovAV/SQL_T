SELECT dpo.FAM, dpo.IM, dpo.OT, 
cast(dpo.DR AS DATE)dr, CAST(dzo.DATE_Z_1 AS DATE) dat1,
(SELECT ysme.NameWithID FROM Yamed_Spr_MedicalEmployee AS ysme WHERE ysme.SNILS = dso.IDDOKT) 
--dzo.OS_SLUCH_REGION, 'Общий (клинический) анализ крови'
FROM D3_ZSL_OMS AS dzo
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
JOIN D3_USL_OMS AS duo ON duo.D3_SLID = dso.ID
WHERE dzo.D3_SCID IN (2347, 2865) AND duo.CODE_USL = 'B03.016.002'
ORDER BY dzo.DATE_Z_1