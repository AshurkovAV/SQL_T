SELECT YEAR(pv.HelpEnd) - YEAR(dr) '�������', pv.W '���', pv.GrZdorov '������ ��������', COUNT(*) '����������'
FROM PacientVisit pv 
JOIN ReestrMedOrgDb AS rmod ON rmod.ID = pv.ReestrMedOrgID
where pv.ReestrMedOrgID = 54 and pv.OsobSluch = 22
GROUP BY YEAR(pv.HelpEnd) - YEAR(dr), pv.W, pv.GrZdorov 