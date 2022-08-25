SELECT dzo.PR_NOV, dpo.FAM, dpo.IM, dpo.OT, dpo.DR, dzo.DATE_Z_1, dzo.DATE_Z_2, 
(SELECT ysme.NameWithID FROM Yamed_Spr_MedicalEmployee AS ysme WHERE ysme.SNILS = dso.IDDOKT) doc,
(SELECT osd.NameWithID 
   FROM OsobSluchDb AS osd WHERE osd.Id = dzo.OS_SLUCH_REGION) 
FROM D3_ZSL_OMS AS dzo
JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
WHERE YEAR(dzo.DATE_Z_2) = 2019 AND 
dzo.OS_SLUCH_REGION IN (22,9,38,37,47,49) 
AND (dzo.PR_NOV = 0 OR dzo.PR_NOV IS NULL)
--AND dpo.FAM = 'Хренков'
ORDER BY dpo.FAM, dpo.IM,dpo.OT
