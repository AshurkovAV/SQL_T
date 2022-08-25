/****** ������ ��� ������� SelectTopNRows �� ����� SSMS  ******/
SELECT   isnull(fam, '') + ' ' + isnull(Im , '') + ' ' +  isnull(ot,'') + ' ' + CONVERT(NVARCHAR(10), dr, 102),
AdrOmsRn, AdrOmsNaspunkt, AdrOmsUl, AdrOmsDom, AdrOmsKorp, AdrOmsKv, 
(SELECT sf.mcod + ' ' + sf.nam_mok FROM SPR_79_F003 AS sf WHERE sf.mcod = PrMo) 
  FROM [DocExchange].[dbo].[ATTP_People]
WHERE PrMoDtBeg = '20150901' 
AND (AdrOmsUl LIKE '%����%' 
	OR AdrOmsUl LIKE '%�������������%'
    OR AdrOmsUl LIKE '%�����������%'
OR AdrOmsUl LIKE '%�������%'
OR AdrOmsUl LIKE '%�������%'
OR AdrOmsUl LIKE '%���������������%'
OR AdrOmsUl LIKE '%�����������������%'
OR AdrOmsUl LIKE '%�������%'
OR AdrOmsUl LIKE '%�����%'
OR AdrOmsUl LIKE '%����������%'
OR AdrOmsUl LIKE '%����������������%'
OR AdrOmsUl LIKE '%�����������%'
OR AdrOmsUl LIKE '%����������%'
OR AdrOmsUl LIKE '%����������%'
OR AdrOmsUl LIKE '%������%'
OR AdrOmsUl LIKE '%������������%'
OR AdrOmsUl LIKE '%���������%'
OR AdrOmsUl LIKE '%������������%'
OR AdrOmsUl LIKE '%���������������%'
OR AdrOmsUl LIKE '%������������%'
OR AdrOmsUl LIKE '%����������%'
OR AdrOmsUl LIKE '%�����������%'
OR AdrOmsUl LIKE '%��������%'
OR AdrOmsUl LIKE '%�������%'
OR AdrOmsUl LIKE '%���������%'
OR AdrOmsUl LIKE '%�������������%'
OR AdrOmsUl LIKE '%��������%'
OR AdrOmsUl LIKE '%���������%'
OR AdrOmsUl LIKE '%������%'
OR AdrOmsUl LIKE '%���������%'
OR AdrOmsUl LIKE '%������%'
)  

AND PrMo != 460026 -- PrMoSpos IS NOT NULL and PrMoComment IS NOT NULL 
AND AdrOmsRn = '�����'
AND dr < '20000101' --�������� ���������
--GROUP BY PrMo
ORDER BY AdrOmsUl, AdrOmsDom