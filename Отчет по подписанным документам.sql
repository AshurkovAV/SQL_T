SELECT t.���������,[���������], dbo.GROUP_CONCAT_DS(DISTINCT ������������, N' , ', 1)������������, sum(kol)kol
FROM(
		SELECT  ���������, [���������], ������������, sum(����������)kol, SUBSTRING(���������, 0, CHARINDEX(' (', ���������))doc
		FROM docsing0625$
		WHERE ������������ NOT LIKE '%����%' 
		AND ��������� NOT LIKE '%������� ���%'
		AND ������ NOT LIKE '%CT%'
		AND ������ NOT LIKE '%A11%'
		AND ������ NOT LIKE '%088-y06_FED%'
		AND ������ NOT LIKE '%A16.07.002.009%'
		AND ������ NOT LIKE '%A16.07.010%'
		AND ������ NOT LIKE '%A16.07.009%'
		AND ������ NOT LIKE '%A16.07.030.001%'

		AND ������ NOT LIKE '%A16.07.030.003%'
		AND ������ NOT LIKE '%B01.003.004.004%'
		AND ������ NOT LIKE '%A02.07.004%'
		AND ������ NOT LIKE '%A16.01.004%'
		AND ������ NOT LIKE '%A16.07.014%'

		AND ������ NOT LIKE '%A16.07.058%'
		AND ������ NOT LIKE '%A16.07.082.001%'
		AND ������ NOT LIKE '%A16.07.091%'
		AND ������ NOT LIKE '%A25.07.001%'
		AND ������ NOT LIKE '%B01.003.004.005%'

		AND ������ NOT LIKE '%A26.06.082.001%'
		AND ������ NOT LIKE '%A26.19.010%'
		AND ������ NOT LIKE '%A16.07.030.002%'
		AND ������ NOT LIKE '%B01.003.004.002%'
		AND ������ NOT LIKE '%A12.07.004%'
		AND ������ NOT LIKE '%A16.07.095%'
		AND ������ NOT LIKE '%A13.30.0075%'

		AND ������ NOT LIKE '%A13.30.007%'
		AND ������ NOT LIKE '%A12.07.003%'
		AND ������ NOT LIKE '%A16.07.051%'
		AND ������ NOT LIKE '%A17.07.003%'
		AND ������ NOT LIKE '%A16.07.017.002%'
		AND ������ NOT LIKE '014/�%'
 
		GROUP BY ���������, [���������], ������������) AS t
LEFT JOIN (
			SELECT (ysme.FAM + ' ' + ysme.IM + ' ' + ysme.OT) doc, ysme.LPU_ID
            FROM Yamed_Spr_MedicalEmployee AS ysme
          ) t1 ON t.doc = t1.doc 
GROUP BY ���������,[���������]--,  t1.LPU_ID