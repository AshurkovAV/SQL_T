--(20.11.2015 ������ ���� ����� ��� ������� ��������� ������ �� ������ � ����������, ������� ����� ��������� �� ������ � ������, � ��������� �������)
select SUM(sumv)
FROM PacientVisit AS pv
INNER JOIN ReestrMedOrgDb AS rmod ON rmod.ID = pv.ReestrMedOrgID
WHERE pv.ConditionHelp = 1
and pv.mspid = 27 --�������
AND rmod.R_MONTH IN (1,2,3,4,5,6,7,8,9) AND rmod.R_YEAR = 2015 

select SUM(sumv)
FROM PacientVisit AS pv
INNER JOIN ReestrMedOrgDb AS rmod ON rmod.ID = pv.ReestrMedOrgID
WHERE pv.ConditionHelp = 1
and pv.mspid = 90 --�������������
AND rmod.R_MONTH IN (1,2,3,4,5,6,7,8,9) AND rmod.R_YEAR = 2015

select SUM(sumv)
FROM PacientVisit AS pv
INNER JOIN ReestrMedOrgDb AS rmod ON rmod.ID = pv.ReestrMedOrgID
WHERE pv.ConditionHelp = 2 AND pv.lpu_1 = 201
--and pv.Speciality = 27 --������� ��� ��������������
AND rmod.R_MONTH IN (1,2,3,4,5,6,7,8,9) AND rmod.R_YEAR = 2015  

--2014
SELECT sum(sumv)--MSPID, pv.Profil, *
  FROM [Elmed].[dbo].[PacientVisit] pv
  INNER JOIN ReestrMedOrgDb AS rmod ON rmod.ID = pv.ReestrMedOrgID
WHERE rmod.id IN (43,40,38,37,34,32,30,27,26,24,21,20,18)
AND pv.ConditionHelp = 1
AND pv.PROFIL IN (2,136) --���������� � �����������

SELECT SUM(sumv)
FROM PacientVisit AS pv
INNER JOIN ReestrMedOrgDb AS rmod ON rmod.ID = pv.ReestrMedOrgID
WHERE pv.ConditionHelp = 1
AND pv.profil = 97 --�������
AND rmod.id IN (43,40,38,37,34,32,30,27,26,24,21,20,18)

SELECT SUM(sumv)
FROM PacientVisit AS pv
INNER JOIN ReestrMedOrgDb AS rmod ON rmod.ID = pv.ReestrMedOrgID
WHERE pv.ConditionHelp = 1
AND pv.profil = 75 --�������������
AND rmod.id IN (43,40,38,37,34,32,30,27,26,24,21,20,18)