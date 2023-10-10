SELECT ROW_NUMBER() OVER(ORDER BY FAM ASC)
    AS k, ysme.FAM + ' ' + ysme.IM + ' ' +  ysme.OT AS doc, 
    CASE WHEN ysme.LPU_ID = 460026 THEN 'Взрослая на Союзная'
         WHEN ysme.LPU_ID = 460006 THEN 'Взарослая на Заводская'
    ELSE 'Прочее' END [Подразделение], 
    (SELECT pd.NameWithID FROM PodrDb AS pd WHERE pd.Id = dso.LPU_1)[вид],
    COUNT(*)kol, SUM(sumv)sumv
FROM D3_ZSL_OMS AS dzo
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
JOIN Yamed_Spr_MedicalEmployee AS ysme ON ysme.SNILS = dso.IDDOKT
WHERE dzo.D3_SCID IN (20292, 20300) 
AND dzo.USL_OK = 2
GROUP BY ysme.FAM, ysme.IM, ysme.OT, dso.LPU_1, ysme.LPU_ID
ORDER BY k
