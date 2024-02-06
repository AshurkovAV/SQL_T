SELECT 
(SELECT v.NameWithID FROM v002 v WHERE v.Id = dso.PROFIL), ms.name,  COUNT(*)
FROM D3_ZSL_OMS AS dzo
	JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
	JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
	JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dzo.D3_SCID
	JOIN D3_USL_OMS AS duo ON duo.D3_SLID = dso.ID
	left join medicalServices ms on ms.code_usl =duo.CODE_USL and dso.DATE_2 between ms.dataBegin and isnull(ms.dataend,'20991231')   
WHERE dso2.[YEAR] = 2023 AND dso2.NSCHET LIKE '%+%'
	--AND dzo.IDSP = 28
	AND (dzo.PR_NOV = 0 OR dzo.PR_NOV IS NULL)
	and duo.code_usl like 'R01%'
GROUP BY dso.PROFIL, ms.name