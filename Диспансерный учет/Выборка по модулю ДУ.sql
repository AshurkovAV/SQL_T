SELECT  DISTINCT   
    ap.fam,
    ap.im,
    ap.ot,
    format(ap.dr,'dd.MM.yyyy') as [���� ��������],
    p.[���������������],
    d.[DIAG10]
    
FROM [SQL_COD].[DocExchange].[dbo].[ATTP_DISP_ACCOUNT] as d
INNER JOIN [SQL_COD].[DocExchange].[dbo].[ATTP_People] as ap ON d.PID=ap.ID
LEFT JOIN dbo.prikrep_29102021 as p ON ap.fam=p.[�������] and ap.im=p.[���] and ap.ot=p.[��������] and ap.dr=p.[���� ��������]

WHERE ap.active=1 
AND ap.prmo=460026 
AND d.MO=460026  
AND p.[��� ��]=460026 
AND d.dateend is  NULL
AND d.DIAG10 BETWEEN 'I00' AND 'I99.9' 


SELECT  DISTINCT   
    ap.fam [�������],
    ap.im [���],
    ap.ot [��������],
    format(ap.dr,'dd.MM.yyyy') as [���� ��������],
    d.[DIAG10] [���10],
    ap.AdrOmsRegion [������], 
    ap.AdrOmsNaspunkt [�����], 
    ap.AdrOmsUl [�����], 
    ap.AdrOmsDom [���], 
    ap.AdrOmsKorp [������], 
    ap.AdrOmsKv [��������], 
    ap.Phone[�������],
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