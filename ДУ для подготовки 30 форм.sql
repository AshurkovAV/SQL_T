SELECT ais.*,  ais.fam, ais.im, ais.ot, ais.dr, bars.�������, bars.fam, ais.��_���10 mkb_ais, bars.ds1 mkb_bars
FROM ( SELECT  *
	   FROM [elmed].[dbo].du
       WHERE fam IS NOT NULL ) AS ais
LEFT JOIN (
		SELECT *
		FROM barsdu0602$
		WHERE fam IS NOT NULL) AS bars ON bars.fam = ais.fam 
												AND bars.im = ais.im 
												AND bars.ot = ais.ot
												AND bars.[���� ��������] = ais.dr
												AND bars.ds1 = ais.��_���10_���
ORDER BY ais.fam





--�������� �������

DROP TABLE zt

SELECT ais.fam, ais.im, ais.ot, ais.dr, ais.��_���10 mkb_ais, ais.��_����_�����, ais.��_����, bars.�������, bars.ds1 mkb_bars
INTO zt
FROM ( SELECT *
			FROM du
			WHERE ��_���10  BETWEEN 'K25.0' AND 'K26.9'
			 or ��_���10_���  = 'K25'
			or ��_���10_���  = 'K26'   ) AS ais
LEFT JOIN (
		SELECT *
		FROM DU_BARS2$ AS db
		WHERE db.ds1 BETWEEN 'K25.0' AND 'K26.9'
		or ds1  = 'K25'
		or ds1  = 'K26'
		) AS bars ON ais.fam = bars.fam 
						AND ais.im = bars.im 
						AND ais.ot = bars.ot
						AND ais.dr = bars.[���� ��������] 
						AND ais.��_���10_��� = bars.ds1
ORDER BY ais.fam



--��� �������

DROP TABLE zt

SELECT ais.fam, ais.im, ais.ot, ais.dr, ais.��_���10 mkb_ais, ais.��_����_�����, ais.��_����, bars.�������, bars.ds1 mkb_bars
INTO zt
FROM ( SELECT *
			FROM du
			WHERE 
			    ��_���10  BETWEEN 'H66.1' AND 'H66.3'
			 OR ��_���10  BETWEEN 'H90.3' AND 'H93.3'
			 or ��_���10_���  = 'J35.0'
			 or ��_���10_���  = 'H80.0'
			 or ��_���10_���  = 'J37.0'
			 or ��_���10_���  = 'J31.2'
			 or ��_���10_���  = 'J31.2'
			 or ��_���10_���  = 'J30.1'
			 or ��_���10_���  = 'J30.3'
			 or ��_���10_���  = 'J33.8'
			 or ��_���10_���  = 'J32.0'
			 or ��_���10_���  = 'J32.2'   ) AS ais
LEFT JOIN (
		SELECT *
		FROM DU_BARS2$ AS db
		WHERE  ds1  BETWEEN 'H66.1' AND 'H66.3'
			 OR ds1  BETWEEN 'H90.3' AND 'H93.3'
			 or ds1  = 'J35.0'
			 or ds1  = 'H80.0'
			 or ds1  = 'J37.0'
			 or ds1  = 'J31.2'
			 or ds1  = 'J31.2'
			 or ds1  = 'J30.1'
			 or ds1  = 'J30.3'
			 or ds1  = 'J33.8'
			 or ds1  = 'J32.0'
			 or ds1  = 'J32.2'
		) AS bars ON ais.fam = bars.fam 
						AND ais.im = bars.im 
						AND ais.ot = bars.ot
						AND ais.dr = bars.[���� ��������] 
						AND ais.��_���10_��� = bars.ds1
ORDER BY ais.fam





--SELECT distinct z.*, ysme.FAM + ' ' + ysme.im +' ' +  ysme.ot 
UPDATE z SET ��_���� = ysme.FAM + ' ' + isnull(ysme.im, '') +' ' +  isnull(ysme.ot , '')
FROM zt z
	JOIN Yamed_Spr_MedicalEmployee AS ysme ON  replace(replace(��_����_�����,'-', ''), ' ', '') = replace(replace(ysme.SNILS,'-', ''), ' ', '')
WHERE ��_���� = ''


SELECT distinct z.*,
CASE WHEN p.������� IS NULL THEN '�������' ELSE '���������' END podr
FROM zt z
LEFT JOIN [test].[dbo].[prikrep7KGP] p ON p.������� = fam 
									AND p.��� = im
									AND p.�������� = ot
									AND p.[���� ��������] = z.dr







--������������� 

DROP TABLE zt

SELECT ais.fam, ais.im, ais.ot, ais.dr, ais.��_���10 mkb_ais, ais.��_����_�����, ais.��_����, bars.�������, bars.ds1 mkb_bars
INTO zt
FROM ( SELECT *
			FROM du
			WHERE 
			   ��_���10  like 'I70%'
			OR ��_���10  like  'I83%'
			OR ��_���10  like  'I80%'
			OR ��_���10  like  'I81%'
			OR ��_���10  like  'K64%'
			OR ��_���10  like  'K43%'
			OR ��_���10  like  'K40%'
			OR ��_���10  like  'K42%'
			OR ��_���10  like  'K73%'
			OR ��_���10  like  'N60%'
			OR ��_���10  like  'K80%'
			OR ��_���10  like  'M86%'
			OR ��_���10  like  'K52%'
			
			 ) AS ais
LEFT JOIN (
		SELECT *
		FROM DU_BARS2$ AS db
		WHERE  
			 ds1  = 'I70.2'
			OR ds1  = 'I83.9'
			OR ds1  = 'I80.0'
			OR ds1  = 'I81.0'
			OR ds1  = 'K64.1'
			OR ds1  = 'K43.9'
			OR ds1  = 'K40.9'
			OR ds1  = 'K42.9'
			OR ds1  = 'K73.0'
			OR ds1  = 'N60.0'
			OR ds1  = 'K80.1'
			OR ds1  = 'M86.6'
			OR ds1  = 'K52.1'
		) AS bars ON ais.fam = bars.fam 
						AND ais.im = bars.im 
						AND ais.ot = bars.ot
						AND ais.dr = bars.[���� ��������] 
						AND ais.��_���10_��� = bars.ds1
ORDER BY ais.fam


--SELECT distinct z.*, ysme.FAM + ' ' + ysme.im +' ' +  ysme.ot 
UPDATE z SET ��_���� = ysme.FAM + ' ' + isnull(ysme.im, '') +' ' +  isnull(ysme.ot , '')
FROM zt z
	JOIN Yamed_Spr_MedicalEmployee AS ysme ON  replace(replace(��_����_�����,'-', ''), ' ', '') = replace(replace(ysme.SNILS,'-', ''), ' ', '')
WHERE ��_���� = ''


SELECT distinct z.*,
CASE WHEN p.������� IS NULL THEN '�������' ELSE '���������' END podr
FROM zt z
LEFT JOIN [test].[dbo].[prikrep7KGP] p ON p.������� = fam 
									AND p.��� = im
									AND p.�������� = ot
									AND p.[���� ��������] = z.dr



--���� �������

DROP TABLE zt

SELECT ais.fam, ais.im, ais.ot, ais.dr, ais.��_������, ais.��_���10 mkb_ais, ais.��_����_�����, ais.��_����, bars.�������, bars.ds1 mkb_bars
INTO zt
FROM ( SELECT *
			FROM du
       WHERE ��_���10_��� 	like 'C%'
			
			   ) AS ais
LEFT JOIN (
		SELECT *
		FROM DU_BARS2$ AS db
		WHERE 			 
			ds1 like 'C%'

		) AS bars ON ais.fam = bars.fam 
						AND ais.im = bars.im 
						AND ais.ot = bars.ot
						AND ais.dr = bars.[���� ��������] 
						AND ais.��_���10_��� = bars.ds1
ORDER BY ais.fam


--SELECT distinct z.*, ysme.FAM + ' ' + ysme.im +' ' +  ysme.ot 
UPDATE z SET ��_���� = ysme.FAM + ' ' + isnull(ysme.im, '') +' ' +  isnull(ysme.ot , '')
FROM zt z
	JOIN Yamed_Spr_MedicalEmployee AS ysme ON  replace(replace(��_����_�����,'-', ''), ' ', '') = replace(replace(ysme.SNILS,'-', ''), ' ', '')
WHERE ��_���� = ''


SELECT distinct z.*, pr.�����_������, pr.�����_�����, pr.�����_���������_�����, pr.�����_�����, pr.�����_���, pr.�����_��������,
CASE WHEN p.������� IS NULL THEN '�������' ELSE '���������' END podr
FROM zt z
	LEFT JOIN Prikrep pr ON pr.������� = fam AND pr.��� = im AND pr.�������� = ot AND pr.����_�������� = z.dr
		LEFT JOIN [test].[dbo].[prikrep7KGP] p ON p.������� = fam 
									AND p.��� = im
									AND p.�������� = ot
									AND p.[���� ��������] = z.dr
									
									
									



DROP TABLE zt

SELECT ais.fam, ais.im, ais.ot, ais.dr, ais.��_���10 mkb_ais, ais.��_����_�����, ais.��_����, bars.�������, bars.ds1 mkb_bars
INTO zt
FROM ( SELECT *
			FROM du
			WHERE 
			   ��_���10  like 'I70%'
			OR ��_���10  like  'I83%'
			OR ��_���10  like  'I80%'
			OR ��_���10  like  'I81%'
			OR ��_���10  like  'K64%'
			OR ��_���10  like  'K43%'
			OR ��_���10  like  'K40%'
			OR ��_���10  like  'K42%'
			OR ��_���10  like  'K73%'
			OR ��_���10  like  'N60%'
			OR ��_���10  like  'K80%'
			OR ��_���10  like  'M86%'
			OR ��_���10  like  'K52%'
			
			 ) AS ais
LEFT JOIN (
		SELECT *
		FROM DU_BARS2$ AS db
		WHERE  
			 ds1  = 'I70.2'
			OR ds1  = 'I83.9'
			OR ds1  = 'I80.0'
			OR ds1  = 'I81.0'
			OR ds1  = 'K64.1'
			OR ds1  = 'K43.9'
			OR ds1  = 'K40.9'
			OR ds1  = 'K42.9'
			OR ds1  = 'K73.0'
			OR ds1  = 'N60.0'
			OR ds1  = 'K80.1'
			OR ds1  = 'M86.6'
			OR ds1  = 'K52.1'
		) AS bars ON ais.fam = bars.fam 
						AND ais.im = bars.im 
						AND ais.ot = bars.ot
						AND ais.dr = bars.[���� ��������] 
						AND ais.��_���10_��� = bars.ds1
ORDER BY ais.fam


--SELECT distinct z.*, ysme.FAM + ' ' + ysme.im +' ' +  ysme.ot 
UPDATE z SET ��_���� = ysme.FAM + ' ' + isnull(ysme.im, '') +' ' +  isnull(ysme.ot , '')
FROM zt z
	JOIN Yamed_Spr_MedicalEmployee AS ysme ON  replace(replace(��_����_�����,'-', ''), ' ', '') = replace(replace(ysme.SNILS,'-', ''), ' ', '')
WHERE ��_���� = ''


SELECT distinct z.*,
CASE WHEN p.������� IS NULL THEN '�������' ELSE '���������' END podr
FROM zt z
LEFT JOIN [test].[dbo].[prikrep7KGP] p ON p.������� = fam 
									AND p.��� = im
									AND p.�������� = ot
									AND p.[���� ��������] = z.dr
									
									
									
-----�������
if OBJECT_ID('zt') is not null DROP TABLE zt

SELECT ais.fam, ais.im, ais.ot, ais.dr, ais.��_������, ais.��_���10 mkb_ais, ais.��_����_�����, ais.��_����, bars.�������, bars.ds1 mkb_bars
INTO zt
FROM ( SELECT *
			FROM du
       WHERE ��_���� LIKE '%�������%' 
			   
			
			 ) AS ais
LEFT JOIN (
		SELECT *
		FROM BARS0319$ AS db		
		) AS bars ON ais.fam = bars.fam 
						AND ais.im = bars.im 
						AND ais.ot = bars.ot
						AND ais.dr = bars.[���� ��������] 
						AND ais.��_���10_��� = bars.ds1
ORDER BY ais.fam


--SELECT distinct z.*, ysme.FAM + ' ' + ysme.im +' ' +  ysme.ot 
UPDATE z SET ��_���� = ysme.FAM + ' ' + isnull(ysme.im, '') +' ' +  isnull(ysme.ot , '')
FROM zt z
	JOIN Yamed_Spr_MedicalEmployee AS ysme ON  replace(replace(��_����_�����,'-', ''), ' ', '') = replace(replace(ysme.SNILS,'-', ''), ' ', '')
WHERE ��_���� = ''


SELECT distinct z.*,
CASE WHEN p.������� IS NULL THEN '�������' ELSE '���������' END podr
FROM zt z
LEFT JOIN [test].[dbo].[prikrep7KGP] p ON p.������� = fam 
									AND p.��� = im
									AND p.�������� = ot
									AND p.[���� ��������] = z.dr
									
									
									
									
if OBJECT_ID('zt') is not null DROP TABLE zt

SELECT ais.fam, ais.im, ais.ot, ais.dr, ais.��_������, ais.��_���10 mkb_ais, ais.��_����_�����, ais.��_����, bars.�������, bars.ds1 mkb_bars
INTO zt
FROM ( SELECT *
			FROM du
       WHERE ��_���10_��� LIKE 'J%' OR 
       ��_���10_��� LIKE 'M%'
			   
			
			 ) AS ais
LEFT JOIN (
		SELECT *
		FROM BARS0319$ AS db		
		) AS bars ON ais.fam = bars.fam 
						AND ais.im = bars.im 
						AND ais.ot = bars.ot
						AND ais.dr = bars.[���� ��������] 
						AND ais.��_���10_��� = bars.ds1
ORDER BY ais.fam


--SELECT distinct z.*, ysme.FAM + ' ' + ysme.im +' ' +  ysme.ot 
UPDATE z SET ��_���� = ysme.FAM + ' ' + isnull(ysme.im, '') +' ' +  isnull(ysme.ot , '')
FROM zt z
	JOIN Yamed_Spr_MedicalEmployee AS ysme ON  replace(replace(��_����_�����,'-', ''), ' ', '') = replace(replace(ysme.SNILS,'-', ''), ' ', '')
WHERE ��_���� = ''


SELECT distinct z.*,
CASE WHEN p.������� IS NULL THEN '�������' ELSE '���������' END podr
FROM zt z
LEFT JOIN [test].[dbo].[prikrep7KGP] p ON p.������� = fam 
									AND p.��� = im
									AND p.�������� = ot
									AND p.[���� ��������] = z.dr