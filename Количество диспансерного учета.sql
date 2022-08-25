SELECT 
(SELECT TOP 1 ysme.NameWithID
   FROM Yamed_Spr_MedicalEmployee AS ysme WHERE ysme.SNILS = dso.IDDOKT), COUNT(*)
FROM D3_ZSL_OMS AS dzo
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
WHERE dzo.D3_SCID  = 2201 AND dso.P_CEL25 = '1.3'
GROUP BY dso.IDDOKT