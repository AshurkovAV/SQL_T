SELECT month(dso.DATE_1 ), (SELECT ysme.FAM
          FROM Yamed_Spr_MedicalEmployee AS ysme WHERE ysme.SNILS = dso.IDDOKT)d, COUNT(*)
FROM D3_ZSL_OMS AS dzo
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dzo.D3_SCID
WHERE dso2.[YEAR] = 2023 
AND dso.PROFIL = 106
GROUP BY month(dso.DATE_1 ), dso.IDDOKT