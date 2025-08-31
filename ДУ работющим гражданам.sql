SELECT 
	dpo.FAM, dpo.IM, dpo.ot, cast(dpo.DR AS DATE) dr, 
	dpo.FAM + ' ' + dpo.IM + ' ' +  dpo.ot + ' ' + convert(NVARCHAR(10), dpo.DR, 104) fio,
	cast(dzo.DATE_Z_2 AS DATE)d2, ds1, dso2.[MONTH] 'месяц подачи', --dzo.OS_SLUCH_REGION,
	(SELECT TOP  1 v017.NameWithID FROM v017 WHERE IDDR =  dzo.RSLT_D), 
	(SELECT TOP 1 ysme.NameWithID FROM Yamed_Spr_MedicalEmployee AS ysme WHERE ysme.SNILS = iddokt)iddokt1, 
	(SELECT osd.NameWithID FROM OsobSluchDb AS osd WHERE osd.Id = dzo.OS_SLUCH_REGION ) OS_SLUCH_REGION,
	dso3.S_COM, dso3.S_TIP,
	(CASE WHEN ysme.LPU_ID = 460006 THEN 'Заводская'
	      WHEN ysme.LPU_ID = 460026 THEN 'Союзная' ELSE 'Что-то пошло не так' END) lpu_id,
	CASE WHEN isnull(dzo.PR_NOV, 0) = 0 
			THEN 'Сведения об оказанной медицинской помощи передаются впервые' 
			ELSE 'Запись передается повторно после исправления' 
    END PR_NOV, dso2.[MONTH], dso.P_CEL, dso.LPU_1
FROM D3_ZSL_OMS AS dzo
	JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
		JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
			JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dzo.D3_SCID --AND dso2.NSCHET LIKE '%сдан%'
				LEFT JOIN Yamed_Spr_MedicalEmployee AS ysme ON ysme.SNILS = dso.IDDOKT
					LEFT JOIN D3_SANK_OMS AS dso3 ON dso3.D3_ZSLID = dzo.ID
WHERE dso2.[MONTH] IN (1,2,3,4,5,6,7) AND dso2.[YEAR] = 2025
AND ((dso.P_CEL25 = '1.3' AND dso.LPU_1 = 305) OR dso.P_CEL25 in( '4.1', '4.2'))



