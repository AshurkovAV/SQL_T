SELECT 
dpo.FAM, dpo.IM, ot, cast(dpo.DR AS DATE) dr, cast(dzo.DATE_Z_2 AS DATE)d2, ds1, dso2.[MONTH] 'мес€ц подачи', --dzo.OS_SLUCH_REGION,
(SELECT TOP  1 v017.NameWithID FROM v017 WHERE IDDR =  dzo.RSLT_D), 
(SELECT ysme.NameWithID FROM Yamed_Spr_MedicalEmployee AS ysme WHERE ysme.SNILS = iddokt)iddokt1--, dso.IDDOKT
FROM D3_ZSL_OMS AS dzo
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dzo.D3_SCID --AND dso2.NSCHET LIKE '%сдан%'
WHERE dzo.OS_SLUCH_REGION IN (47,49) 
AND dso2.[MONTH] IN (1,2,3,4,5,6,7) 
AND dso2.[YEAR] = 2022
AND dso.IDDOKT IN ('048-391-178 79', '034-486-289 70', '071-529-760 71')
ORDER BY iddokt1, dpo.FAM, dpo.IM