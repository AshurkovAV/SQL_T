SELECT distinct dpo.FAM, dpo.IM, dpo.OT, dpo.DR, dso.DS1, ysme.NameWithID doc
FROM D3_ZSL_OMS AS dzo
JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
LEFT JOIN Yamed_Spr_MedicalEmployee AS ysme ON ysme.SNILS = dso.IDDOKT
WHERE dso.IDDOKT IN ('140-847-262-56')--,'152-443-755 54','155-744-373 87'
ORDER BY doc