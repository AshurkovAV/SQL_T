SELECT month(dso.DATE_1 ), 
		  (SELECT ysme.FAM
				FROM Yamed_Spr_MedicalEmployee AS ysme WHERE ysme.SNILS = dso.IDDOKT)d, 
          (SELECT TOP 1 ysu.name
                FROM medicalServices AS ysu WHERE ysu.code_usl =  duo.CODE_USL), duo.CODE_USL, COUNT(*)
FROM D3_ZSL_OMS AS dzo
	JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
		JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
			JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dzo.D3_SCID
				JOIN D3_USL_OMS AS duo ON duo.D3_SLID = dso.ID
WHERE dso2.[YEAR] = 2024
	AND dso2.[MONTH] = 2
	AND dso.PROFIL = 106
GROUP BY month(dso.DATE_1 ), dso.IDDOKT, duo.CODE_USL