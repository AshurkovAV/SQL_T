SELECT *, CASE WHEN doc LIKE '700%' THEN 'ЗАВОДСКАЯ' ELSE 'СОЮЗНАЯ' END gb
FROM(
SELECT  DISTINCT   
    ap.fam [Фамилия],
    ap.im [Имя],
    ap.ot [Отчество],
    format(ap.dr,'dd.MM.yyyy') as [дата рождения],
    d.[DIAG10] [мкб10],
    ap.AdrOmsRegion [Регион], 
    ap.AdrOmsNaspunkt [Город], 
    ap.AdrOmsUl [Улица], 
    ap.AdrOmsDom [Дом], 
    ap.AdrOmsKorp [Корпус], 
    ap.AdrOmsKv [Квартира], 
    ap.Phone[Телефон],
    ISNULL((SELECT TOP 1 ysme.NameWithID
   FROM Yamed_Spr_MedicalEmployee AS ysme WHERE ysme.SNILS =  d.SNILS), d.SNILS) AS doc
    
FROM [SQL_COD].[DocExchange].[dbo].[ATTP_DISP_ACCOUNT] as d
INNER JOIN [SQL_COD].[DocExchange].[dbo].[ATTP_People] as ap ON d.PID=ap.ID
WHERE ap.active=1 
AND ap.prmo=460026 
AND d.MO IN (460026, 460006)  
AND d.dateend is  NULL
AND ds IS NULL
AND d.DIAG10 IN ('I50.0', 'I50.1', 'I50.9', 'I10', 'I11', 'I12', 'I13', 'I15','I20.1','I20.8', 'I20.9','I25.1','I25.2','I25.5', 'I25.6','I25.8','I25.9','I48',
'I47','I69.0','I69.1','I69.2','I69.3','I69.4','I67.8', 'I65.2')
) AS t



SELECT  DISTINCT   
    ap.fam,
    ap.im,
    ap.ot,
    format(ap.dr,'dd.MM.yyyy') as [дата рождения],
    p.[НАШНОМЕРУЧАСТКА],
    d.[DIAG10]
    
FROM [SQL_COD].[DocExchange].[dbo].[ATTP_DISP_ACCOUNT] as d
INNER JOIN [SQL_COD].[DocExchange].[dbo].[ATTP_People] as ap ON d.PID=ap.ID
LEFT JOIN dbo.prikrep_29102021 as p ON ap.fam=p.[ФАМИЛИЯ] and ap.im=p.[ИМЯ] and ap.ot=p.[ОТЧЕСТВО] and ap.dr=p.[ДАТА РОЖДЕНИЯ]

WHERE ap.active=1 
AND ap.prmo=460026 
AND d.MO=460026  
AND p.[код мо]=460026 
AND d.dateend is  NULL
AND d.DIAG10 BETWEEN 'I00' AND 'I99.9' 


SELECT  DISTINCT   
    ap.fam [Фамилия],
    ap.im [Имя],
    ap.ot [Отчество],
    format(ap.dr,'dd.MM.yyyy') as [дата рождения],
    d.[DIAG10] [мкб10],
    ap.AdrOmsRegion [Регион], 
    ap.AdrOmsNaspunkt [Город], 
    ap.AdrOmsUl [Улица], 
    ap.AdrOmsDom [Дом], 
    ap.AdrOmsKorp [Корпус], 
    ap.AdrOmsKv [Квартира], 
    ap.Phone[Телефон],
    (SELECT TOP 1 ysme.NameWithID
   FROM Yamed_Spr_MedicalEmployee AS ysme WHERE ysme.SNILS =  d.SNILS) AS doc
    
FROM [SQL_COD].[DocExchange].[dbo].[ATTP_DISP_ACCOUNT] as d
INNER JOIN [SQL_COD].[DocExchange].[dbo].[ATTP_People] as ap ON d.PID=ap.ID
WHERE ap.active=1 
AND ap.prmo=460026 
AND d.MO=460026  
AND d.dateend is  NULL
--AND d.DIAG10 BETWEEN 'E10' AND 'E11.9'  
AND d.DIAG10 BETWEEN 'I20' AND 'I25.9'  
--AND  d.SNILS IN ('161-326-676 53','146-055-825 60')




SELECT DIAG10, SUM(kol) kol
FROM(
SELECT pid, d.DIAG10, 1 kol    
FROM [dbo].[ATTP_DISP_ACCOUNT] as d
INNER JOIN [dbo].[ATTP_People] as ap ON d.PID=ap.ID
WHERE ap.active=1 
AND ap.prmo=460026 
AND d.MO=460026  
AND d.dateend IS NULL
AND d.DIAG10 LIKE 'I%'  
GROUP BY pid, d.DIAG10) AS t
GROUP BY t.DIAG10




----Количество пациентов состоящих наДУ
SELECT  ap.Fam, ap.Im, ap.Ot, ap.Dr
    
FROM [DocExchange].[dbo].[ATTP_DISP_ACCOUNT] as d
INNER JOIN [DocExchange].[dbo].[ATTP_People] as ap ON d.PID=ap.ID
WHERE ap.active=1 
AND ap.prmo=460026 
AND d.MO=460026  
AND ap.Ds IS NULL
AND d.dateend is  NULL
--AND d.DIAG10 BETWEEN 'E10' AND 'E11.9'  
AND( d.DIAG10 IN ('I50.0', 'I50.1', 'I20.1','I20.8', 'I50.9', 'I20.9','I25.1','I25.2','I25.5', 'I25.6','I25.8','I25.9','I69.0','I69.1','I69.2','I69.3','I69.4','I67.8', 'I65.2') OR
d.DIAG10 BETWEEN 'I10' AND 'I10.9' OR 
d.DIAG10 BETWEEN 'I11' AND 'I11.9' OR 
d.DIAG10 BETWEEN 'I12' AND 'I12.9' OR 
d.DIAG10 BETWEEN 'I13' AND 'I13.9' OR 
d.DIAG10 BETWEEN 'I15' AND 'I15.9' OR
d.DIAG10 BETWEEN 'I48' AND 'I48.9' OR
d.DIAG10 BETWEEN 'I47' AND 'I47.9' 
) 
GROUP BY ap.Fam, ap.Im, ap.Ot, ap.Dr





SELECT  ap.Fam, ap.Im, ap.Ot, ap.Dr, d.diag10,
    CASE WHEN ysme.LPU_ID = 460006 THEN 'ЗАВОДСКАЯ' ELSE 'СОЮЗНАЯ' END gb
INTO ztemp_du0512_1
FROM [SQL_COD].[DocExchange].[dbo].[ATTP_DISP_ACCOUNT] as d
INNER JOIN [SQL_COD].[DocExchange].[dbo].[ATTP_People] as ap ON d.PID=ap.ID
LEFT JOIN Yamed_Spr_MedicalEmployee AS ysme ON ysme.SNILS = d.snils
WHERE ap.active=1 
AND ap.prmo=460026 
AND d.MO IN (460026, 460006) 
AND ap.Ds IS NULL
AND d.dateend is  NULL
--AND d.DIAG10 BETWEEN 'E10' AND 'E11.9'  
AND( d.DIAG10 IN ('I50.0', 'I50.1', 'I20.1','I20.8', 'I50.9', 'I20.9','I25.1','I25.2','I25.5', 'I25.6','I25.8','I25.9','I69.0','I69.1','I69.2','I69.3','I69.4','I67.8', 'I65.2') OR
d.DIAG10 BETWEEN 'I10' AND 'I10.9' OR 
d.DIAG10 BETWEEN 'I11' AND 'I11.9' OR 
d.DIAG10 BETWEEN 'I12' AND 'I12.9' OR 
d.DIAG10 BETWEEN 'I13' AND 'I13.9' OR 
d.DIAG10 BETWEEN 'I15' AND 'I15.9' OR
d.DIAG10 BETWEEN 'I48' AND 'I48.9' OR
d.DIAG10 BETWEEN 'I47' AND 'I47.9' 
) 
GROUP BY ap.Fam, ap.Im, ap.Ot, ap.Dr, d.diag10, ysme.LPU_ID




SELECT  ap.Fam, ap.Im, ap.Ot, ap.Dr, dbo.GROUP_CONCAT_DS(DISTINCT DIAG10, N' , ', 1) DS  ,
    CASE WHEN ysme.LPU_ID = 460006 THEN 'ЗАВОДСКАЯ' 
         WHEN ysme.LPU_ID = 460026 THEN 'СОЮЗНАЯ' 
    ELSE 'МО не определена' END gb
--INTO ztemp_du0512_1
FROM [SQL_COD].[DocExchange].[dbo].[ATTP_DISP_ACCOUNT] as d
INNER JOIN [SQL_COD].[DocExchange].[dbo].[ATTP_People] as ap ON d.PID=ap.ID
LEFT JOIN Yamed_Spr_MedicalEmployee AS ysme ON ysme.SNILS = d.snils
WHERE ap.active=1 
AND ap.prmo=460026 
AND d.MO IN (460026, 460006) 
AND ap.Ds IS NULL
AND d.dateend is  NULL
--AND d.DIAG10 BETWEEN 'E10' AND 'E11.9'  
AND( d.DIAG10 IN ('I50.0', 'I50.1', 'I20.1','I20.8', 'I50.9', 'I20.9','I25.1','I25.2','I25.5', 'I25.6','I25.8','I25.9','I69.0','I69.1','I69.2','I69.3','I69.4','I67.8', 'I65.2') OR
d.DIAG10 BETWEEN 'I10' AND 'I10.9' OR 
d.DIAG10 BETWEEN 'I11' AND 'I11.9' OR 
d.DIAG10 BETWEEN 'I12' AND 'I12.9' OR 
d.DIAG10 BETWEEN 'I13' AND 'I13.9' OR 
d.DIAG10 BETWEEN 'I15' AND 'I15.9' OR
d.DIAG10 BETWEEN 'I48' AND 'I48.9' OR
d.DIAG10 BETWEEN 'I47' AND 'I47.9' 
) 
GROUP BY ap.Fam, ap.Im, ap.Ot, ap.Dr, ysme.LPU_ID