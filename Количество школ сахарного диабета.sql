SELECT dso.[YEAR],(CASE WHEN dso.[MONTH] = 1 THEN  'Январь'
		    WHEN dso.[MONTH] = 2 THEN  'Февраль'
		    WHEN dso.[MONTH] = 3 THEN  'Март'
		    WHEN dso.[MONTH] = 4 THEN  'Апрель'
		    WHEN dso.[MONTH] = 5 THEN  'Май'
		    WHEN dso.[MONTH] = 6 THEN  'Июнь'
		    WHEN dso.[MONTH] = 7 THEN  'Июль'
		    WHEN dso.[MONTH] = 8 THEN  'Август'
		    WHEN dso.[MONTH] = 9 THEN  'Сентябрь'
		    WHEN dso.[MONTH] = 10 THEN 'Октябрь'
		    WHEN dso.[MONTH] = 11 THEN 'Ноябрь'
		    WHEN dso.[MONTH] = 12 THEN 'Декабрь' 
		  ELSE 'Что-то пошло не так' END) [месяц подачи] , 
		  (CASE WHEN ysme.LPU_ID = 460006 THEN 'Заводская'
	      WHEN ysme.LPU_ID = 460026 THEN 'Союзная' ELSE 'Что-то пошло не так' END) lpu_id,
	      (SELECT TOP 1 ysme.NameWithID FROM Yamed_Spr_MedicalEmployee AS ysme WHERE ysme.SNILS = iddokt)iddokt1, COUNT(*) kol 
FROM D3_SCHET_OMS AS dso
	JOIN D3_ZSL_OMS AS dzo	ON dzo.D3_SCID = dso.ID
		JOIN D3_SL_OMS AS dso2 ON dso2.D3_ZSLID = dzo.ID
		LEFT JOIN Yamed_Spr_MedicalEmployee AS ysme ON ysme.SNILS = dso2.IDDOKT
WHERE dso.[YEAR] in (2023, 2024, 2025) AND dso2.P_CEL25 = '1.4'
GROUP BY dso.[YEAR], dso.[MONTH], ysme.LPU_ID, dso2.IDDOKT