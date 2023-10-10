use elmed
go

SELECT ap.fam, im, ot, dr, ada.DIAG10,
[НАШНОМЕРУЧАСТКА], 

ISNULL(ap.phone, t.tel)tel,

ISNULL(ap.AdrOmsRn, '-') + ' ' + isnull(ap.AdrOmsNaspunkt, '-') + ' ' + isnull(ap.AdrOmsUl, '-') + ' ' + ISNULL(ap.AdrOmsDom, '-') + ' ' + isnull(ap.AdrOmsKorp, '-')  + ' ' + isnull(ap.AdrOmsKv, '-') addr
FROM sql_cod.DocExchange.dbo.ATTP_People AS ap
JOIN sql_cod.DocExchange.dbo.ATTP_DISP_ACCOUNT AS ada ON ap.ID = ada.PID
LEFT JOIN [test].[dbo].[prikrep_29102021] on fam=[Фамилия] and im=[имя] and ot=[Отчество] and dr=[Дата рождения]
LEFT JOIN [test].[dbo].[Tel] t ON fam=f and im=i and ot=o and dr=d

WHERE ap.PrMo = 460026 
AND ada.DATEEND IS NULL
AND ada.MO = 460026
AND ap.Ds IS NULL
AND [НАШНОМЕРУЧАСТКА] = 11
ORDER BY [НАШНОМЕРУЧАСТКА]