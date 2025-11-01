--Повторные госпитализации для Весельевой
SELECT distinct t.*
FROM (

		SELECT dpo.FAM, dpo.IM, dpo.OT, dpo.DR, dzo.DATE_Z_1, dzo.DATE_Z_2, ds1, dso2.PROFIL
		FROM D3_SCHET_OMS AS dso
			JOIN D3_ZSL_OMS AS dzo ON dzo.D3_SCID = dso.ID
				JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
					JOIN D3_SL_OMS AS dso2 ON dso2.D3_ZSLID = dzo.ID
		WHERE dso.[YEAR] = 2025 --AND dso.[MONTH] IN (7,8,9) AND month(dzo.DATE_Z_1) IN (7,8,9)
					AND dzo.USL_OK = 1
		--AND (dzo.PR_NOV = 0 OR dzo.PR_NOV IS NULL)
		--AND DATEDIFF(DAY, dzo.DATE_Z_1, dzo.DATE_Z_2)  < 6
		 ) AS t

JOIN (
		SELECT dpo.FAM, dpo.IM, dpo.OT, dpo.DR, dzo.DATE_Z_1, dzo.DATE_Z_2, ds1, dso2.PROFIL
		FROM D3_SCHET_OMS AS dso
			JOIN D3_ZSL_OMS AS dzo ON dzo.D3_SCID = dso.ID
				JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
					JOIN D3_SL_OMS AS dso2 ON dso2.D3_ZSLID = dzo.ID
		WHERE dso.[YEAR] = 2025 --AND dso.[MONTH] IN (7,8,9) AND month(dzo.DATE_Z_1) IN (7,8,9)
					AND dzo.USL_OK = 1
		--AND (dzo.PR_NOV = 0 OR dzo.PR_NOV IS NULL)
		--AND DATEDIFF(DAY, dzo.DATE_Z_1, dzo.DATE_Z_2)  < 6
		 ) AS t1 ON t.fam = t1.fam AND t.im = t1.im AND t.ot = t1.ot AND t.dr = t1.dr AND t1.PROFIL = t.PROFIL AND t1.DATE_Z_1 != t.DATE_Z_1 AND t1.ds1 = t.ds1
WHERE month(t1.DATE_Z_1) IN (7,8,9)