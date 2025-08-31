if OBJECT_ID('zsd1')  is not null DROP TABLE zsd1

SELECT dpo.FAM, dpo.IM, dpo.OT, dpo.DR, dzo.DATE_Z_2
INTO zsd1
			FROM D3_SCHET_OMS AS dso2
				JOIN D3_ZSL_OMS AS dzo							   ON dzo.D3_SCID  = dso2.ID
					JOIN D3_PACIENT_OMS AS dpo					   ON dpo.ID       = dzo.D3_PID
						JOIN D3_SL_OMS AS dso					   ON dso.D3_ZSLID = dzo.ID
							JOIN Yamed_Spr_MedicalEmployee AS ysme ON ysme.SNILS = dso.IDDOKT
			WHERE 
				  (dso2.[YEAR] = 2025 AND dso2.[MONTH] IN (1,2,3,4,5,6,7)) AND dzo.USL_OK = 2 AND ysme.LPU_ID = 460006
				  
				  

------------//2 находим кто из них уже прошел вд и по//----------------
if OBJECT_ID('zs1')  is not null DROP TABLE zs1		  
SELECT t.*
INTO zs1 
	FROM zsd1 AS t
		LEFT JOIN (
				SELECT dpo.FAM, dpo.IM, dpo.OT, dpo.DR, dbo.GROUP_CONCAT_DS(DISTINCT dzo.OS_SLUCH_REGION , N' , ', 1)OS_SLUCH_REGION
				FROM D3_ZSL_OMS AS dzo
					JOIN D3_SL_OMS AS dso               ON dso.D3_ZSLID = dzo.ID
						JOIN D3_SCHET_OMS AS dso2       ON dso2.ID      = dzo.D3_SCID
							JOIN D3_PACIENT_OMS AS dpo  ON dpo.ID       = dzo.D3_PID
				WHERE dso2.[YEAR] IN (2025)
					AND dzo.OS_SLUCH_REGION IN (47,49,50) 
				GROUP BY  dpo.FAM, dpo.IM, dpo.OT, dpo.DR) AS t1 ON t.fam = t1.FAM 
																	AND t.im = t1.IM 
																	AND t.ot = t1.OT 
																	AND t.dr = t1.DR
WHERE  t1.FAM IS NULL


------------//3 проставляем телефоны//----------------
if OBJECT_ID('zt1') is not null DROP TABLE zt1

SELECT tt.*, t.MOBIL_TELEFON
INTO zt1
FROM(
	SELECT *
	FROM zs1 ) AS tt
LEFT JOIN telefon1 AS t ON tt.fam=t.NOM and tt.im= t.PRENOM and tt.ot=t.PATRONYME and tt.dr=t.NE_LE

SELECT *
FROM zt1
