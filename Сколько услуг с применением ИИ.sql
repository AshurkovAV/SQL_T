SELECT ms.name, duo.VID_VME,
ISNULL((SELECT ysme.NameWithID
   FROM Yamed_Spr_MedicalEmployee AS ysme WHERE ysme.SNILS = dso.IDDOKT), dso.IDDOKT), COUNT(*)
FROM D3_ZSL_OMS AS dzo
	JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
		JOIN D3_USL_OMS AS duo ON duo.D3_SLID = dso.ID
			JOIN Yamed_Spr_UslCode AS ms ON ms.id = duo.VID_VME
WHERE dzo.D3_SCID =23744 AND dso.PROFIL = 78
GROUP BY dso.IDDOKT, ms.name, duo.VID_VME