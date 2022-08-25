SELECT dso.[MONTH], dso2.DS1, p.[���������������], COUNT(*)
FROM D3_SCHET_OMS AS dso
JOIN D3_ZSL_OMS AS dzo ON dzo.D3_SCID = dso.ID
JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
JOIN D3_SL_OMS AS dso2 ON dso2.D3_ZSLID = dzo.ID
LEFT JOIN test.dbo.prikrep_29102021 as p ON dpo.fam=p.[�������] and dpo.im=p.[���] and dpo.ot=p.[��������] and dpo.dr=p.[���� ��������]
WHERE dso.[YEAR] = 2021 

AND dso.[MONTH] IN (11) 
AND dso.NSCHET LIKE '%����%'
AND dso2.DS1 BETWEEN 'I00' AND 'I99.9' 
--AND dso2.P_CEL25 = '1.3'
GROUP BY dso.[MONTH], dso2.DS1, p.[���������������]



SELECT dso.[MONTH], dso2.DS1, --p.[���������������],
 COUNT(*)
FROM D3_SCHET_OMS AS dso
JOIN D3_ZSL_OMS AS dzo ON dzo.D3_SCID = dso.ID
JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
JOIN D3_SL_OMS AS dso2 ON dso2.D3_ZSLID = dzo.ID
LEFT JOIN test.dbo.prikrep_29102021 as p ON dpo.fam=p.[�������] and dpo.im=p.[���] and dpo.ot=p.[��������] and dpo.dr=p.[���� ��������]
WHERE dso.[YEAR] = 2021 
--AND DATEDIFF(dd, dpo.dr, dso2.DATE_2)/365.2524 <= 18
AND dso.[MONTH] IN (1,2,3,4,5,6,7,8,9,10) 
AND dso.NSCHET LIKE '%����%'
--AND dso2.DS1 BETWEEN 'I00' AND 'I99.9' 
AND dso2.P_CEL25 = '1.3'
GROUP BY dso.[MONTH], dso2.DS1--, p.[���������������]


SELECT dso.[MONTH], --p.[���������������],
 COUNT(*)
FROM D3_SCHET_OMS AS dso
JOIN D3_ZSL_OMS AS dzo ON dzo.D3_SCID = dso.ID
JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
JOIN D3_SL_OMS AS dso2 ON dso2.D3_ZSLID = dzo.ID
LEFT JOIN D3_DSS_OMS AS ddo ON ddo.D3_SLID = dso2.ID
LEFT JOIN test.dbo.prikrep_29102021 as p ON dpo.fam=p.[�������] and dpo.im=p.[���] and dpo.ot=p.[��������] and dpo.dr=p.[���� ��������]
WHERE dso.[YEAR] = 2021 
AND (( dso.[MONTH] IN (1,2,3,4,5,6,7,8,9,10) AND dso.NSCHET LIKE '%����%') OR (dso.[MONTH] IN (11) ))
AND dso2.DS1 BETWEEN 'I00' AND 'I99.9' 
AND dso2.P_CEL25 = '1.3'
GROUP BY dso.[MONTH]--, p.[���������������]

SELECT dso.[MONTH], --dzo.PR_NOV, --p.[���������������],
 COUNT(*)
FROM D3_SCHET_OMS AS dso
JOIN D3_ZSL_OMS AS dzo ON dzo.D3_SCID = dso.ID
JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
JOIN D3_SL_OMS AS dso2 ON dso2.D3_ZSLID = dzo.ID
LEFT JOIN D3_DSS_OMS AS ddo ON ddo.D3_SLID = dso2.ID
--LEFT JOIN test.dbo.prikrep_29102021 as p ON dpo.fam=p.[�������] and dpo.im=p.[���] and dpo.ot=p.[��������] and dpo.dr=p.[���� ��������]
WHERE dso.[YEAR] = 2021 
--AND DATEDIFF(dd, dpo.dr, dso2.DATE_2)/365.2524 <= 18
AND dso.[MONTH] IN (11) 
AND dso2.DS1 BETWEEN 'I00' AND 'I99.9' 
AND dso2.P_CEL25 = '1.3'
GROUP BY dso.[MONTH]--, dzo.PR_NOV--, p.[���������������]


---� ������� �� � ������� �����
SELECT 
(SELECT ysme.NameWithID
   FROM Yamed_Spr_MedicalEmployee AS ysme WHERE ysme.SNILS = dso2.IDDOKT),
--p.[���������������],
 COUNT(*)
FROM D3_SCHET_OMS AS dso
JOIN D3_ZSL_OMS AS dzo ON dzo.D3_SCID = dso.ID
JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
JOIN D3_SL_OMS AS dso2 ON dso2.D3_ZSLID = dzo.ID
--LEFT JOIN test.dbo.prikrep_29102021 as p ON dpo.fam=p.[�������] and dpo.im=p.[���] and dpo.ot=p.[��������] and dpo.dr=p.[���� ��������]
WHERE dso.[YEAR] = 2022
--AND DATEDIFF(dd, dpo.dr, dso2.DATE_2)/365.2524 <= 18
AND dso.[MONTH] IN (3) 
--AND dso.NSCHET LIKE '%����%'
--AND dso2.DS1 BETWEEN 'I00' AND 'I99.9' 
AND dso2.P_CEL25 = '1.3'
GROUP BY dso.[MONTH],dso2.IDDOKT





SELECT 
(SELECT ysme.NameWithID
   FROM Yamed_Spr_MedicalEmployee AS ysme WHERE ysme.SNILS =  dso2.IDDOKT) AS doc,
 (SELECT v.NameWithID FROM V002 AS v WHERE v.IDPR = profil) profil, 
--dzo.PR_NOV, --p.[���������������],
 COUNT(*)
FROM D3_SCHET_OMS AS dso
JOIN D3_ZSL_OMS AS dzo ON dzo.D3_SCID = dso.ID
JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
JOIN D3_SL_OMS AS dso2 ON dso2.D3_ZSLID = dzo.ID
LEFT JOIN D3_DSS_OMS AS ddo ON ddo.D3_SLID = dso2.ID
--LEFT JOIN test.dbo.prikrep_29102021 as p ON dpo.fam=p.[�������] and dpo.im=p.[���] and dpo.ot=p.[��������] and dpo.dr=p.[���� ��������]
WHERE dso.[YEAR] = 2022
--AND DATEDIFF(dd, dpo.dr, dso2.DATE_2)/365.2524 <= 18
AND dso.[MONTH] IN (1,2,3,4) 
--AND dso2.DS1 BETWEEN 'I00' AND 'I99.9' 
--AND dso2.PROFIL = 97
AND dso2.P_CEL25 = '1.3'
GROUP BY dso2.IDDOKT, dso2.PROFIL
ORDER BY dso2.PROFIL



-------��� ����������� ��������� ��� �� ������� ����� 2�� ���
/*
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
    INTO ztemp_mopr7
FROM [SQL_COD].[DocExchange].[dbo].[ATTP_DISP_ACCOUNT] as d
INNER JOIN [SQL_COD].[DocExchange].[dbo].[ATTP_People] as ap ON d.PID=ap.ID
WHERE ap.active=1 
AND ap.prmo=460006 
AND d.MO=460006  
AND d.dateend is  NULL


SELECT DISTINCT dpo.FAM, dpo.IM, dpo.OT, dpo.DR, dpo.ENP, dso.DS1, dzo.DATE_Z_1
INTO ztemp_mo7
FROM TFOMS.ELMEDICINENEWFOND.dbo.D3_ZSL_OMS AS dzo
JOIN TFOMS.ELMEDICINENEWFOND.dbo.D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
JOIN TFOMS.ELMEDICINENEWFOND.dbo.D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
--JOIN TFOMS.ELMEDICINENEWFOND.dbo.D3_SCHET_OMS AS dso2 ON dso2.ID = dzo.D3_SCID
WHERE dzo.d3_scid IN (	

)
-- (dso2.[YEAR] IN (2020) AND  dso2.[MONTH] IN (8,9,10,11,12)) OR  dso2.[YEAR] IN (2021, 2022)
--AND dso2.CODE_MO = 460006 AND dzo.USL_OK = 3


SELECT *
FROM 
(SELECT * FROM ztemp_mopr7) AS t2
LEFT JOIN 
(select * 
FROM [master].[dbo].[ztemp_mo7]) AS t ON t.FAM = t2.[�������] AND t.IM = t2.[���] AND t.OT = t2.[��������] AND t.DR = t2.[���� ��������]

WHERE t.fam IS NULL
*/