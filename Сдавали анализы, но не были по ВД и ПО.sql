DROP TABLE zs1
DROP TABLE zsd1

SELECT *
INTO zsd1
FROM(
SELECT  [�������], [���], [��������], [���� ��������], dbo.GROUP_CONCAT_DS(DISTINCT [���� ���������], N' , ', 1)[���� ���������], dbo.GROUP_CONCAT_DS(DISTINCT t, N' , ', 1)t
				FROM(
				--	SELECT fam [�������], im [���], ot [��������], dr [���� ��������], rez [���� ���������], 'OAK0112't
				--	FROM [oak1223$]
				--	UNION ALL
				--	SELECT fam [�������], im [���], ot [��������], dr [���� ��������], rez [���� ���������], 'hol0112't
				--	FROM [hol1223$]
				--	UNION ALL
				--	SELECT fam [�������], im [���], ot [��������], dr [���� ��������], rez [���� ���������], 'GLUK0112't
				--	FROM [GLUK1223$]
				--	UNION ALL
				--SELECT [�������], [���], [��������], [���� ��������], [���� ���������], 'OAK't
				--FROM oak$
				--UNION ALL
				--SELECT [�������], [���], [��������], [���� ��������], [���� ���������], 'HOL't
				--FROM hol$
				--UNION ALL
				--SELECT [�������], [���], [��������], [���� ��������], [���� ���������], 'GLUK't
				--FROM GLUK$
				--UNION ALL
				--SELECT fam [�������], im [���], ot [��������], dr [���� ��������], dp [���� ���������], 'GLUK't				
				--FROM gluk0607$
				--UNION ALL
				--SELECT fam [�������], im [���], ot [��������], dr [���� ��������], dp [���� ���������], 'HOL't
				--FROM hol0607$
				--UNION ALL
				SELECT fam [�������], im [���], ot [��������], dr [���� ��������], dp [���� ���������], 'GLUK't				
				FROM gluk101124$
				UNION ALL
				SELECT fam [�������], im [���], ot [��������], dr [���� ��������], dp [���� ���������], 'HOL't
				FROM hol101124$
				) AS d
				GROUP BY  [�������], [���], [��������], [���� ��������]) AS t

------------//2 ������� ��� �� ��� ��� ������ �� � ��//----------------
SELECT *
INTO zs1 
	FROM zsd1 AS t
		LEFT JOIN (
				SELECT dpo.FAM, dpo.IM, dpo.OT, dpo.DR, dbo.GROUP_CONCAT_DS(DISTINCT dzo.OS_SLUCH_REGION , N' , ', 1)OS_SLUCH_REGION
				FROM D3_ZSL_OMS AS dzo
					JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
						JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dzo.D3_SCID
							JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
				WHERE dso2.[YEAR] IN (2024)
					AND dzo.OS_SLUCH_REGION IN (47,49,50) 
				GROUP BY  dpo.FAM, dpo.IM, dpo.OT, dpo.DR) AS t1 ON t.������� = t1.FAM AND t.��� = t1.IM AND t.�������� = t1.OT AND t.[���� ��������] = t1.DR


------------//3 ����������� ��������//----------------
DROP TABLE zt1
SELECT *
INTO zt1
FROM(
	SELECT *
	FROM zs1
	WHERE fam IS null) AS tt
LEFT JOIN [test].[dbo].[Tel] t ON tt.�������=f and tt.���=i and tt.��������=o and tt.[���� ��������]=d



--SELECT distinct z.*
--FROM zt z
--LEFT JOIN [test].[dbo].[prikrep7KGP] p ON p.������� = z.������� 
--									AND p.��� = z.���
--									AND p.�������� = z.��������
--									AND p.[���� ��������] = z.[���� ��������]
--INNER JOIN (SELECT * FROM [SQL_COD].[DocExchange].[dbo].[ATTP_People] ap WHERE prmo=460026) ap ON  
--												ap.fam= z.������� 
--												AND ap.im=z.��� 
--												AND ap.ot= z.��������
--												AND ap.dr = z.[���� ��������]
--WHERE p.������� IS  NULL


-----------4.
-----------�������---------------------
SELECT distinct z.*
FROM zt1 z
LEFT JOIN [test].[dbo].[prikrep7KGP] p ON p.������� = z.������� 
									AND p.��� = z.���
									AND p.�������� = z.��������
									AND p.[���� ��������] = z.[���� ��������]
WHERE p.������� IS NULL
-----------�������---------------------


-----------���������---------------------
SELECT distinct z.*
FROM zt1 z
LEFT JOIN [test].[dbo].[prikrep7KGP] p ON p.������� = z.������� 
									AND p.��� = z.���
									AND p.�������� = z.��������
									AND p.[���� ��������] = z.[���� ��������]
WHERE p.������� IS not NULL
-----------���������---------------------		

