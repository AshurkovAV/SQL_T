DROP TABLE zs1
DROP TABLE zsd1
SELECT *
FROM prikrep4065$

SELECT *
INTO zsd1 
	FROM prikrep4065$ AS t
		LEFT JOIN (
				SELECT dpo.FAM, dpo.IM, dpo.OT, dpo.DR, dbo.GROUP_CONCAT_DS(DISTINCT dzo.OS_SLUCH_REGION , N' , ', 1)OS_SLUCH_REGION 
				--dbo.GROUP_CONCAT_DS(DISTINCT dzo.DATE_Z_2 , N' , ', 1)DATE_Z_2
				FROM D3_ZSL_OMS AS dzo
					JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
						JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dzo.D3_SCID
							JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
				WHERE (dso2.[YEAR] IN (2024, 2023) OR (dso2.[YEAR] IN (2022) AND dso2.[MONTH] IN (10,11,12)))
					AND dzo.OS_SLUCH_REGION IN (47,49,50) 
				GROUP BY  dpo.FAM, dpo.IM, dpo.OT, dpo.DR) AS t1 ON t.������� = t1.FAM AND t.��� = t1.IM AND t.�������� = t1.OT AND t.[����_��������] = t1.DR

SELECT *
FROM zsd1
------------//3 ����������� ��������//----------------
DROP TABLE zt1
SELECT *
INTO zt1
FROM(
	SELECT *
	FROM zsd1
	WHERE fam IS null) AS tt
LEFT JOIN [test].[dbo].[Tel] t ON tt.�������=f and tt.���=i and tt.��������=o and tt.[����_��������]=d

SELECT distinct z.*
FROM zt1 z
LEFT JOIN [test].[dbo].[prikrep7KGP] p ON p.������� = z.������� 
									AND p.��� = z.���
									AND p.�������� = z.��������
									AND p.[���� ��������] = z.[����_��������]
WHERE p.������� IS NOT NULL


SELECT distinct z.*
FROM zt1 z
LEFT JOIN [test].[dbo].[prikrep7KGP] p ON p.������� = z.������� 
									AND p.��� = z.���
									AND p.�������� = z.��������
									AND p.[���� ��������] = z.[����_��������]
WHERE p.������� IS NULL