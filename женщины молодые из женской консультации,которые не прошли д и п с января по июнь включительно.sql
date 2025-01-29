DROP TABLE ztemp_not13
SELECT t1.* 
INTO ztemp_not13
FROM (
			SELECT DISTINCT dpo.FAM, dpo.IM, dpo.OT, dpo.DR, dzo.OS_SLUCH_REGION
			FROM D3_ZSL_OMS AS dzo
				JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
					JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
						JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dzo.D3_SCID	
							JOIN Yamed_Spr_MedicalEmployee AS ysme ON dso.IDDOKT = ysme.SNILS
			WHERE dso2.[YEAR] = 2024
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
			WHERE dso2.[YEAR] = 2024
			AND dzo.OS_SLUCH_REGION IN (47, 49)
			
		) AS t2 ON t2.FAM = t1.FAM AND t2.IM = t1.IM AND t2.OT = t1.OT AND t2.DR = t1.DR
		
WHERE t2.FAM IS NULL



--DROP TABLE ztemp_du_bsk
--DROP TABLE ztemp_ztemp_du_bsk_adr
-----------1 ���.
--DROP INDEX indX123 ON ztemp_du_bsk
		-------------�������� ������� � ����� --------------------
		SELECT tt.*, t.tel, ISNULL(ap.AdrOmsRn, '-') + ' ' + isnull(ap.AdrOmsNaspunkt, '-') + ' ' + isnull(ap.AdrOmsUl, '-') + ' ' + ISNULL(ap.AdrOmsDom, '-') + ' ' + isnull(ap.AdrOmsKorp, '-')  + ' ' + isnull(ap.AdrOmsKv, '-') addr
		INTO ztemp_ztemp_du_bsk_adr
		FROM ztemp_not13 tt 
			INNER JOIN [SQL_COD].[DocExchange].[dbo].[ATTP_People] as ap ON tt.FAM = ap.fam AND tt.IM = ap.im AND tt.OT = ap.ot AND tt.DR = ap.dr
				LEFT JOIN [test].[dbo].[Tel] t ON tt.fam=f and tt.im=i and tt.ot=o and tt.dr=d
		-------------�������� ������� � ����� --------------------

-----------2.		
DROP TABLE zt
GO
		
SELECT t_du.*,
     CASE WHEN t_p.OS_SLUCH_REGION IS NOT NULL THEN (SELECT osd.NameWithID
                                              FROM OsobSluchDb AS osd WHERE osd.Id = t_p.OS_SLUCH_REGION) + ' ' + CONVERT(NVARCHAR(10), DATE_Z_1, 110)
     ELSE '�� �������� � � �' END  [D P] 
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
-----------�������---------------------
SELECT distinct z.*
FROM zt z
LEFT JOIN [test].[dbo].[prikrep7KGP] p ON p.������� = fam 
									AND p.��� = im
									AND p.�������� = ot
WHERE p.������� IS NULL
-----------�������---------------------


-----------���������---------------------
SELECT distinct z.*
FROM zt z
LEFT JOIN [test].[dbo].[prikrep7KGP] p ON p.������� = fam 
									AND p.��� = im
									AND p.�������� = ot
WHERE p.������� IS not NULL
-----------���������---------------------			

