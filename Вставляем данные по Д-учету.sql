DECLARE @doc NVARCHAR(20) = '141-347-479-48'
DECLARE @ds NVARCHAR(5) = 'I11'

INSERT INTO SQL_COD.DocExchange.dbo.ATTP_DISP_ACCOUNT  ([PID],[ENP],[MO],[DIAG10],[SNILS],[PRVS],[DATEBEG])
SELECT TOP 26 id, enp, 460026, DS1, @doc, t2.prvs, t2.DATE_Z_1 
FROM SQL_COD.DocExchange.dbo.ATTP_People AS ap
JOIN (

SELECT DISTINCT t.FAM, t.IM, t.OT, t.DR, t.DS1, min(t.DATE_Z_1)DATE_Z_1, t.prvs
FROM (
SELECT dpo.FAM, dpo.IM, dpo.OT, dpo.DR, dso.DS1, dzo.DATE_Z_1, dso.IDDOKT, dso.PRVS
FROM D3_ZSL_OMS AS dzo
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dzo.D3_SCID
WHERE dso.IDDOKT = '141-347-479 48' 
AND (dso.DS1 LIKE 'i11%' OR
dso.DS1 LIKE 'i20%' OR 
dso.DS1 LIKE 'i25%' OR
dso.DS1 LIKE 'i67%' OR
dso.DS1 LIKE 'k25%' OR
dso.DS1 LIKE 'k29%' OR
dso.DS1 LIKE 'm15%' OR
dso.DS1 LIKE 'm17%' OR
dso.DS1 LIKE 'j42%' OR
dso.DS1 LIKE 'm05%' OR
dso.DS1 LIKE 'm32%' OR
dso.DS1 LIKE 'm10%' OR
dso.DS1 LIKE 'l40%' OR
dso.DS1 LIKE 'm45%' OR
dso.DS1 LIKE 'm81%') 
AND dso2.[YEAR] = 2018) AS t
LEFT JOIN (
SELECT ap.Fam, ap.Im, ap.Ot, ap.Dr, ada.DIAG10, ada.SNILS
FROM SQL_COD.DocExchange.dbo.ATTP_DISP_ACCOUNT AS ada
JOIN SQL_COD.DocExchange.dbo.ATTP_People AS ap ON ap.ID = ada.PID
JOIN (SELECT fio, ad.snils FROM SQL_COD.DocExchange.dbo.ATTP_Docs AS ad WHERE ad.Mo = 460026 GROUP BY ad.snils, ad.FIO) AS doc ON doc.snils = ada.SNILS
WHERE mo = 460026 AND doc.snils in (@doc)--, '140-847-262 56', '155-744-373 87')
--AND ada.DIAG10 = @ds
AND (
ada.DIAG10 LIKE 'i11%' OR
ada.DIAG10 LIKE 'i20%' OR 
ada.DIAG10 LIKE 'i25%' OR
ada.DIAG10 LIKE 'i67%' OR
ada.DIAG10 LIKE 'k25%' OR
ada.DIAG10 LIKE 'k29%' OR
ada.DIAG10 LIKE 'm15%' OR
ada.DIAG10 LIKE 'm17%' OR
ada.DIAG10 LIKE 'j42%' OR
ada.DIAG10 LIKE 'm05%' OR
ada.DIAG10 LIKE 'm32%' OR
ada.DIAG10 LIKE 'm10%' OR
ada.DIAG10 LIKE 'l40%' OR
ada.DIAG10 LIKE 'm45%' OR
ada.DIAG10 LIKE 'm81%')
) AS t1 ON t1.FAM = t.FAM AND t1.IM = t.IM AND t1.OT = t.OT AND t1.DR = t.DR
WHERE t1.Fam IS NULL
--GROUP BY ada.SNILS, ada.DIAG10
GROUP BY t.FAM, t.IM, t.OT, t.DR, t.DS1, prvs) AS t2 ON t2.FAM = ap.FAM AND t2.IM = ap.IM AND t2.OT = ap.OT AND t2.DR = ap.DR
WHERE prmo = 460026 AND id NOT in ( 255224,225762)