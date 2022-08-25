SELECT dpo.*, AdrOmsOkato + ' ' + AdrOmsRegion  + ' ' + AdrOmsRn + ' ' +AdrOmsNaspunkt + ' ' +AdrOmsUl + ' ' +AdrOmsDom + ' ' +AdrOmsKorp + ' ' +AdrOmsKv

FROM (
SELECT dpo.NPOLIS, dpo.FAM, dpo.IM, dpo.OT, dpo.DR, dso.NHISTORY, dzo.DATE_Z_1, dzo.DATE_Z_2, dso.DS1
FROM D3_ZSL_OMS AS dzo
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dzo.D3_SCID
WHERE dzo.D3_SCID IN ( 3862, 3869, 3957 ) AND dzo.USL_OK = 1 AND dzo.RSLT = 105 AND dzo.PR_NOV = 0) dpo
LEFT JOIN(
SELECT *
FROM [SQL_COD].[DocExchange].[dbo].[ATTP_People]) ap ON dpo.NPOLIS = ap.enp