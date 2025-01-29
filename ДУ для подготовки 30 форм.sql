SELECT ais.*,  ais.fam, ais.im, ais.ot, ais.dr, bars.�������, bars.fam, ais.��_���10 mkb_ais, bars.ds1 mkb_bars
FROM ( SELECT  *
	   FROM [elmed].[dbo].du
       WHERE fam IS NOT NULL ) AS ais
LEFT JOIN (
		SELECT *
		FROM DU_BARS2$
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


--SELECT distinct z.*, ysme.FAM + ' ' + ysme.im +' ' +  ysme.ot 
UPDATE z SET ��_���� = ysme.FAM + ' ' + ysme.im +' ' +  ysme.ot 
FROM zt z
	JOIN Yamed_Spr_MedicalEmployee AS ysme ON  ��_����_����� = ysme.SNILS
WHERE ��_���� = ''


SELECT distinct z.*,
CASE WHEN p.������� IS NULL THEN '�������' ELSE '���������' END podr
FROM zt z
LEFT JOIN [test].[dbo].[prikrep7KGP] p ON p.������� = fam 
									AND p.��� = im
									AND p.�������� = ot
									AND p.[���� ��������] = z.dr
