--SELECT s.DNAPR, DATEADD(DAY, -1, s.DATE_1), *
UPDATE s SET s.DNAPR = DATEADD(DAY, -1, s.DATE_1)
FROM SLUCH AS s
WHERE s.SCHET_ID = 2136 AND s.EKMP_COMENT like '%NPR_DATE%'

 --�� ��������� ������������ ���� ��� ��, ����������� �� �������, NPR_MO � ����������� ������;  �� ��������� ���� NPR_DATE ���� ����������� �� ������� ��� ��������� ���������� � �������� ����� ��; 
 
--SELECT s.NPR_MO, *
UPDATE s SET s.NPR_MO = 460026
FROM SLUCH AS s
WHERE s.SCHET_ID = 2136 AND s.EKMP_COMENT like '%NPR_MO%'