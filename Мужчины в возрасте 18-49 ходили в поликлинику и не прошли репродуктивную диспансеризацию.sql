if OBJECT_ID('ztemp_du_bsk') is not null DROP TABLE ztemp_du_bsk
if OBJECT_ID('ztemp_pos') is not null DROP TABLE ztemp_pos

--------------//// 1. ��������� �� ����������� �� 3 ������ �������� ���������////------------------------
	SELECT dpo.FAM, dpo.IM, dpo.OT, dpo.DR, 
				dbo.GROUP_CONCAT_DS(DISTINCT cast(dzo.DATE_Z_1 AS DATE), N' , ', 1)DATE_Z_1, 
				dbo.GROUP_CONCAT_DS(DISTINCT ysme.NameWithID, N' , ', 1)NameWithID,
				(CASE WHEN dbo.GROUP_CONCAT_DS(DISTINCT ysme.LPU_ID, N' , ', 1) = '460006' THEN '���������'
					  WHEN dbo.GROUP_CONCAT_DS(DISTINCT ysme.LPU_ID, N' , ', 1) = '460026' THEN '�������' ELSE '���-�� ����� �� ���' END) lpu_id
	INTO ztemp_pos
	FROM D3_PACIENT_OMS AS dpo
		JOIN D3_ZSL_OMS AS dzo ON dzo.D3_PID = dpo.ID
			JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
				JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dzo.D3_SCID
					JOIN Yamed_Spr_MedicalEmployee AS ysme ON ysme.SNILS = dso.IDDOKT
	WHERE ( (dso2.[YEAR] = 2025 AND dso2.[MONTH] IN (7,8)))
						AND dpo.W = 1 --���
						AND dzo.USL_OK = 3 --������� �������� ����������� ������ ����������� 
						AND year(dpo.DR) BETWEEN 1976 AND 2007
	GROUP BY  dpo.FAM, dpo.IM, dpo.OT, dpo.DR
--------------////1. ��������� �� ����������� �� 3 ������ �������� ���������////------------------------

if OBJECT_ID('ztemp_pos_1') is not null DROP TABLE ztemp_pos_1

SELECT *
INTO ztemp_pos_1
FROM ztemp_pos t
	JOIN Prikrep AS p ON p.������� = fam AND p.��� = im AND p.�������� = ot AND p.����_�������� = dr 
WHERE p.������������ = 'True'


SELECT t.*
INTO ztemp_du_bsk
FROM ztemp_pos_1 AS t
--------------////�������������� ���������������////------------------------		
	LEFT JOIN (		
				SELECT dpo.NPOLIS,
				dpo.FAM, dpo.IM, dpo.ot, cast(dpo.DR AS DATE) dr, 
				(SELECT NameWithID FROM V005 WHERE Id= w)w,
				dpo.FAM + ' ' + dpo.IM + ' ' +  dpo.ot + ' ' + convert(NVARCHAR(10), dpo.DR, 104) fio,
				cast(dzo.DATE_Z_2 AS DATE)d2, ds1, 
				(CASE WHEN dso2.[MONTH] = 1 THEN  '������'
					  WHEN dso2.[MONTH] = 2 THEN  '�������'
					  WHEN dso2.[MONTH] = 3 THEN  '����'
					  WHEN dso2.[MONTH] = 4 THEN  '������'
					  WHEN dso2.[MONTH] = 5 THEN  '���'
					  WHEN dso2.[MONTH] = 6 THEN  '����'
					  WHEN dso2.[MONTH] = 7 THEN  '����'
					  WHEN dso2.[MONTH] = 8 THEN  '������'
					  WHEN dso2.[MONTH] = 9 THEN  '��������'
					  WHEN dso2.[MONTH] = 10 THEN '�������'
					  WHEN dso2.[MONTH] = 11 THEN '������'
					  WHEN dso2.[MONTH] = 12 THEN '�������' ELSE '���-�� ����� �� ���' END) [����� ������], --dzo.OS_SLUCH_REGION,
				(SELECT TOP  1 v017.NameWithID FROM v017 WHERE IDDR =  dzo.RSLT_D)RSLT_D, 
				(SELECT TOP 1 ysme.NameWithID FROM Yamed_Spr_MedicalEmployee AS ysme WHERE ysme.SNILS = iddokt)iddokt1, 
				(CASE WHEN ysme.LPU_ID = 460006 THEN '���������'
					  WHEN ysme.LPU_ID = 460026 THEN '�������' ELSE '���-�� ����� �� ���' END) lpu_id,
				(CASE WHEN dso2.SchetType = 'DD' THEN '������ ���� ��������������� ��� ������ ��������������� ��������'
					  WHEN dso2.SchetType = 'DE' THEN '������ ���� ��������������� ��� ������ ��������������� ��������' ELSE '���-�� ����� �� ���' END) OS_SLUCH_REGION,
				dso3.S_COM, dso3.S_TIP,
				CASE WHEN isnull(dzo.PR_NOV, 0) = 0 
						THEN '�������� �� ��������� ����������� ������ ���������� �������' 
						ELSE '������ ���������� �������� ����� �����������' 
				END PR_NOV, dso2.[MONTH]
			FROM D3_ZSL_OMS AS dzo
				JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
					JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
						JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dzo.D3_SCID --AND dso2.NSCHET LIKE '%����%'
							LEFT JOIN Yamed_Spr_MedicalEmployee AS ysme ON ysme.SNILS = dso.IDDOKT
								LEFT JOIN D3_SANK_OMS AS dso3 ON dso3.D3_ZSLID = dzo.ID
			WHERE  dso2.[MONTH] IN (1, 2, 3,4,5,6,7,8) 
			AND dso2.[YEAR] = 2025
			AND dso2.SchetType IN ('DD', 'DE')
			AND (dzo.PR_NOV IS NULL OR dzo.PR_NOV = 0)) AS rep
--------------////�������������� ���������������////------------------------		
																ON rep.FAM = t.FAM
																AND rep.IM = t.IM
																AND rep.OT = t.OT
																AND rep.DR = t.DR			
WHERE rep.FAM IS NULL



-----------3. �������� ������ �� ������ ��������������� ��� ����������� ��������� ���������		
if OBJECT_ID('zt') is not null DROP TABLE zt
GO
		
SELECT t_du.*,
     CASE WHEN OS_SLUCH_REGION IS NOT NULL THEN (SELECT osd.NameWithID
                                              FROM OsobSluchDb AS osd WHERE osd.Id = OS_SLUCH_REGION) + ' ' + CONVERT(NVARCHAR(10), t_p.DATE_Z_1, 110)
     ELSE '�� �������� � � �' END  [D P] 
INTO zt
FROM ztemp_du_bsk AS t_du
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




SELECT * FROM zt ORDER BY fam,im,ot,dr