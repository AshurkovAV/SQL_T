SELECT  
(CASE WHEN month(z.DEATHDATE) = 1 THEN  '������'
						WHEN month(z.DEATHDATE) = 2 THEN  '�������'
						WHEN month(z.DEATHDATE) = 3 THEN  '����'
						WHEN month(z.DEATHDATE) = 4 THEN  '������'
						WHEN month(z.DEATHDATE) = 5 THEN  '���'
						WHEN month(z.DEATHDATE) = 6 THEN  '����'
						WHEN month(z.DEATHDATE) = 7 THEN  '����'
						WHEN month(z.DEATHDATE) = 8 THEN  '������'
						WHEN month(z.DEATHDATE) = 9 THEN  '��������'
						WHEN month(z.DEATHDATE) = 10 THEN '�������'
						WHEN month(z.DEATHDATE) = 11 THEN '������'
						WHEN month(z.DEATHDATE) = 12 THEN '�������' 
						ELSE '���-�� ����� �� ���' END) [����� ������], 
z.FAM, z.IM, z.OT, z.BIRTHDATE, d2.�������#��#��������

FROM dubsk AS d2
	JOIN  [covid19].[dbo].[mtr_ZAGSARHIV] z ON ltrim(d2.�������) = ltrim(z.FAM) AND ltrim( d2.���) = ltrim(z.IM) AND ltrim(d2.��������) = ltrim(z.OT) AND d2.�� = z.BIRTHDATE
WHERE z.DEATHDATE BETWEEN '20250101' AND '20250831'
GROUP BY month(z.DEATHDATE), z.FAM, z.IM, z.OT, z.BIRTHDATE, d2.�������#��#��������


SELECT *
FROM [covid19].[dbo].[mtr_ZAGSARHIV]