DECLARE @ReestrMedOrgID INT = 5121
----SELECT q, pv.TFR_Q, pv.TFR_COMENT2, SUBSTRING(pv.TFR_COMENT2, 16, 5) FROM PacientVisit AS pv
--UPDATE PacientVisit SET Q = SUBSTRING(TFR_COMENT2, 16, 5)
--WHERE ReestrMedOrgID = @ReestrMedOrgID
--AND TFR_COMENT1 = '������������ ��� ���'


SELECT 
CASE WHEN tfr_coment2 LIKE '%����� ������ �������%' THEN 1 ELSE 0 END,
q, pv.TFR_Q, pv.TFR_COMENT2, SUBSTRING(pv.TFR_COMENT2, 16, 5) FROM PacientVisit AS pv
--UPDATE PacientVisit SET Q = SUBSTRING(TFR_COMENT2, 16, 5)
WHERE ReestrMedOrgID = @ReestrMedOrgID
AND (TFR_COMENT2 LIKE '�� ��� �� ������� ���������� ���������(�) ���� � ���:%' OR TFR_COMENT2 LIKE '�� ��� �� ������� ���������� ���������(�) ���� � ��%')

--�� ��� �� ������� ���������� ���������(�) ���� � ���: ����� ������ ������� 4693289721000068 ���: ��� "�����������-�" �����: 12.07.2017; 
