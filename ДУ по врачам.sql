SELECT dso2.[MONTH], dso.P_CEL25, 
(SELECT ysme.NameWithID
   FROM Yamed_Spr_MedicalEmployee AS ysme WHERE ysme.SNILS = iddokt) [врач],
COUNT(*)
FROM D3_ZSL_OMS AS dzo
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dzo.D3_SCID
WHERE dso2.NSCHET LIKE '%СДан%' 
AND dso.P_CEL25 = '1.3'
AND dso2.[YEAR] = 2021
GROUP BY dso2.[MONTH], dso.P_CEL25, dso.IDDOKT
ORDER BY dso2.[MONTH]

