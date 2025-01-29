SELECT dpo.FAM, dpo.IM, dpo.OT, dpo.DR, dso2.PROFIL, dzo.DATE_Z_1, dzo.DATE_Z_2, COUNT(*)kol, 
dbo.GROUP_CONCAT_DS(convert(NVARCHAR(10), [MONTH], 102), N' , ', 1)[MONTH], MAX(dso3.S_TIP)tip,  MAX(dso3.S_DATE)
-- dso3.S_COM, dso3.S_TIP

--INTO ztemp_perep2

FROM ( SELECT id, CASE WHEN d.[MONTH] = 1 THEN '������'
						 WHEN d.[MONTH] = 2 THEN '�������'
						 WHEN d.[MONTH] = 3 THEN '����'
						 WHEN d.[MONTH] = 4 THEN '������'
						 WHEN d.[MONTH] = 5 THEN '���'
						 WHEN d.[MONTH] = 6 THEN '����'
						 WHEN d.[MONTH] = 7 THEN '����'
						 WHEN d.[MONTH] = 8 THEN '������'
						 WHEN d.[MONTH] = 9 THEN '��������'
						 WHEN d.[MONTH] = 10 THEN '�������'
						 WHEN d.[MONTH] = 11 THEN '������'
						 WHEN d.[MONTH] = 12 THEN '�������' ELSE '' END [MONTH], d.[YEAR] FROM D3_SCHET_OMS d ) AS dso
	JOIN D3_ZSL_OMS AS dzo ON dzo.D3_SCID = dso.ID
		JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
			JOIN D3_SL_OMS AS dso2 ON dso2.D3_ZSLID = dzo.ID
				LEFT JOIN D3_SANK_OMS AS dso3 ON dso3.D3_ZSLID = dzo.ID			
WHERE 
dso.[YEAR] = 2024 
AND dzo.USL_OK = 1
--AND (dzo.PR_NOV = 0 OR dzo.PR_NOV IS NULL)
--AND dzo.PR_NOV = 1

GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR, dso2.PROFIL, dzo.DATE_Z_1, dzo.DATE_Z_2




--SELECT *
--FROM ztemp_sank1 s
--	left JOIN ztemp_prnov1 p ON s.FAM = p.fam AND s.IM = p.im AND s.OT = p.ot  AND s.DR = p.dr AND s.PROFIL = p.profil AND s.DATE_Z_1 = p.DATE_Z_1 AND  s.DATE_Z_2 = p.DATE_Z_2
--WHERE p.fam IS  NULL