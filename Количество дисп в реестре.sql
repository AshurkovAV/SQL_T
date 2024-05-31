SELECT dzo.OS_SLUCH_REGION, COUNT(*)
FROM D3_ZSL_OMS AS dzo
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dzo.D3_SCID
JOIN D3_USL_OMS AS duo ON duo.D3_SLID = dso.ID
WHERE dso.IDDOKT = '140-847-262 56'
AND dso.P_CEL25 = '1.3'
AND dso2.[YEAR] = 2023 
AND dso2.NSCHET LIKE '%+%'
GROUP BY dzo.OS_SLUCH_REGION


SELECT *
FROM Yamed_Spr_MedicalEmployee AS ysme
WHERE ysme.FAM = 'гречушникова'

SELECT (SELECT osd.NameWithID
          FROM OsobSluchDb AS osd WHERE osd.Id = OS_SLUCH_REGION), COUNT(*)
FROM D3_ZSL_OMS AS dzo
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dzo.D3_SCID
WHERE 
dso2.[YEAR] = 2024 AND dso2.[MONTH] = 4 AND dzo.OS_SLUCH_REGION IN (47,49,50)
GROUP BY dzo.OS_SLUCH_REGION

SELECT ysme.LPU_ID,
--(SELECT yu.UserName FROM Yamed_Users AS yu WHERE yu.ID = dzo.USERID)us,  
COUNT(*)
FROM D3_ZSL_OMS AS dzo
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dzo.D3_SCID
JOIN Yamed_Spr_MedicalEmployee AS ysme ON ysme.SNILS = dso.IDDOKT
WHERE 
dso2.[YEAR] = 2024 AND dso2.[MONTH] = 4 AND dzo.OS_SLUCH_REGION IN (47,49,50)
--AND dzo.EXP_COMENT IS NULL
GROUP BY ysme.LPU_ID

SELECT 
--(SELECT yu.UserName FROM Yamed_Users AS yu WHERE yu.ID = dzo.USERID)us,  
COUNT(*)
FROM D3_ZSL_OMS AS dzo
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dzo.D3_SCID
JOIN Yamed_Spr_MedicalEmployee AS ysme ON ysme.SNILS = dso.IDDOKT
WHERE 
dso2.[YEAR] = 2024 AND dso2.[MONTH] = 4 AND dzo.OS_SLUCH_REGION IN (47,49,50)


---по врачам 
SELECT (SELECT osd.NameWithID
          FROM OsobSluchDb AS osd WHERE osd.Id = OS_SLUCH_REGION),
          (SELECT ysme.NameWithID
             FROM Yamed_Spr_MedicalEmployee AS ysme WHERE ysme.SNILS = dso.IDDOKT)DOC, COUNT(*)
FROM D3_ZSL_OMS AS dzo
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dzo.D3_SCID
WHERE 
dso2.[YEAR] = 2024 AND dso2.[MONTH] = 4 AND dzo.OS_SLUCH_REGION IN (47,49,50)
GROUP BY dzo.OS_SLUCH_REGION, dso.IDDOKT