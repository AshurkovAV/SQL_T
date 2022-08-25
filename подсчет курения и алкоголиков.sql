SELECT dpo.FAM, dpo.IM, dpo.OT, CAST(dr AS date) dr, cast(dso.DATE_1 AS DATE)DATE_1 , 
(SELECT ysme.NameWithID
   FROM Yamed_Spr_MedicalEmployee AS ysme WHERE ysme.SNILS = dso.iddokt) vr
FROM D3_ZSL_OMS AS dzo
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dzo.D3_SCID
JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
--JOIN D3_USL_OMS AS duo ON duo.D3_SLID = dso.ID --AND duo.DS = 'Z72.1'
JOIN D3_DSS_OMS AS ddo ON ddo.D3_SLID = dso.ID AND ddo.DS = 'Z72.1' --Алкоголики
WHERE dso2.[MONTH] = 3 AND dso2.[YEAR] = 2020 AND  
--dzo.D3_SCID = 2868 AND 
dzo.OS_SLUCH_REGION IN (47,49) 