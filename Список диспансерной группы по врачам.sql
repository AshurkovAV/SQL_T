SELECT ada.SNILS, doc.fio--*
--(SELECT TOP 1 fio FROM ATTP_Docs AS ad WHERE ad.snils = ada.SNILS)doc, COUNT(*)
FROM ATTP_DISP_ACCOUNT AS ada
JOIN (SELECT fio, ad.snils FROM ATTP_Docs AS ad WHERE ad.Mo = 460026 GROUP BY ad.snils, ad.FIO) AS doc ON doc.snils = ada.SNILS
WHERE mo = 460026 AND doc.snils in ('152-443-755 54', '140-847-262 56', '155-744-373 87') --('034-574-091 51', '137-881-294-00')
GROUP BY ada.SNILS, doc.fio
ORDER BY fio