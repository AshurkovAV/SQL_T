--DROP TABLE ztemp_du_bsk
--DROP TABLE ztemp_ztemp_du_bsk_adr

--SELECT * FROM dubsk

-----------1 шаг.
SELECT t.ЕНП, t.Фамилия fam, t.Имя im, t.Отчество ot, t.Др dr, [Регистр#ДН#Диагнозы] ds, Адрес
INTO ztemp_du_bsk
FROM dubsk t  
--dbo.[f_ashur_du_bsk]() AS t
	LEFT JOIN  dbo.[f_ashur_du_bsk_reestr](2024) AS t1 ON t.Фамилия = t1.fam
														AND t.Имя = t1.IM
														AND t.Отчество = t1.ot
														AND t.[ДР] = t1.dr
WHERE t1.fam IS NULL

-----------2.
CREATE UNIQUE INDEX indX123 ON ztemp_du_bsk (pid);
		-------------Добавляю телефон и адрес --------------------
		SELECT tt.*, t.tel--, ISNULL(ap.AdrOmsRn, '-') + ' ' + isnull(ap.AdrOmsNaspunkt, '-') + ' ' + isnull(ap.AdrOmsUl, '-') + ' ' + ISNULL(ap.AdrOmsDom, '-') + ' ' + isnull(ap.AdrOmsKorp, '-')  + ' ' + isnull(ap.AdrOmsKv, '-') addr
		INTO ztemp_ztemp_du_bsk_adr
		FROM ztemp_du_bsk tt 
			--INNER JOIN [SQL_COD].[DocExchange].[dbo].[ATTP_People] as ap ON tt.PID=ap.ID
				LEFT JOIN [test].[dbo].[Tel] t ON tt.fam=f and tt.im=i and tt.ot=o and tt.dr=d
		-------------Добавляю телефон и адрес --------------------

-----------3.		
DROP TABLE zt
GO
		
SELECT t_du.*,
     CASE WHEN OS_SLUCH_REGION IS NOT NULL THEN (SELECT osd.NameWithID
                                              FROM OsobSluchDb AS osd WHERE osd.Id = OS_SLUCH_REGION) + ' ' + CONVERT(NVARCHAR(10), DATE_Z_1, 110)
     ELSE 'не проходил Д и П' END  [D P] 
INTO zt
FROM ztemp_ztemp_du_bsk_adr AS t_du
LEFT JOIN (	
	SELECT dpo.FAM, dpo.IM, dpo.OT, dpo.DR, dzo.OS_SLUCH_REGION, dzo.DATE_Z_1
		FROM D3_ZSL_OMS AS dzo
		JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
			JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
				JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dzo.D3_SCID
		WHERE dso2.[YEAR] in (2024)
		AND dso2.SchetType IN ('DP','DO')	
	GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR,dzo.OS_SLUCH_REGION , dzo.DATE_Z_1
) AS t_p ON t_p.FAM = t_du.fam AND t_p.IM = t_du.im AND t_p.OT = t_du.ot AND t_p.DR = t_du.dr


-----------4.
-----------Союзная---------------------
SELECT distinct z.*
FROM zt z
LEFT JOIN [test].[dbo].[prikrep7KGP] p ON p.Фамилия = fam 
									AND p.Имя = im
									AND p.Отчество = ot
WHERE p.Фамилия IS NULL
-----------Союзная---------------------


-----------Заводская---------------------
SELECT distinct z.*
FROM zt z
LEFT JOIN [test].[dbo].[prikrep7KGP] p ON p.Фамилия = fam 
									AND p.Имя = im
									AND p.Отчество = ot
WHERE p.Фамилия IS not NULL
-----------Заводская---------------------				
--
--
--

--INSERT INTO du_snyt (enp, fam, im,ot,ds1, dr)
--SELECT ЕНП,z.fam,z.im,z.ot,z.ds,z.dr
--from zt z			
		