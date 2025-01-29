DROP TABLE ztemp_reestr
SELECT t.*
INTO ztemp_reestr
FROM dbo.f_ashur_reestr(2024) t  
	LEFT JOIN  dbo.[f_ashur_du_bsk_reestr](2024) AS t1 ON t.fam = t1.fam
														AND t.IM = t1.IM
														AND t.ot = t1.ot
														AND t.dr = t1.dr
WHERE t1.fam IS NULL

DROP TABLE zt
DROP TABLE ztemp_ztemp_du_bsk_adr

SELECT tt.*, t.tel--, ISNULL(ap.AdrOmsRn, '-') + ' ' + isnull(ap.AdrOmsNaspunkt, '-') + ' ' + isnull(ap.AdrOmsUl, '-') + ' ' + ISNULL(ap.AdrOmsDom, '-') + ' ' + isnull(ap.AdrOmsKorp, '-')  + ' ' + isnull(ap.AdrOmsKv, '-') addr
		INTO ztemp_ztemp_du_bsk_adr
		FROM ztemp_reestr tt 
			LEFT JOIN [test].[dbo].[Tel] t ON tt.fam=f and tt.im=i and tt.ot=o and tt.dr=d

SELECT t.Фамилия fam, t.Имя im, t.Отчество ot, t.Др dr, [Регистр#ДН#Диагнозы] ds, Адрес, namewithid, dso, tel
INTO zt
FROM du2908$ t 
	JOIN ztemp_ztemp_du_bsk_adr AS t1 ON t.Фамилия = t1.fam
									AND t.Имя = t1.IM
									AND t.Отчество = t1.ot
									AND t.[ДР] = t1.dr



SELECT *
FROM ztemp_reestr