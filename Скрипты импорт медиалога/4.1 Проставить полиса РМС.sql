if OBJECT_ID('ztemp_polis') is not null drop table ztemp_polis
SELECT t.id, omsSmo
INTO ztemp_polis
FROM [SQL_COD].[DocExchange].[dbo].[ATTP_People] ap
JOIN(
SELECT p.NPOLIS, dz.ID
FROM D3_ZSL_OMS AS dz
JOIN D3_PACIENT_OMS AS p ON dz.D3_PID = p.ID
WHERE dz.D3_SCID = 2154 AND dz.EXP_COMENT LIKE '%ялн%') AS t ON  ap.ENP = t.NPOLIS


UPDATE dpo SET SMO = t.omsSmo
FROM D3_ZSL_OMS AS dzo
JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
JOIN ztemp_polis t ON t.id = dzo.ID