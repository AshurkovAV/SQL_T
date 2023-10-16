SELECT 
dpo.FAM, dpo.IM, dpo.ot, cast(dpo.DR AS DATE) dr, cast(dzo.DATE_Z_2 AS DATE)d2, ds1, dso2.[MONTH] 'месяц подачи', --dzo.OS_SLUCH_REGION,
(SELECT TOP  1 v017.NameWithID FROM v017 WHERE IDDR =  dzo.RSLT_D), 
(SELECT TOP 1 ysme.NameWithID FROM Yamed_Spr_MedicalEmployee AS ysme WHERE ysme.SNILS = iddokt)iddokt1, ysme.LPU_ID,
(SELECT osd.NameWithID FROM OsobSluchDb AS osd WHERE osd.Id = dzo.OS_SLUCH_REGION ) OS_SLUCH_REGION  --, dso.IDDOKT
FROM D3_ZSL_OMS AS dzo
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dzo.D3_SCID --AND dso2.NSCHET LIKE '%сдан%'
LEFT JOIN Yamed_Spr_MedicalEmployee AS ysme ON ysme.SNILS = dso.IDDOKT
WHERE dzo.OS_SLUCH_REGION IN (47,49) 
--AND dso2.[MONTH] IN (9) 
AND dso2.[YEAR] = 2023
AND dso2.NSCHET NOT LIKE '%ошибк%'
--AND dpo.FAM = 'Матвеев'
--AND dso.IDDOKT IN ('048-391-178 79', '034-486-289 70', '071-529-760 71', '131-058-757 34', '146-055-825 60')
--AND ysme.LPU_ID = 460026
ORDER BY dpo.FAM, dpo.IM, dpo.OT

--ЦУПРЕВА ЕЛЕНА АЛЕКСАНДРОВНА 131-058-757 34
--ЕРОФЕЕВА ЕКАТЕРИНА ВЛАДИМИРОВНА 146-055-825 60

--3248 на 12 54
--3494 