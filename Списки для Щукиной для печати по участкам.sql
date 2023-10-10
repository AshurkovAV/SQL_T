--DROP TABLE ztemp_du_bsk
--DROP TABLE ztemp_ztemp_du_bsk_adr
SELECT ap.Fam, ap.Im, ap.Ot, ap.Dr, 
	dbo.GROUP_CONCAT_DS(DISTINCT DIAG10, N' , ', 1) DS, MAX(ap.id)pid, ysme.NameWithID doc
INTO ztemp_du_bsk
FROM [SQL_COD].[DocExchange].[dbo].[ATTP_DISP_ACCOUNT] as d
	INNER JOIN [SQL_COD].[DocExchange].[dbo].[ATTP_People] as ap ON d.PID=ap.ID
	LEFT JOIN Yamed_Spr_MedicalEmployee AS ysme ON ysme.SNILS = d.snils
	WHERE ap.active=1 AND ap.prmo=460026 AND d.MO IN (460026) 
	AND ap.Ds IS NULL AND d.dateend is  NULL 

GROUP BY ap.Fam, ap.Im, ap.Ot, ap.Dr, ysme.NameWithID

		--CREATE UNIQUE INDEX indX123 ON ztemp_du_bsk (pid);
		-------------Добавляю телефон и адрес --------------------
		SELECT tt.*, t.tel, ISNULL(ap.AdrOmsRn, '-') + ' ' + isnull(ap.AdrOmsNaspunkt, '-') + ' ' + isnull(ap.AdrOmsUl, '-') + ' ' + ISNULL(ap.AdrOmsDom, '-') + ' ' + isnull(ap.AdrOmsKorp, '-')  + ' ' + isnull(ap.AdrOmsKv, '-') addr
		INTO ztemp_ztemp_du_bsk_adr
		FROM ztemp_du_bsk tt 
		INNER JOIN [SQL_COD].[DocExchange].[dbo].[ATTP_People] as ap ON tt.PID=ap.ID
		LEFT JOIN [test].[dbo].[Tel] t ON tt.fam=f and tt.im=i and tt.ot=o and tt.dr=d
		-------------Добавляю телефон и адрес --------------------

SELECT t_du.*,
CASE WHEN OS_SLUCH_REGION IS NOT NULL THEN (SELECT osd.NameWithID
                                              FROM OsobSluchDb AS osd WHERE osd.Id = OS_SLUCH_REGION) + ' ' + CONVERT(NVARCHAR(10), DATE_Z_1, 110)
     ELSE 'не проходил Д и П' END  [D P] 
FROM ztemp_ztemp_du_bsk_adr AS t_du
LEFT JOIN (	
	SELECT dpo.FAM, dpo.IM, dpo.OT, dpo.DR, dzo.OS_SLUCH_REGION, dzo.DATE_Z_1
		FROM D3_ZSL_OMS AS dzo
		JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
		JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
		JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dzo.D3_SCID
		WHERE dso2.[YEAR] in (2023)
		AND dso2.SchetType IN ('DP','DO')	
	GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR,dzo.OS_SLUCH_REGION , dzo.DATE_Z_1
) AS t_p ON t_p.FAM = t_du.fam AND t_p.IM = t_du.im AND t_p.OT = t_du.ot AND t_p.DR = t_du.dr