if OBJECT_ID('zsd1') is not null DROP TABLE zsd1

GO

SELECT *
INTO zsd1234
FROM(
SELECT  [�������], [���], [��������], CAST([���� ��������] AS DATE)[���� ��������], dbo.GROUP_CONCAT_DS(DISTINCT [���� ���������], N' , ', 1)[���� ���������], dbo.GROUP_CONCAT_DS(DISTINCT t, N' , ', 1)t
				FROM(	
				--SELECT  fam [�������], im [���], ot [��������], dr [���� ��������], dp [���� ���������], 'GLUK't				
				--FROM [gluk0607$] AS g
				--UNION ALL
				--SELECT fam [�������], im [���], ot [��������], dr [���� ��������], dp [���� ���������], 'HOL't
				--FROM hol0607$
				--UNION ALL
				--SELECT  fam [�������], im [���], ot [��������], dr1 [���� ��������], dr [���� ���������], 'GLUK't				
				--FROM [gluk08$] AS g
				--UNION ALL
				--SELECT fam [�������], im [���], ot [��������], dr1 [���� ��������], dr [���� ���������], 'HOL't
				--FROM hol08$
				--UNION ALL
				SELECT  fam [�������], im [���], ot [��������], dr [���� ��������], CONVERT(DATE, substring(dp,7, 4)+substring(dp,4, 2)+substring(dp,1,2)	 , 102) [���� ���������], 'GLUK't				
				FROM gluk101124$
				UNION ALL
				SELECT fam [�������], im [���], ot [��������], dr [���� ��������], CONVERT(DATE, substring(dp,7, 4)+substring(dp,4, 2)+substring(dp,1,2)	 , 102) [���� ���������], 'HOL't
				FROM hol101124$
				
				
				
				--UNION ALL
				--SELECT fam [�������], im [���], ot [��������], dr [���� ��������], dp [���� ���������], 'GLUK't				
				--FROM gluk0607$
				--UNION ALL
				--SELECT fam [�������], im [���], ot [��������], dr [���� ��������], dp [���� ���������], 'HOL't
				--FROM hol0607$
				--UNION ALL
				--SELECT fam [�������], im [���], ot [��������], dr [���� ��������], dp [���� ���������], 'GLUK't		
				--FROM gluk101124$
				--WHERE CONVERT(DATE, substring(dp,7, 4)+substring(dp,4, 2)+substring(dp,1,2)	 , 102)	 >='20241101'
				--UNION ALL
				--SELECT fam [�������], im [���], ot [��������], dr [���� ��������], dp [���� ���������], 'HOL't
				--FROM hol101124$
				--WHERE CONVERT(DATE, substring(dp,7, 4)+substring(dp,4, 2)+substring(dp,1,2)	 , 102)	 >='20241101'
				
				UNION ALL
				
				
				
				SELECT fam [�������], im [���], ot [��������], dr [���� ��������], CONVERT(DATE, substring(dp,7, 4)+substring(dp,4, 2)+substring(dp,1,2)	 , 102) [���� ���������], 'GLUK't				
				FROM gluk010225$
				UNION ALL
				SELECT fam [�������], im [���], ot [��������], dr [���� ��������], CONVERT(DATE, substring(dp,7, 4)+substring(dp,4, 2)+substring(dp,1,2)	 , 102) [���� ���������], 'HOL't
				FROM hol010225$
				UNION ALL
				SELECT fam [�������], im [���], ot [��������], dr [���� ��������], CONVERT(DATE, substring(dp,7, 4)+substring(dp,4, 2)+substring(dp,1,2)	 , 102) [���� ���������], 'GLUK't				
				FROM gluk_030425$
				UNION ALL
				SELECT fam [�������], im [���], ot [��������], dr [���� ��������], CONVERT(DATE, substring(dp,7, 4)+substring(dp,4, 2)+substring(dp,1,2)	 , 102) [���� ���������], 'HOL't
				FROM hol_030425$
				UNION ALL
				SELECT fam [�������], im [���], ot [��������], dr [���� ��������], CONVERT(DATE, substring(dp,7, 4)+substring(dp,4, 2)+substring(dp,1,2)	 , 102) [���� ���������], 'GLUK't				
				FROM gluk0525$
				UNION ALL
				SELECT fam [�������], im [���], ot [��������], dr [���� ��������], CONVERT(DATE, substring(dp,7, 4)+substring(dp,4, 2)+substring(dp,1,2)	 , 102) [���� ���������], 'HOL't
				FROM hol0525$
				UNION ALL
				SELECT fam [�������], im [���], ot [��������], dr [���� ��������], CONVERT(DATE, substring(dp,7, 4)+substring(dp,4, 2)+substring(dp,1,2)	 , 102) [���� ���������], 'GLUK't				
				FROM gluk090725$
				UNION ALL
				SELECT fam [�������], im [���], ot [��������], dr [���� ��������], CONVERT(DATE, substring(dp,7, 4)+substring(dp,4, 2)+substring(dp,1,2)	 , 102) [���� ���������], 'HOL't
				FROM hol090725$
				UNION ALL
				SELECT fam [�������], im [���], ot [��������], dr [���� ��������], CONVERT(DATE, substring(dp,7, 4)+substring(dp,4, 2)+substring(dp,1,2)	 , 102) [���� ���������], 'GLUK't				
				FROM gluk110825$
				UNION ALL
				SELECT fam [�������], im [���], ot [��������], dr [���� ��������], CONVERT(DATE, substring(dp,7, 4)+substring(dp,4, 2)+substring(dp,1,2)	 , 102) [���� ���������], 'HOL't
				FROM hol110825$
				) AS d
				GROUP BY  [�������], [���], [��������], [���� ��������]) AS t

if OBJECT_ID('zs1')  is not null DROP TABLE zs1
GO
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
				WHERE dso2.[YEAR] IN (2025)
					AND dzo.OS_SLUCH_REGION IN (47,49,50) 
				GROUP BY  dpo.FAM, dpo.IM, dpo.OT, dpo.DR) AS t1 ON t.������� = t1.FAM AND t.��� = t1.IM AND t.�������� = t1.OT AND t.[���� ��������] = t1.DR
WHERE  t.[���� ��������] IS NOT NULL AND [���� ���������] IS NOT NULL


------------//3 ����������� ��������//----------------
if OBJECT_ID('zt1') is not null DROP TABLE zt1

SELECT *
INTO zt1
FROM(
	SELECT *
	FROM zs1
	WHERE fam IS null) AS tt
LEFT JOIN telefon1 AS t ON tt.�������=t.NOM and tt.���= t.PRENOM and tt.��������=t.PATRONYME and tt.[���� ��������]=t.NE_LE

------------//3 ����������� ������ � ����� ������//----------------
if OBJECT_ID('zt2') is not null DROP TABLE zt2

SELECT enp, t2.*, ISNULL(dl.�����_����� , '-') + ' ' + isnull(dl.�����_���������_����� , '-') + ' ' + isnull(dl.�����_����� , '-') + ' ' + ISNULL(dl.�����_��� , '-') + ' ' + isnull(dl.�����_������ , '-')  + ' ' + isnull(dl.�����_�������� , '-') addr
INTO zt2
	FROM zt1 t2
		LEFT JOIN [elmed].[dbo].Prikrep dl ON dl.������� =t2.������� and dl.��� =t2.��� and dl.�������� =t2.�������� and dl.����_�������� =t2.[���� ��������]

-----------4.

-------------�������---------------------
-----------���������---------------------
SELECT distinct z.*,
CASE WHEN p.fam IS NULL THEN '�������' ELSE '���������' END podr
FROM zt2 z
LEFT JOIN [dbo].[Perepis] p ON p.fam = z.������� 
									AND p.im = z.���
									AND p.ot = z.��������
									AND p.dr = z.[���� ��������]
