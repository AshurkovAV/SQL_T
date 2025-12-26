SELECT ysme.NameWithID, ysme.LPU_ID, dso.[MONTH]
, COUNT(*)
FROM D3_SCHET_OMS AS dso
	JOIN D3_ZSL_OMS AS dzo ON dzo.D3_SCID = dso.ID
		JOIN D3_SL_OMS AS dso2 ON dso2.D3_ZSLID = dzo.ID
			JOIN Yamed_Spr_MedicalEmployee AS ysme ON ysme.SNILS = dso2.IDDOKT
WHERE dso.[YEAR] = 2025 AND dso2.P_CEL25 = '1.4' AND dso.NSCHET NOT LIKE '%ошибк%'
AND (dzo.PR_NOV IS NULL OR dzo.PR_NOV = 0)
GROUP BY ysme.NameWithID, ysme.LPU_ID, dso.[MONTH]

--Именнованные по списку 
SELECT dpo.FAM , dpo.IM , dpo.OT,  dr, dso2.DATE_1, dso2.DS1, dso.[MONTH], ysme.NameWithID, dso2.P_CEL25
FROM D3_SCHET_OMS AS dso
	JOIN D3_ZSL_OMS AS dzo ON dzo.D3_SCID = dso.ID
		JOIN D3_SL_OMS AS dso2 ON dso2.D3_ZSLID = dzo.ID
			JOIN Yamed_Spr_MedicalEmployee AS ysme ON ysme.SNILS = dso2.IDDOKT
				JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
WHERE dso.[YEAR] = 2025 AND dso2.P_CEL25 = '1.4' AND dso.NSCHET NOT LIKE '%ошибк%'
AND (dzo.PR_NOV IS NULL OR dzo.PR_NOV = 0)



SELECT *
FROM v025


---Другие школы здоровья по случаям заболевания
SELECT t.u, COUNT (*)k
FROM (

SELECT distinct dzo.ZSL_ID , 
( SELECT ysu.Name FROM Yamed_Spr_Usl804 AS ysu WHERE ysu.ID = duo.CODE_USL) u
FROM D3_SCHET_OMS AS dso
	JOIN D3_ZSL_OMS AS dzo ON dzo.D3_SCID = dso.ID
		JOIN D3_SL_OMS AS dso2 ON dso2.D3_ZSLID = dzo.ID
			JOIN D3_USL_OMS AS duo ON duo.D3_SLID = dso2.ID
			JOIN Yamed_Spr_MedicalEmployee AS ysme ON ysme.SNILS = dso2.IDDOKT
WHERE dso.[YEAR] = 2025 AND dso2.P_CEL25 = '1.9' AND dso.NSCHET NOT LIKE '%ошибк%'
AND (dzo.PR_NOV IS NULL OR dzo.PR_NOV = 0)
GROUP BY dzo.ZSL_ID , duo.CODE_USL) AS t
GROUP BY t.u