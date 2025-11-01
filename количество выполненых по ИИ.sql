SELECT (CASE WHEN dso.[MONTH] = 1 THEN  'Январь'
					  WHEN dso.[MONTH] = 2 THEN  'Февраль'
					  WHEN dso.[MONTH] = 3 THEN  'Март'
					  WHEN dso.[MONTH] = 4 THEN  'Апрель'
					  WHEN dso.[MONTH] = 5 THEN  'Мая'
					  WHEN dso.[MONTH] = 6 THEN  'Июнь'
					  WHEN dso.[MONTH] = 7 THEN  'Июль'
					  WHEN dso.[MONTH] = 8 THEN  'Август'
					  WHEN dso.[MONTH] = 9 THEN  'Сентябрь'
					  WHEN dso.[MONTH] = 10 THEN 'Октябрь'
					  WHEN dso.[MONTH] = 11 THEN 'Ноябрь'
					  WHEN dso.[MONTH] = 12 THEN 'Декабрь' ELSE 'Что-то пошло не так' END) [месяц подачи], 
ISNULL((SELECT ysme.NameWithID
   FROM Yamed_Spr_MedicalEmployee AS ysme WHERE ysme.SNILS = dso2.IDDOKT), dso2.IDDOKT)doc,
   duo.CODE_USL,  
  (SELECT TOP 1 name FROM Yamed_Spr_UslCode WHERE id = duo.VID_VME),  VID_VME,
    sum(sumv)sumv, COUNT(*)kol
FROM D3_SCHET_OMS AS dso
	JOIN D3_ZSL_OMS AS dzo ON dzo.D3_SCID = dso.ID	
		JOIN D3_SL_OMS AS dso2 ON dso2.D3_ZSLID = dzo.ID
			JOIN D3_USL_OMS AS duo ON duo.D3_SLID = dso2.ID
WHERE dso.[YEAR] = 2025 AND dso2.PROFIL = 78
AND (dzo.PR_NOV = 0 OR dzo.PR_NOV IS NULL)
AND duo.VID_VME IN ('A06.09.006', 'A06.09.007','A06.09.007.002') 
GROUP BY dso.[MONTH], duo.CODE_USL, duo.VID_VME, dso2.IDDOKT