--�� ����� ��������� ��� ������ �� ������������ ������ �����������
DECLARE @ReestrMedOrgID INT = 5126
SELECT *
FROM(
SELECT  pv.id, pv.FAM, pv.IM, pv.OT, pv.DR, pv.MKB, cast(pv.HelpStart AS DATE)HelpStart, (SELECT db.FioWithId
																	FROM DoctorBd AS db WHERE db.id = pv.Doctor) doc,
pv.TypeSluch, '�� ����� ��������� ��� ������ �� ������������ ������ �����������' com, pv.OsobSluch                                                     
FROM PacientVisit AS pv
WHERE pv.OsobSluch IN (1,2,7,8,9,11,12,15,16,17,18) 
AND pv.ReestrMedOrgID = @ReestrMedOrgID
) AS tab
WHERE tab.TypeSluch <> 2