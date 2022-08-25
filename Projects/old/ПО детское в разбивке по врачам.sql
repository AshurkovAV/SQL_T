SELECT 
YEAR(pv.DR) ���, 
(SELECT db.FioWithId FROM DoctorBd AS db WHERE db.id = pv.Doctor) AS '������', 
rmod.R_MONTH '�����',
COUNT(*) '����������',
CASE WHEN pv.HelpResult in (317,321,327,332,337,343,347) THEN '1. ������ ������'
     WHEN pv.HelpResult in (318,322,328,333,338,344,348) THEN '2. ������ ������'
     WHEN pv.HelpResult in (319,323,329,334,339,345,349) THEN '3. ������ ������'
	 WHEN pv.HelpResult in (324,330,335,340,350) THEN '4. ��������� ������'
     WHEN pv.HelpResult in (325,331,336,341,351) THEN '5. ����� ������'
END '������ ��������'

FROM PacientVisit AS pv
JOIN ReestrMedOrgDb AS rmod ON rmod.ID = pv.ReestrMedOrgID
WHERE pv.ReestrMedOrgID = 92
AND pv.OsobSluch = 11
GROUP BY YEAR(pv.DR), pv.Doctor, rmod.R_MONTH, HelpResult