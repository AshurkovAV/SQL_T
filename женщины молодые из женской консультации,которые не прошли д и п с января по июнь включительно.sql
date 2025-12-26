if OBJECT_ID('ztemp_not13') is not null DROP TABLE ztemp_not13

SELECT t1.* 
INTO ztemp_not13
FROM (
			SELECT DISTINCT dpo.NPOLIS, dpo.FAM, dpo.IM, dpo.OT, dpo.DR, dzo.OS_SLUCH_REGION
			FROM D3_ZSL_OMS AS dzo
				JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
					JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
						JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dzo.D3_SCID	
							JOIN Yamed_Spr_MedicalEmployee AS ysme ON dso.IDDOKT = ysme.SNILS
			WHERE (dso2.[YEAR] = 2025)
			AND dso.PROFIL = 136
			AND dzo.USL_OK = 3
			AND ysme.LPU_ID = 460006
			
) AS t1

LEFT JOIN (
			
			SELECT DISTINCT dpo.FAM, dpo.IM, dpo.OT, dpo.DR, dzo.OS_SLUCH_REGION, dzo.DATE_Z_1
			FROM D3_ZSL_OMS AS dzo
				JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
					JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
						JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dzo.D3_SCID
			WHERE dso2.[YEAR] = 2025
			AND dzo.OS_SLUCH_REGION IN (47, 49)
			
		) AS t2 ON t2.FAM = t1.FAM AND t2.IM = t1.IM AND t2.OT = t1.OT AND t2.DR = t1.DR
		
WHERE t2.FAM IS NULL


if OBJECT_ID('ztemp_ztemp_du_bsk_adr') is not null DROP TABLE ztemp_ztemp_du_bsk_adr

-----------1 шаг.
--DROP INDEX indX123 ON ztemp_du_bsk
		-------------Добавляю телефон и адрес --------------------
		SELECT tt.*, t.MOBIL_TELEFON, ISNULL(dl.Адрес_район , '-') + ' ' + isnull(dl.Адрес_населённый_пункт , '-') + ' ' + isnull(dl.Адрес_улица , '-') + ' ' + ISNULL(dl.Адрес_дом , '-') + ' ' + isnull(dl.Адрес_корпус , '-')  + ' ' + isnull(dl.Адрес_квартира , '-') addr
		INTO ztemp_ztemp_du_bsk_adr
		FROM ztemp_not13 tt 
			INNER JOIN Prikrep dl ON tt.FAM = dl.Фамилия AND tt.IM = dl.Имя AND tt.OT = dl.Отчество AND tt.DR = dl.Дата_рождения
				LEFT JOIN telefon AS t ON tt.fam=t.NOM and tt.im=t.PRENOM and tt.ot=t.PATRONYME and tt.dr=t.NE_LE
		-------------Добавляю телефон и адрес --------------------

-----------2.	
if OBJECT_ID('zt') is not null DROP TABLE zt	
		
SELECT t_du.*,
     CASE WHEN t_p.OS_SLUCH_REGION IS NOT NULL THEN (SELECT osd.NameWithID
                                              FROM OsobSluchDb AS osd WHERE osd.Id = t_p.OS_SLUCH_REGION) + ' ' + CONVERT(NVARCHAR(10), DATE_Z_1, 110)
     ELSE 'не проходил Д и П' END  [D P] 
INTO zt
FROM ztemp_ztemp_du_bsk_adr AS t_du
LEFT JOIN (	
	SELECT dpo.FAM, dpo.IM, dpo.OT, dpo.DR, dzo.OS_SLUCH_REGION, dzo.DATE_Z_1
		FROM D3_ZSL_OMS AS dzo
		JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
			JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
				JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dzo.D3_SCID
		WHERE dso2.[YEAR] in (2025)
		AND dso2.SchetType IN ('DP','DO')	
	GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR,dzo.OS_SLUCH_REGION , dzo.DATE_Z_1
) AS t_p ON t_p.FAM = t_du.fam AND t_p.IM = t_du.im AND t_p.OT = t_du.ot AND t_p.DR = t_du.dr


-----------4.
-----------Союзная---------------------
SELECT distinct z.*, --t.*,
CASE WHEN p.fam IS NULL THEN 'Союзная' ELSE 'Заводская' END podr
FROM zt z
	--LEFT  JOIN zt2 t ON z.fam = t.fam AND z.im = t.Имя AND z.ot = t.Отчество AND z.dr = t.[Дата рождения]
		LEFT JOIN [dbo].[Perepis] p ON p.fam = z.fam 
										AND p.im = z.im
										AND p.ot = z.ot
										AND p.dr = z.dr
--WHERE t.fam IS null
-----------Заводская---------------------			

