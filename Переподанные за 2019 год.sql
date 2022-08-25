SELECT dzo.ZSL_ID, dpo.FAM, dpo.IM, dpo.OT, dpo.DR, 
(SELECT v.NameWithID FROM V006 AS v WHERE v.id = dzo.USL_OK), dzo.SUMV, dzo.OS_SLUCH_REGION, 
 
(SELECT TOP 1 ysme.NameWithID
   FROM Yamed_Spr_MedicalEmployee AS ysme WHERE ysme.SNILS = dso2.IDDOKT) [doc], dso2.P_CEL25,
dso3.S_COM
FROM D3_SCHET_OMS AS dso
JOIN D3_ZSL_OMS AS dzo ON dzo.D3_SCID = dso.ID
JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
JOIN D3_SL_OMS AS dso2 ON dso2.D3_ZSLID = dzo.ID
LEFT JOIN D3_SANK_OMS AS dso3 ON dso3.D3_ZSLGID = dzo.ZSL_ID
WHERE dso.[YEAR] = 2019 AND dzo.PR_NOV = 1 