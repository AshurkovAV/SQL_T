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
INTO ztemp_du
FROM [SQL_COD].[DocExchange].[dbo].[ATTP_DISP_ACCOUNT] as d
INNER JOIN [SQL_COD].[DocExchange].[dbo].[ATTP_People] as ap ON d.PID=ap.ID
WHERE ap.active=1 
AND ap.prmo=460026 
AND d.MO=460026  
AND d.dateend is  NULL
AND ds IS null
--AND d.DIAG10 BETWEEN 'E10' AND 'E11.9'  
--AND d.DIAG10 BETWEEN 'I20' AND 'I25.9'  
--AND  d.SNILS IN ('161-326-676 53','146-055-825 60')



SELECT *
FROM( SELECT * FROM ztemp_du ) AS t
LEFT join(
	SELECT DISTINCT dpo.FAM, dpo.IM,dpo.OT, dpo.DR, dpo.ENP, dso.DS1
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dzo ON dzo.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dzo.D3_SCID
WHERE 
((dso2.[YEAR] = 2020 AND dso2.[MONTH] IN(1,2,3,4,5,6,7) ) OR
 dso2.[YEAR] = 2021  OR 
(dso2.[YEAR] = 2022 AND dso2.[MONTH] IN (1,2,3,4,5,6,7))) 
AND dzo.USL_OK = 3
 ) AS t1 ON t.������� = t1.FAM AND t.��� = t1.IM AND t.�������� = t1.OT AND t.[���� ��������] = t1.DR
WHERE t1.FAM IS null
