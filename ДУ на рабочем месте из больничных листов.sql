DROP TABLE ztemp_1410

SELECT bars.*,  max(ais.[МКБ-10]) mkb_ais
INTO ztemp_1410
FROM ( SELECT  *
	   FROM [elmed].[dbo].du101024
       WHERE Фамилия IS NOT NULL   
				AND [Дата снятия с ДУ] IS NULL ) AS ais
JOIN (
		SELECT *
		FROM [elmed].[dbo].[eln_20241011$]
		WHERE С >= '20240801') AS bars ON bars.Фамилия = ais.Фамилия 
												AND bars.Имя = ais.Имя 
												AND bars.Отчество = ais.Отчество 
												AND bars.[Дата рождения пациента] = ais.[Дата рождения]
												--AND bars.[Шифр МКБ-10] = ais.[МКБ-10]
GROUP BY [Номер]
      ,[Тип]
      ,[Состояние]
      ,bars.[Фамилия]
      ,bars.[Имя]
      ,bars.[Отчество]
      ,[Суботчество]
      ,[Карта пациента]
      ,[Дата рождения пациента]
      ,[Возраст пациента]
      ,[Пол пациента]
      ,[Участок]
      ,[Листок выдан]
      ,[Дата рождения представителя]
      ,[Возраст представителя]
      ,[Пол представителя]
      ,[Место работы]
      ,[Место учебы]
      ,[Адрес фактического проживания]
      ,[Выдавший врач]
      ,[Закрывший врач]
      ,[С]
      ,[По]
      ,[Дата закрытия]
      ,[Выдан в нашей МО]
      ,[Причина нетруд-ти]
      ,[Доп# код]
      ,[Предварительный диагноз]
      ,[Заключительный диагноз]
      ,[Выдан из журнала]
      ,[Количество дней]
      ,[Закрыт]
      ,[Сотрудник, оформивший ЛН]
      ,[Результат]
      ,[Маркер]
      ,[Тип ЛН]
--ORDER BY ais.Фамилия

DROP TABLE ztemp_du_pred

SELECT dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
	dbo.GROUP_CONCAT_DS(DISTINCT ysme.NameWithID, N' , ', 1)NameWithID,
	dbo.GROUP_CONCAT_DS(DISTINCT ysme.LPU_ID, N' , ', 1)LPU_ID
	--CASE WHEN ysme.LPU_ID = 460006 THEN 'ЗАВОДСКАЯ' ELSE 'СОЮЗНАЯ' END gb, ysme.NameWithID
		INTO ztemp_du_pred
		FROM D3_ZSL_OMS AS dzo
			JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
				JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
					JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dzo.D3_SCID --AND dso2.NSCHET LIKE '%+%'
						LEFT JOIN Yamed_Spr_MedicalEmployee AS ysme ON ysme.SNILS = dso.IDDOKT -- AND ysme.LPU_ID = 460026
		WHERE 
			dso.P_CEL25 IN( '1.3', '4.1') 
			---------/////----------------------
			AND (dso2.[YEAR] = 2024)
	GROUP BY  dpo.FAM, dpo.IM, dpo.OT, dpo.DR

SELECT dt.Фамилия, dt.Имя, dt.Отчество, dt.[Дата рождения пациента], 
(SELECT TOP 1 ysme.SNILS
   FROM Yamed_Spr_MedicalEmployee AS ysme WHERE ysme.fam LIKE '%' + SUBSTRING(dt.[Выдавший врач], 1, CHARINDEX(' ', dt.[Выдавший врач], 1) - 1) + '%')doc , dt.По, dt.mkb_ais
FROM ztemp_1410 AS dt
	LEFT JOIN ztemp_du_pred AS dp ON dt.[Фамилия] = dp.FAM AND dt.[Имя] = dp.IM AND dt.[Отчество] = dp.OT AND dt.[Дата рождения пациента] = dp.DR
WHERE dp.fam IS null