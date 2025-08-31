SELECT (CASE WHEN dso.[MONTH] = 1 THEN  '������'
					  WHEN dso.[MONTH] = 2 THEN  '�������'
					  WHEN dso.[MONTH] = 3 THEN  '����'
					  WHEN dso.[MONTH] = 4 THEN  '������'
					  WHEN dso.[MONTH] = 5 THEN  '���'
					  WHEN dso.[MONTH] = 6 THEN  '����'
					  WHEN dso.[MONTH] = 7 THEN  '����'
					  WHEN dso.[MONTH] = 8 THEN  '������'
					  WHEN dso.[MONTH] = 9 THEN  '��������'
					  WHEN dso.[MONTH] = 10 THEN '�������'
					  WHEN dso.[MONTH] = 11 THEN '������'
					  WHEN dso.[MONTH] = 12 THEN '�������' ELSE '���-�� ����� �� ���' END) [����� ������], 
ISNULL((SELECT ysme.NameWithID
   FROM Yamed_Spr_MedicalEmployee AS ysme WHERE ysme.SNILS = dso2.IDDOKT), dso2.IDDOKT)doc,
   duo.CODE_USL,  
  (SELECT TOP 1 name FROM Yamed_Spr_UslCode WHERE id = duo.VID_VME),  VID_VME,
    sum(sumv)sumv, COUNT(*)kol
FROM D3_SCHET_OMS AS dso
	JOIN D3_ZSL_OMS AS dzo ON dzo.D3_SCID = dso.ID	
		JOIN D3_SL_OMS AS dso2 ON dso2.D3_ZSLID = dzo.ID
			JOIN D3_USL_OMS AS duo ON duo.D3_SLID = dso2.ID
WHERE dso.[YEAR] = 2025 AND dso2.PROFIL = 78
AND (dzo.PR_NOV = 0 OR dzo.PR_NOV IS NULL)
AND duo.VID_VME IN ('A06.09.006', 'A06.09.007','A06.09.007.002') 
GROUP BY dso.[MONTH], duo.CODE_USL, duo.VID_VME, dso2.IDDOKT