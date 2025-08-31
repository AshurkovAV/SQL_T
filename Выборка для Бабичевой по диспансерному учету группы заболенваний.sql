DROP TABLE d_001

SELECT '�������� �������' osl, *
INTO d_001
FROM(

		SELECT '����������� ������� ������' goup, fam, im, ot, dr, 
			dbo.GROUP_CONCAT_DS(DISTINCT ��_���10_��� , N' , ', 1)��_���10_���,	
			dbo.GROUP_CONCAT_DS(DISTINCT ��_���10  , N' , ', 1)��_���10	
		FROM du
		WHERE ��_���10_��� BETWEEN 'I20.0' AND 'I25.9'
		GROUP BY fam, im, ot, dr

		UNION ALL 

		SELECT '�������������� �������' goup, fam, im, ot, dr, 
			dbo.GROUP_CONCAT_DS(DISTINCT ��_���10_��� , N' , ', 1)��_���10_���,	
			dbo.GROUP_CONCAT_DS(DISTINCT ��_���10  , N' , ', 1)��_���10	
		FROM du
		WHERE ��_���10_��� BETWEEN 'I10.0' AND 'I11.9' OR ��_���10_��� BETWEEN 'I12.0' AND 'I11.3'
		GROUP BY fam, im, ot, dr

		UNION ALL 

		SELECT '������������������ �������' goup, fam, im, ot, dr, 
			dbo.GROUP_CONCAT_DS(DISTINCT ��_���10_��� , N' , ', 1)��_���10_���,	
			dbo.GROUP_CONCAT_DS(DISTINCT ��_���10  , N' , ', 1)��_���10	
		FROM du
		WHERE ��_���10_��� BETWEEN 'I60.0' AND 'I69.9'
		GROUP BY fam, im, ot, dr) AS t


DROP TABLE d_002
-----������������� �����������---------
SELECT '������������� �����������' osl, *
INTO d_002
FROM(
		SELECT '�������� ������' goup, fam, im, ot, dr, 
			dbo.GROUP_CONCAT_DS(DISTINCT ��_���10_��� , N' , ', 1)��_���10_���,	
			dbo.GROUP_CONCAT_DS(DISTINCT ��_���10  , N' , ', 1)��_���10	
		FROM du
		WHERE ��_���10_��� BETWEEN 'E10.0' AND 'E11.9'
		GROUP BY fam, im, ot, dr

		UNION ALL 

		SELECT '����������� ������������� ��������' goup, fam, im, ot, dr, 
			dbo.GROUP_CONCAT_DS(DISTINCT ��_���10_��� , N' , ', 1)��_���10_���,	
			dbo.GROUP_CONCAT_DS(DISTINCT ��_���10  , N' , ', 1)��_���10	
		FROM du
		WHERE ��_���10_��� BETWEEN 'J44.0' AND 'J44.9'
		GROUP BY fam, im, ot, dr

		UNION ALL 

		SELECT '����������� ������� �����' goup, fam, im, ot, dr, 
			dbo.GROUP_CONCAT_DS(DISTINCT ��_���10_��� , N' , ', 1)��_���10_���,	
			dbo.GROUP_CONCAT_DS(DISTINCT ��_���10  , N' , ', 1)��_���10	
		FROM du
		WHERE ��_���10_��� BETWEEN 'N18.1' AND 'N18.9'
		GROUP BY fam, im, ot, dr) AS t

-----������������� �����������---------
DROP TABLE d_003
-----���������� �����������---------

SELECT '���������� �����������' osl, *
INTO d_003
FROM(

			SELECT '��������������� ���������' goup, fam, im, ot, dr, 
				dbo.GROUP_CONCAT_DS(DISTINCT ��_���10_��� , N' , ', 1)��_���10_���,	
				dbo.GROUP_CONCAT_DS(DISTINCT ��_���10  , N' , ', 1)��_���10	
			FROM du
			WHERE ��_���10_��� BETWEEN 'I50.0' AND 'I50.9'
			GROUP BY fam, im, ot, dr

			UNION ALL

			SELECT '��������� �����' goup, fam, im, ot, dr, 
				dbo.GROUP_CONCAT_DS(DISTINCT ��_���10_��� , N' , ', 1)��_���10_���,	
				dbo.GROUP_CONCAT_DS(DISTINCT ��_���10  , N' , ', 1)��_���10	
			FROM du
			WHERE ��_���10_��� BETWEEN 'I48.0' AND 'I49.9'
			GROUP BY fam, im, ot, dr

			UNION ALL

			SELECT '��������� ������������' goup, fam, im, ot, dr, 
				dbo.GROUP_CONCAT_DS(DISTINCT ��_���10_��� , N' , ', 1)��_���10_���,	
				dbo.GROUP_CONCAT_DS(DISTINCT ��_���10  , N' , ', 1)��_���10	
			FROM du
			WHERE ��_���10_��� BETWEEN 'I44.0' AND 'I45.9'
			GROUP BY fam, im, ot, dr

			UNION ALL

			SELECT '������ �������� �����������' goup, fam, im, ot, dr, 
				dbo.GROUP_CONCAT_DS(DISTINCT ��_���10_��� , N' , ', 1)��_���10_���,	
				dbo.GROUP_CONCAT_DS(DISTINCT ��_���10  , N' , ', 1)��_���10	
			FROM du
			WHERE ��_���10_��� = 'I27.9'
			GROUP BY fam, im, ot, dr

			UNION ALL

			SELECT '��������������� ���������' goup, fam, im, ot, dr, 
				dbo.GROUP_CONCAT_DS(DISTINCT ��_���10_��� , N' , ', 1)��_���10_���,	
				dbo.GROUP_CONCAT_DS(DISTINCT ��_���10  , N' , ', 1)��_���10	
			FROM du
			WHERE ��_���10_��� = 'J18.9'
			GROUP BY fam, im, ot, dr

			UNION ALL

			SELECT '��������������� ��������' goup, fam, im, ot, dr, 
				dbo.GROUP_CONCAT_DS(DISTINCT ��_���10_��� , N' , ', 1)��_���10_���,	
				dbo.GROUP_CONCAT_DS(DISTINCT ��_���10  , N' , ', 1)��_���10	
			FROM du
			WHERE ��_���10_��� = 'N18.9'
			GROUP BY fam, im, ot, dr

			UNION ALL

			SELECT '��������� ������������' goup, fam, im, ot, dr, 
				dbo.GROUP_CONCAT_DS(DISTINCT ��_���10_��� , N' , ', 1)��_���10_���,	
				dbo.GROUP_CONCAT_DS(DISTINCT ��_���10  , N' , ', 1)��_���10	
			FROM du
			WHERE ��_���10_��� BETWEEN 'N19.0' AND 'N19.9'
			GROUP BY fam, im, ot, dr

			UNION ALL

			SELECT '��������' goup, fam, im, ot, dr, 
				dbo.GROUP_CONCAT_DS(DISTINCT ��_���10_��� , N' , ', 1)��_���10_���,	
				dbo.GROUP_CONCAT_DS(DISTINCT ��_���10  , N' , ', 1)��_���10	
			FROM du
			WHERE ��_���10_��� BETWEEN 'R02.0' AND 'R02.9'
			GROUP BY fam, im, ot, dr

			UNION ALL

			SELECT '��������������� ��������' goup, fam, im, ot, dr, 
				dbo.GROUP_CONCAT_DS(DISTINCT ��_���10_��� , N' , ', 1)��_���10_���,	
				dbo.GROUP_CONCAT_DS(DISTINCT ��_���10  , N' , ', 1)��_���10	
			FROM du
			WHERE ��_���10_��� = 'J98.4'
			GROUP BY fam, im, ot, dr

			UNION ALL

			SELECT '��������' goup, fam, im, ot, dr, 
				dbo.GROUP_CONCAT_DS(DISTINCT ��_���10_��� , N' , ', 1)��_���10_���,	
				dbo.GROUP_CONCAT_DS(DISTINCT ��_���10  , N' , ', 1)��_���10	
			FROM du
			WHERE ��_���10_��� = 'J43.9'
			GROUP BY fam, im, ot, dr
) AS t


DROP TABLE d_0001

--��� � ����� ����������� �� ������ 1  = 3770
SELECT t.fam, t.im, t.ot, t.dr, dbo.GROUP_CONCAT_DS(DISTINCT ��_���10_��� , N' , ', 1)��_���10_���
INTO d_0001
FROM(
		SELECT '����������� ������� ������' goup, fam, im, ot, dr, 
			dbo.GROUP_CONCAT_DS(DISTINCT ��_���10_��� , N' , ', 1)��_���10_���,	
			dbo.GROUP_CONCAT_DS(DISTINCT ��_���10  , N' , ', 1)��_���10	
		FROM du
		WHERE ��_���10_��� BETWEEN 'I20.0' AND 'I25.9'
		GROUP BY fam, im, ot, dr

		UNION ALL 

		SELECT '�������������� �������' goup, fam, im, ot, dr, 
			dbo.GROUP_CONCAT_DS(DISTINCT ��_���10_��� , N' , ', 1)��_���10_���,	
			dbo.GROUP_CONCAT_DS(DISTINCT ��_���10  , N' , ', 1)��_���10	
		FROM du
		WHERE ��_���10_��� BETWEEN 'I10.0' AND 'I11.9' OR ��_���10_��� BETWEEN 'I12.0' AND 'I11.3'
		GROUP BY fam, im, ot, dr

		UNION ALL 

		SELECT '������������������ �������' goup, fam, im, ot, dr, 
			dbo.GROUP_CONCAT_DS(DISTINCT ��_���10_��� , N' , ', 1)��_���10_���,	
			dbo.GROUP_CONCAT_DS(DISTINCT ��_���10  , N' , ', 1)��_���10	
		FROM du
		WHERE ��_���10_��� BETWEEN 'I60.0' AND 'I69.9'
		GROUP BY fam, im, ot, dr ) AS t
GROUP BY t.fam, t.im, t.ot, t.dr
HAVING COUNT(*) > 1

--SELECT * FROM d_0001

DROP TABLE d_0002
--- ������ 1 + ������2 + ������ 3 = 603
SELECT t4.fam, t4.im, t4.ot, t4.dr, dbo.GROUP_CONCAT_DS(DISTINCT ��_���10_���2 , N' , ', 1)��_���10_���
INTO d_0002
FROM (SELECT t1.*, t2.osl osl2, t2.goup goup2, t2.��_���10_��� ��_���10_���2
	FROM d_001 AS t1
		JOIN d_002 AS  t2 ON t1.Fam = t2.Fam AND t1.im = t2.im AND t1.ot = t2.ot AND t1.dr = t2.dr) AS t4
			JOIN d_003 AS t3 ON  t4.Fam = t3.Fam AND t4.im = t3.im AND t4.ot = t3.ot AND t4.dr = t3.dr
GROUP BY t4.fam, t4.im, t4.ot, t4.dr
	
DROP TABLE d_0003	
--	5236
--������ 1 + ������ 2 ��� ������ 3 = 3741	
SELECT t4.fam, t4.im, t4.ot, t4.dr, dbo.GROUP_CONCAT_DS(DISTINCT t4.��_���10_���2 , N' , ', 1)��_���10_���
INTO d_0003
FROM( 
			SELECT t1.*, t2.osl osl2, t2.goup goup2, t2.��_���10_��� ��_���10_���2
				FROM d_001 AS t1
					JOIN d_002 AS  t2 ON t1.Fam = t2.Fam AND t1.im = t2.im AND t1.ot = t2.ot AND t1.dr = t2.dr ) AS t4
		
--	3103	
LEFT JOIN (
			SELECT t1.*, t2.osl osl2, t2.goup goup2, t2.��_���10_��� ��_���10_���2
				FROM d_001 AS t1
					JOIN d_003 AS  t2 ON t1.Fam = t2.Fam AND t1.im = t2.im AND t1.ot = t2.ot AND t1.dr = t2.dr ) AS t5 ON t5.fam = t4.fam AND t5.im = t4.im AND t5.ot = t4.ot AND t5.dr = t4.dr
GROUP BY t4.fam, t4.im, t4.ot, t4.dr

SELECT * FROM d_0003

if OBJECT_ID('zt_duf') is not null DROP TABLE zt_duf
GO
SELECT DISTINCT t.fam, t.im, t.ot, t.dr, dbo.GROUP_CONCAT_DS(DISTINCT ��_���10_��� , N' , ', 1)��_���10_���
INTO zt_duf
FROM (
		SELECT *
		FROM d_0001
		UNION ALL 
		SELECT *
		FROM d_0002
		UNION ALL
		SELECT *
		FROM d_0003) AS t
GROUP BY t.fam, t.im, t.ot, t.dr
		
		
		
if OBJECT_ID('zt_duf1') is not null DROP TABLE zt_duf1
GO
		
SELECT t_du.*,
     CASE WHEN OS_SLUCH_REGION IS NOT NULL THEN (SELECT osd.NameWithID
                                              FROM OsobSluchDb AS osd WHERE osd.Id = OS_SLUCH_REGION) + ' ' + CONVERT(NVARCHAR(10), t_p.DATE_Z_1, 110)
     ELSE '�� �������� � � �' END  [D P] 
INTO zt_duf1
FROM zt_duf AS t_du
LEFT JOIN (	
	SELECT dpo.FAM, dpo.IM, dpo.OT, dpo.DR, dzo.OS_SLUCH_REGION, dzo.DATE_Z_1
		FROM D3_ZSL_OMS AS dzo
		JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
			JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
				JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dzo.D3_SCID
		WHERE dso2.[YEAR] in (2025)
		AND dso2.SchetType IN ('DP','DO')	
	GROUP BY dpo.FAM, dpo.IM, dpo.OT, dpo.DR,dzo.OS_SLUCH_REGION , dzo.DATE_Z_1
) AS t_p ON t_p.FAM = t_du.fam AND t_p.IM = t_du.im AND t_p.OT = t_du.ot AND t_p.DR = t_du.dr





DROP TABLE ztemp_du_pred
--_____________��� ��� ������ �� ��� �� ���� ������ 


SELECT dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
	dbo.GROUP_CONCAT_DS(DISTINCT ysme.NameWithID, N' , ', 1)NameWithID,
	(CASE WHEN dbo.GROUP_CONCAT_DS(DISTINCT ysme.LPU_ID, N' , ', 1) = '460006' THEN '���������'
	      WHEN dbo.GROUP_CONCAT_DS(DISTINCT ysme.LPU_ID, N' , ', 1) = '460026' THEN '�������' ELSE '���-�� ����� �� ���' END) lpu_id
--	dbo.GROUP_CONCAT_DS(DISTINCT ysme.LPU_ID, N' , ', 1)LPU_ID
	--CASE WHEN ysme.LPU_ID = 460006 THEN '���������' ELSE '�������' END gb, ysme.NameWithID
		INTO ztemp_du_pred
		FROM D3_ZSL_OMS AS dzo
			JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
				JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
					JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dzo.D3_SCID --AND dso2.NSCHET LIKE '%+%'
						LEFT JOIN Yamed_Spr_MedicalEmployee AS ysme ON ysme.SNILS = dso.IDDOKT -- AND ysme.LPU_ID = 460026
		WHERE 
			dso.P_CEL25 IN( '1.3', '4.1') 
			---------/////----------------------
			AND( dso.DS1 IN ('I27.0', 'I27.2', 'I27.8', 'I50.0', 'I50.1', 'I50.9', 'I51.4', 'I69.0','I69.1','I69.2','I69.3','I69.4','I67.8', 'I65.2',
			'Z95.0', 'Z95.1', 'Z95.2', 'Z95.3', 'Z95.4','Z95.5', 'Z95.8', 'Z95.9') OR
			dso.DS1 BETWEEN 'I05' AND 'I05.9' OR
			dso.DS1 BETWEEN 'I06' AND 'I06.9' OR
			dso.DS1 BETWEEN 'I07' AND 'I07.9' OR
			dso.DS1 BETWEEN 'I08' AND 'I08.9' OR
			dso.DS1 BETWEEN 'I09' AND 'I09.9' OR
			dso.DS1 BETWEEN 'I10' AND 'I10.9' OR 
			dso.DS1 BETWEEN 'I11' AND 'I11.9' OR 
			dso.DS1 BETWEEN 'I12' AND 'I12.9' OR 
			dso.DS1 BETWEEN 'I13' AND 'I13.9' OR 
			dso.DS1 BETWEEN 'I15' AND 'I15.9' OR
			dso.DS1 BETWEEN 'I20' AND 'I20.9' OR
			dso.DS1 BETWEEN 'I21' AND 'I21.9' OR
			dso.DS1 BETWEEN 'I22' AND 'I22.9' OR
			dso.DS1 BETWEEN 'I23' AND 'I23.9' OR
			dso.DS1 BETWEEN 'I24' AND 'I24.9' OR
			dso.DS1 BETWEEN 'I25' AND 'I25.9' OR
			dso.DS1 BETWEEN 'I26' AND 'I26.9' OR
			dso.DS1 BETWEEN 'I28' AND 'I28.9' OR
			dso.DS1 BETWEEN 'I33' AND 'I33.9' OR
			dso.DS1 BETWEEN 'I34' AND 'I34.9' OR
			dso.DS1 BETWEEN 'I35' AND 'I35.9' OR
			dso.DS1 BETWEEN 'I36' AND 'I36.9' OR
			dso.DS1 BETWEEN 'I37' AND 'I37.9' OR
			dso.DS1 BETWEEN 'I38' AND 'I38.9' OR
			dso.DS1 BETWEEN 'I39' AND 'I39.9' OR
			dso.DS1 BETWEEN 'I40' AND 'I40.9' OR
			dso.DS1 BETWEEN 'I41' AND 'I41.9' OR
			dso.DS1 BETWEEN 'I42' AND 'I42.9' OR
			dso.DS1 BETWEEN 'I44' AND 'I44.9' OR
			dso.DS1 BETWEEN 'I45' AND 'I45.9' OR
			dso.DS1 BETWEEN 'I46' AND 'I46.9' OR
			dso.DS1 BETWEEN 'I47' AND 'I47.9' OR
			dso.DS1 BETWEEN 'I48' AND 'I48.9' OR
			dso.DS1 BETWEEN 'I49' AND 'I49.9' OR
			dso.DS1 BETWEEN 'I51' AND 'I51.2' OR
			dso.DS1 BETWEEN 'I71' AND 'I71.9' OR
			dso.DS1 BETWEEN 'Q20' AND 'Q28.9' OR

			dso.DS1 BETWEEN 'E78' AND 'E78.9' 
			) 
			---------/////----------------------
			AND dso.PROFIL IN (97, 29, 53)
			AND dso.IDDOKT NOT IN ('054-827-304 66')
			AND (dso2.[YEAR] = 2025
			AND dso2.[MONTH] IN (1,2,3,4,5))--#
	GROUP BY  dpo.FAM, dpo.IM, dpo.OT, dpo.DR



if OBJECT_ID('zt_duf2') is not null DROP TABLE zt_duf2

SELECT t_du.*
INTO zt_duf2
FROM zt_duf1 AS t_du
LEFT JOIN ztemp_du_pred t_p ON t_p.FAM = t_du.fam AND t_p.IM = t_du.im AND t_p.OT = t_du.ot AND t_p.DR = t_du.dr
WHERE t_p.FAM IS NULL

if OBJECT_ID('ztemp_ztemp_du_bsk_adr') is not null DROP TABLE ztemp_ztemp_du_bsk_adr

SELECT tt.*, t.tel, ISNULL(p.�����_���������_�����, '-') + ' ' + isnull(p.�����_�����, '-') + ' ' + isnull(p.�����_���, '-') + ' ' + ISNULL(p.�����_������, '-') + ' ' + isnull(p.�����_��������, '-')addr
		INTO ztemp_ztemp_du_bsk_adr
		FROM zt_duf2 tt 
			
				LEFT JOIN [test].[dbo].[Tel] t ON tt.fam=f and tt.im=i and tt.ot=o and tt.dr=d
					LEFT JOIN Prikrep AS p ON p.������� = tt.fam 
												AND p.��� = tt.im 
												AND p.�������� = tt.ot 
												and p.����_�������� = tt.dr




SELECT distinct z.*
FROM ztemp_ztemp_du_bsk_adr z
LEFT JOIN [test].[dbo].[prikrep7KGP] p ON p.������� = fam 
									AND p.��� = im
									AND p.�������� = ot
									AND p.[���� ��������] = z.dr
WHERE p.������� IS NOT NULL


-----------�������---------------------
SELECT distinct z.*
FROM ztemp_ztemp_du_bsk_adr z
LEFT JOIN [test].[dbo].[prikrep7KGP] p ON p.������� = fam 
									AND p.��� = im
									AND p.�������� = ot
									AND p.[���� ��������] = dr
WHERE p.������� IS NULL
-----------�������---------------------












---------------------�� ������� �� ����� �� 


SELECT '�������� �������' osl, *
INTO dgr_001
FROM(

		SELECT '����������� ������� ������' goup, d.SURNAME, d.FIRSTNAME, d.LASTNAME, d.BIRTHDATE ,
			dbo.GROUP_CONCAT_DS(DISTINCT MKB , N' , ', 1)��_���10_���
		FROM [1] d
		WHERE MKB BETWEEN 'I20.0' AND 'I25.9'
		GROUP BY d.SURNAME, d.FIRSTNAME, d.LASTNAME, d.BIRTHDATE

		UNION ALL 

		SELECT '�������������� �������' goup, d.SURNAME, d.FIRSTNAME, d.LASTNAME, d.BIRTHDATE ,
			dbo.GROUP_CONCAT_DS(DISTINCT MKB , N' , ', 1)��_���10_���
		FROM [1] d
		WHERE MKB BETWEEN 'I10.0' AND 'I11.9' OR MKB BETWEEN 'I12.0' AND 'I11.3'
		GROUP BY d.SURNAME, d.FIRSTNAME, d.LASTNAME, d.BIRTHDATE
		
		UNION ALL 

		SELECT '������������������ �������' goup, d.SURNAME, d.FIRSTNAME, d.LASTNAME, d.BIRTHDATE ,
			dbo.GROUP_CONCAT_DS(DISTINCT MKB , N' , ', 1)��_���10_���
		FROM [1] d
		WHERE MKB BETWEEN 'I60.0' AND 'I69.9'
		GROUP BY d.SURNAME, d.FIRSTNAME, d.LASTNAME, d.BIRTHDATE ) AS t


-----������������� �����������---------
SELECT '������������� �����������' osl, *
INTO dgr_002
FROM(
		SELECT '�������� ������' goup, d.SURNAME, d.FIRSTNAME, d.LASTNAME, d.BIRTHDATE, 
			dbo.GROUP_CONCAT_DS(DISTINCT MKB , N' , ', 1)��_���10_���
		FROM [1] d
		WHERE MKB BETWEEN 'E10.0' AND 'E11.9'
		GROUP BY d.SURNAME, d.FIRSTNAME, d.LASTNAME, d.BIRTHDATE

		UNION ALL 

		SELECT '����������� ������������� ��������' goup, d.SURNAME, d.FIRSTNAME, d.LASTNAME, d.BIRTHDATE, 
			dbo.GROUP_CONCAT_DS(DISTINCT MKB , N' , ', 1)��_���10_���
		FROM [1] d
		WHERE MKB BETWEEN 'J44.0' AND 'J44.9'
		GROUP BY d.SURNAME, d.FIRSTNAME, d.LASTNAME, d.BIRTHDATE

		UNION ALL 

		SELECT '����������� ������� �����' goup, d.SURNAME, d.FIRSTNAME, d.LASTNAME, d.BIRTHDATE, 
			dbo.GROUP_CONCAT_DS(DISTINCT MKB , N' , ', 1)��_���10_���
		FROM [1] d
		WHERE MKB BETWEEN 'N18.1' AND 'N18.9'
		GROUP BY d.SURNAME, d.FIRSTNAME, d.LASTNAME, d.BIRTHDATE) AS t

-----������������� �����������---------
DROP TABLE d_003
-----���������� �����������---------

SELECT '���������� �����������' osl, *
INTO dgr_003
FROM(

			SELECT '��������������� ���������' goup, d.SURNAME, d.FIRSTNAME, d.LASTNAME, d.BIRTHDATE, 
				dbo.GROUP_CONCAT_DS(DISTINCT MKB , N' , ', 1)��_���10_���
			FROM [1] d
			WHERE MKB BETWEEN 'I50.0' AND 'I50.9'
			GROUP BY d.SURNAME, d.FIRSTNAME, d.LASTNAME, d.BIRTHDATE

			UNION ALL

			SELECT '��������� �����' goup, d.SURNAME, d.FIRSTNAME, d.LASTNAME, d.BIRTHDATE, 
				dbo.GROUP_CONCAT_DS(DISTINCT MKB , N' , ', 1)��_���10_���
			FROM [1] d
			WHERE MKB BETWEEN 'I48.0' AND 'I49.9'
			GROUP BY d.SURNAME, d.FIRSTNAME, d.LASTNAME, d.BIRTHDATE

			UNION ALL

			SELECT '��������� ������������' goup, d.SURNAME, d.FIRSTNAME, d.LASTNAME, d.BIRTHDATE, 
				dbo.GROUP_CONCAT_DS(DISTINCT MKB , N' , ', 1)��_���10_���
			FROM [1] d
			WHERE MKB BETWEEN 'I44.0' AND 'I45.9'
			GROUP BY d.SURNAME, d.FIRSTNAME, d.LASTNAME, d.BIRTHDATE

			UNION ALL

			SELECT '������ �������� �����������' goup, d.SURNAME, d.FIRSTNAME, d.LASTNAME, d.BIRTHDATE, 
				dbo.GROUP_CONCAT_DS(DISTINCT MKB , N' , ', 1)��_���10_���
			FROM [1] d
			WHERE MKB = 'I27.9'
			GROUP BY d.SURNAME, d.FIRSTNAME, d.LASTNAME, d.BIRTHDATE

			UNION ALL

			SELECT '��������������� ���������' goup, d.SURNAME, d.FIRSTNAME, d.LASTNAME, d.BIRTHDATE, 
				dbo.GROUP_CONCAT_DS(DISTINCT MKB , N' , ', 1)��_���10_���
			FROM [1] d
			WHERE MKB = 'J18.9'
			GROUP BY d.SURNAME, d.FIRSTNAME, d.LASTNAME, d.BIRTHDATE

			UNION ALL

			SELECT '��������������� ��������' goup, d.SURNAME, d.FIRSTNAME, d.LASTNAME, d.BIRTHDATE, 
				dbo.GROUP_CONCAT_DS(DISTINCT MKB , N' , ', 1)��_���10_���
			FROM [1] d
			WHERE MKB = 'N18.9'
			GROUP BY d.SURNAME, d.FIRSTNAME, d.LASTNAME, d.BIRTHDATE

			UNION ALL

			SELECT '��������� ������������' goup, d.SURNAME, d.FIRSTNAME, d.LASTNAME, d.BIRTHDATE, 
				dbo.GROUP_CONCAT_DS(DISTINCT MKB , N' , ', 1)��_���10_���
			FROM [1] d
			WHERE MKB BETWEEN 'N19.0' AND 'N19.9'
			GROUP BY d.SURNAME, d.FIRSTNAME, d.LASTNAME, d.BIRTHDATE

			UNION ALL

			SELECT '��������' goup, d.SURNAME, d.FIRSTNAME, d.LASTNAME, d.BIRTHDATE, 
				dbo.GROUP_CONCAT_DS(DISTINCT MKB , N' , ', 1)��_���10_���
			FROM [1] d
			WHERE MKB BETWEEN 'R02.0' AND 'R02.9'
			GROUP BY d.SURNAME, d.FIRSTNAME, d.LASTNAME, d.BIRTHDATE

			UNION ALL

			SELECT '��������������� ��������' goup, d.SURNAME, d.FIRSTNAME, d.LASTNAME, d.BIRTHDATE, 
				dbo.GROUP_CONCAT_DS(DISTINCT MKB , N' , ', 1)��_���10_���
			FROM [1] d
			WHERE MKB = 'J98.4'
			GROUP BY d.SURNAME, d.FIRSTNAME, d.LASTNAME, d.BIRTHDATE

			UNION ALL

			SELECT '��������' goup, d.SURNAME, d.FIRSTNAME, d.LASTNAME, d.BIRTHDATE, 
				dbo.GROUP_CONCAT_DS(DISTINCT MKB , N' , ', 1)��_���10_���
			FROM [1] d
			WHERE MKB = 'J43.9'
			GROUP BY d.SURNAME, d.FIRSTNAME, d.LASTNAME, d.BIRTHDATE
) AS t



--��� � ����� ����������� �� ������ 1  = 3770
SELECT '1' goup, d.SURNAME, d.FIRSTNAME, d.LASTNAME, d.BIRTHDATE , dbo.GROUP_CONCAT_DS(DISTINCT ��_���10_��� , N' , ', 1)��_���10_���
INTO dd_0001
FROM(
		SELECT '����������� ������� ������' goup, d.SURNAME, d.FIRSTNAME, d.LASTNAME, d.BIRTHDATE ,
			dbo.GROUP_CONCAT_DS(DISTINCT MKB , N' , ', 1)��_���10_���
		FROM [1] d
		WHERE MKB BETWEEN 'I20.0' AND 'I25.9'
		GROUP BY d.SURNAME, d.FIRSTNAME, d.LASTNAME, d.BIRTHDATE

		UNION ALL 

		SELECT '�������������� �������' goup, d.SURNAME, d.FIRSTNAME, d.LASTNAME, d.BIRTHDATE ,
			dbo.GROUP_CONCAT_DS(DISTINCT MKB , N' , ', 1)��_���10_���
		FROM [1] d
		WHERE MKB BETWEEN 'I10.0' AND 'I11.9' OR MKB BETWEEN 'I12.0' AND 'I11.3'
		GROUP BY d.SURNAME, d.FIRSTNAME, d.LASTNAME, d.BIRTHDATE
		
		UNION ALL 

		SELECT '������������������ �������' goup, d.SURNAME, d.FIRSTNAME, d.LASTNAME, d.BIRTHDATE ,
			dbo.GROUP_CONCAT_DS(DISTINCT MKB , N' , ', 1)��_���10_���
		FROM [1] d
		WHERE MKB BETWEEN 'I60.0' AND 'I69.9'
		GROUP BY d.SURNAME, d.FIRSTNAME, d.LASTNAME, d.BIRTHDATE  ) AS d
GROUP BY d.SURNAME, d.FIRSTNAME, d.LASTNAME, d.BIRTHDATE 
HAVING COUNT(*) > 1





--������ 1 + ������2 + ������ 3
DROP TABLE dd_0002
SELECT '2' goup, d.SURNAME, d.FIRSTNAME, d.LASTNAME, d.BIRTHDATE, 
				dbo.GROUP_CONCAT_DS(DISTINCT ��_���10_��� , N' , ', 1)��_���10_���
INTO dd_0002
FROM(
	SELECT *
	FROM dgr_001
	UNION ALL
	SELECT *
	FROM dgr_002
	UNION ALL
	SELECT *
	FROM dgr_003 ) AS d
GROUP BY d.SURNAME, d.FIRSTNAME, d.LASTNAME, d.BIRTHDATE
HAVING COUNT(*) > 2

DROP TABLE dd_0003
SELECT '3' goup, d.SURNAME, d.FIRSTNAME, d.LASTNAME, d.BIRTHDATE, 
				dbo.GROUP_CONCAT_DS(DISTINCT ��_���10_��� , N' , ', 1)��_���10_���
INTO dd_0003_1
FROM(
	SELECT *
	FROM dgr_001
	UNION ALL
	SELECT *
	FROM dgr_002
	 ) AS d
GROUP BY d.SURNAME, d.FIRSTNAME, d.LASTNAME, d.BIRTHDATE
HAVING COUNT(*) > 1

SELECT '3' goup, d.SURNAME, d.FIRSTNAME, d.LASTNAME, d.BIRTHDATE, 
				dbo.GROUP_CONCAT_DS(DISTINCT ��_���10_��� , N' , ', 1)��_���10_���
INTO dd_0003_2
FROM(
	SELECT *
	FROM dgr_001
	UNION ALL
	SELECT *
	FROM dgr_003
	 ) AS d
GROUP BY d.SURNAME, d.FIRSTNAME, d.LASTNAME, d.BIRTHDATE
HAVING COUNT(*) > 1


SELECT '3' goup, d.SURNAME, d.FIRSTNAME, d.LASTNAME, d.BIRTHDATE, 
				dbo.GROUP_CONCAT_DS(DISTINCT ��_���10_��� , N' , ', 1)��_���10_���
INTO dd_0003
				FROM(
						SELECT *
						FROM dd_0003_1
						UNION ALL
						SELECT *
						FROM dd_0003_2 ) AS d
GROUP BY d.SURNAME, d.FIRSTNAME, d.LASTNAME, d.BIRTHDATE






SELECT 'all' goup, d.SURNAME, d.FIRSTNAME, d.LASTNAME, d.BIRTHDATE, 
				dbo.GROUP_CONCAT_DS(DISTINCT ��_���10_��� , N' , ', 1)��_���10_���
				FROM(
						SELECT *
						FROM dd_0001
						UNION ALL
						SELECT *
						FROM dd_0002
						UNION ALL
						SELECT *
						FROM dd_0003 ) AS d
GROUP BY d.SURNAME, d.FIRSTNAME, d.LASTNAME, d.BIRTHDATE