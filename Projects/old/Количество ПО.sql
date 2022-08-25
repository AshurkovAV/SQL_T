DECLARE @ReestrMedOrgID INT = 65
--����� ����� ������ ������� �������
SELECT 
--(select  f.mcod FROM f003 f WHERE f.mcod = pv.Q),Q, 
(SELECT db.FioWithId FROM DoctorBd AS db WHERE db.id = pv.Doctor) '������',
dbo.GetDateDiff(dr,pv.HelpEnd) '������� � �������',
--dbo.GetDateDiff(dr,pv.HelpEnd)/12 god,
YEAR(pv.DR) '��� ��������',
COUNT(*) '����������'
--, R_MONTH
--pv.FAM, pv.IM, pv.OT, '46002  ������� ������ ��� "�����-��"', p.CITY, p.UL, p.dom, p.KV
From PacientVisit pv
Join ReestrMedOrgDb r on pv.ReestrMedOrgID = r.ID AND r.ID <> 42
WHERE pv.ConditionHelp = 3
AND pv.ReestrMedOrgID = @ReestrMedOrgID
AND pv.OsobSluch in (11)
--AND   not in (0,1,2,3,4,5,6,7,8,9,10,11,12, )
GROUP BY pv.Doctor, year(pv.DR),dbo.GetDateDiff(dr,pv.HelpEnd)
