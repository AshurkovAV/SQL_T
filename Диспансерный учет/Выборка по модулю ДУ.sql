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