use elmed
go

SELECT dl.TargetQuarter [�������], ap.Fam, ap.Im, ap.Ot, 
CAST(ap.Dr AS DATE)[���� ��������], 
ap.ENP[����� ������],
[���������������], 
CASE WHEN dl.DispType ='��4' THEN '��4 ������ ���� ��������������� ������������ ����� ��������� ���������'
	WHEN dl.DispType ='���' THEN '��� ���������������� ����������� ������� ��������� ���������'
	WHEN dl.DispType ='��1' THEN '��1 ������ ���� ����������� ��������������� ������������ ����� ��������� ���������'
	ELSE '��� � �����������' END [���], 
ISNULL(ap.phone, t.tel)tel,

ISNULL(ap.AdrOmsRn, '-') + ' ' + isnull(ap.AdrOmsNaspunkt, '-') + ' ' + isnull(ap.AdrOmsUl, '-') + ' ' + ISNULL(ap.AdrOmsDom, '-') + ' ' + isnull(ap.AdrOmsKorp, '-')  + ' ' + isnull(ap.AdrOmsKv, '-') addr
FROM sql_cod.DocExchange.dbo.[DISP_Lists] dl
JOIN sql_cod.DocExchange.dbo.ATTP_People AS ap ON ap.ID = dl.PID
LEFT JOIN [test].[dbo].[prikrep_29102021] on fam=[�������] and im=[���] and ot=[��������] and dr=[���� ��������]
LEFT JOIN [test].[dbo].[Tel] t ON fam=f and im=i and ot=o and dr=d
WHERE dl.PrMo = 460026 
AND dl.DispType IN('��4', '���', '��1')
--AND dl.RejectTFReasonId IS null
AND dl.TargetYear = 2023
AND dl.TargetQuarter IN (1,2,3,4)
AND dl.Reserve = 0 
ORDER BY [���������������]