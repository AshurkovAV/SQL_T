SELECT dpo.*
FROM D3_SCHET_OMS AS dso
JOIN D3_ZSL_OMS AS dzo ON dzo.D3_SCID = dso.ID
JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
WHERE dso.[YEAR] = 2022 
AND (dzo.PR_NOV = 0 OR dzo.PR_NOV IS NULL)
AND dzo.USL_OK = 1 
AND dpo.KOD_TER = 2
AND dbo.f_GetAge(dpo.dr,date_z_2) >= 63
AND dzo.RSLT = 105