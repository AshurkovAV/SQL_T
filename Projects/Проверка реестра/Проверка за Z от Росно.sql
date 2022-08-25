DECLARE @p1 INT = 5126
SELECT pv.ID, pv.SUMV, 'Z00.0 � ������' 
FROM PacientVisit AS pv 
WHERE pv.ReestrMedOrgID = @p1 AND pv.ConditionHelp = 3 
   AND DATEDIFF(YEAR,dr,pv.HelpEnd) + (SIGN(DATEDIFF(DAY,dr,DATEADD(YEAR,YEAR(dr)-YEAR(HelpEnd),HelpEnd)))-1)/2<18 
   AND pv.MKB = 'Z00.0'
UNION
SELECT pv.ID, pv.SUMV, 'Z00.1 �� ������������ � ����� ����� 3 ���' 
FROM PacientVisit AS pv
WHERE pv.ReestrMedOrgID = @p1 and pv.ConditionHelp = 3 
   AND DATEDIFF(YEAR,dr,HelpEnd) +(SIGN(DATEDIFF(DAY,dr,DATEADD(YEAR,YEAR(dr)-YEAR(HelpEnd),HelpEnd)))-1)/2>3 
   AND pv.MKB = 'Z00.1'
UNION
SELECT pv.ID, pv.SUMV, 'Z00.2 ������������ � ����� �� 3 �� 12 ���' 
FROM PacientVisit AS pv
WHERE pv.ReestrMedOrgID = @p1 and pv.ConditionHelp = 3 
   AND DATEDIFF(YEAR,dr,HelpEnd) +(SIGN(DATEDIFF(DAY,dr,DATEADD(YEAR,YEAR(dr)-YEAR(HelpEnd),HelpEnd)))-1)/2 < 3
   AND DATEDIFF(YEAR,dr,HelpEnd) +(SIGN(DATEDIFF(DAY,dr,DATEADD(YEAR,YEAR(dr)-YEAR(HelpEnd),HelpEnd)))-1)/2>12   
   AND pv.MKB = 'Z00.2'
UNION
SELECT pv.ID, pv.SUMV, 'Z00.3 ������������ � ����� �� 12 �� 17 ���' 
FROM PacientVisit AS pv
WHERE pv.ReestrMedOrgID = @p1 AND pv.ConditionHelp = 3 
   AND DATEDIFF(YEAR,dr,HelpEnd) +(SIGN(DATEDIFF(DAY,dr,DATEADD(YEAR,YEAR(dr)-YEAR(HelpEnd),HelpEnd)))-1)/2<12
   AND DATEDIFF(YEAR,dr,HelpEnd) +(SIGN(DATEDIFF(DAY,dr,DATEADD(YEAR,YEAR(dr)-YEAR(HelpEnd),HelpEnd)))-1)/2>17   
   AND pv.MKB = 'Z00.3'
UNION
SELECT pv.ID, pv.SUMV, 'Z00 � �������� �� 1 ������ ��������' 
FROM PacientVisit AS pv
WHERE (pv.ReestrMedOrgID = @p1 AND pv.OsobSluch in (1,7,9,11,17,22) AND pv.RSLT not in (317,321,327,332,337,343,347) 
AND pv.MKB in ('Z00.0','Z00.1','Z00.2','Z00.3'))