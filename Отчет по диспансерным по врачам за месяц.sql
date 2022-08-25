SELECT 
(SELECT TOP 1 ysme.NameWithID
   FROM Yamed_Spr_MedicalEmployee AS ysme WHERE  ysme.SNILS =  dso.IDDOKT) doc,
(SELECT v.NameWithID FROM v002 v WHERE v.IDPR = profil) profil, COUNT (*)
FROM D3_ZSL_OMS AS dzo
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
LEFT JOIN D3_DSS_OMS AS ddo ON ddo.D3_SLID = dso.ID
WHERE dzo.D3_SCID = 4209
AND dso.P_CEL = '1.3'
AND dzo.DATE_Z_1 BETWEEN '20220701' AND '2022071'
GROUP BY dso.IDDOKT, dso.PROFIL
ORDER BY profil

--Ќа базе тфомс по диагнозам I

SELECT 
(SELECT f.NameWithID FROM F003 AS f WHERE f.mcod = dso2.CODE_MO) MO 
, COUNT (*)
FROM D3_ZSL_OMS AS dzo
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
LEFT JOIN D3_DSS_OMS AS ddo ON ddo.D3_SLID = dso.ID AND ddo.DS LIKE 'I%'
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dzo.D3_SCID
WHERE dso.P_CEL25 = '1.3'
AND dso2.[YEAR] = 2022 AND dso2.[MONTH] IN (1,2,3,4,5,6)
AND (dso.DS1 LIKE 'I%' OR ddo.DS LIKE 'I%')
--AND dzo.DATE_Z_1 BETWEEN '20220101' AND '2022071'
GROUP BY dso2.CODE_MO
ORDER BY profil

SELECT 
(SELECT f.NameWithID FROM F003 AS f WHERE f.mcod = dso2.CODE_MO) MO,
CASE WHEN  dso.DS1 LIKE 'I%' THEN DS1 ELSE ddo.DS END ds,
CASE WHEN  dso.DS1 LIKE 'I%' THEN 'в основном заболевании' ELSE 'в сопуст' END name
, COUNT (*)
FROM D3_ZSL_OMS AS dzo
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
LEFT JOIN D3_DSS_OMS AS ddo ON ddo.D3_SLID = dso.ID AND ddo.DS LIKE 'I%'
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dzo.D3_SCID
WHERE dso.P_CEL25 = '1.3'
AND dso2.[YEAR] = 2022 AND dso2.[MONTH] IN (1,2,3,4,5,6) 
AND dso2.CODE_MO IN (460006, 460026)
AND (dso.DS1 LIKE 'I%' OR ddo.DS LIKE 'I%')
--AND dzo.DATE_Z_1 BETWEEN '20220101' AND '2022071'
GROUP BY dso2.CODE_MO, CASE WHEN  dso.DS1 LIKE 'I%' THEN 'в основном заболевании' ELSE 'в сопуст' END, CASE WHEN  dso.DS1 LIKE 'I%' THEN DS1 ELSE ddo.DS END




