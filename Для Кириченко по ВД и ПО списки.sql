SELECT dpo.NPOLIS, 
	dpo.FAM, dpo.IM, dpo.ot, cast(dpo.DR AS DATE) dr, 
	case when dpo.w=2 and [dbo].[f_GetAge] (dpo.DR,dzo.DATE_Z_1) <61 or dpo.w=1 and [dbo].[f_GetAge] (dpo.DR,dzo.DATE_Z_1) <66 then '��������������'		
		when dpo.w=2 and [dbo].[f_GetAge] (dpo.DR,dzo.DATE_Z_1) >=61 or dpo.w=1 and [dbo].[f_GetAge] (dpo.DR,dzo.DATE_Z_1) >=66 then '������ ���������������' 
		end [������� ����������������]	,
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
		  WHEN dso2.[MONTH] = 12 THEN '�������' 
		  ELSE '���-�� ����� �� ���' END) [����� ������], 
	(SELECT TOP  1 v017.NameWithID FROM v017 WHERE IDDR =  dzo.RSLT_D)RSLT_D, 
	(SELECT TOP 1 ysme.NameWithID FROM Yamed_Spr_MedicalEmployee AS ysme WHERE ysme.SNILS = iddokt)iddokt1, 
	(CASE WHEN ysme.LPU_ID = 460006 THEN '���������'
	      WHEN ysme.LPU_ID = 460026 THEN '�������' ELSE '���-�� ����� �� ���' END) lpu_id,
	(SELECT osd.NameWithID FROM OsobSluchDb AS osd WHERE osd.Id = dzo.OS_SLUCH_REGION ) OS_SLUCH_REGION,
	dso3.S_COM, dso3.S_TIP,
	CASE WHEN isnull(dzo.PR_NOV, 0) = 0 
			THEN '�������� �� ��������� ����������� ������ ���������� �������' 
			ELSE '������ ���������� �������� ����� �����������' 
    END PR_NOV, dso2.[MONTH], REPLACE(REPLACE(dzo.EXP_COMENT, CHAR(13), ''), CHAR(10), '')expcom
FROM D3_ZSL_OMS AS dzo
	JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
		JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
			JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dzo.D3_SCID --AND dso2.NSCHET LIKE '%����%'
				LEFT JOIN Yamed_Spr_MedicalEmployee AS ysme ON ysme.SNILS = dso.IDDOKT
					LEFT JOIN D3_SANK_OMS AS dso3 ON dso3.D3_ZSLID = dzo.ID
WHERE dzo.OS_SLUCH_REGION IN (4,47,49,50 ) 
AND dso2.[MONTH] IN (1,2,3,4,5,6,7,8) 
AND dso2.[YEAR] = 2025
AND dso2.NSCHET NOT LIKE '%�����%'
AND (dzo.PR_NOV IS NULL OR dzo.PR_NOV = 0)

UNION ALL

SELECT dpo.NPOLIS,
	dpo.FAM, dpo.IM, dpo.ot, cast(dpo.DR AS DATE) dr, 
	case when dpo.w=2 and [dbo].[f_GetAge] (dpo.DR,dzo.DATE_Z_1) <61 or dpo.w=1 and [dbo].[f_GetAge] (dpo.DR,dzo.DATE_Z_1) <66 then '��������������'		
		when dpo.w=2 and [dbo].[f_GetAge] (dpo.DR,dzo.DATE_Z_1) >=61 or dpo.w=1 and [dbo].[f_GetAge] (dpo.DR,dzo.DATE_Z_1) >=66 then '������ ���������������' 
		end [������� ����������������]	,
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
    END PR_NOV, dso2.[MONTH], REPLACE(REPLACE(dzo.EXP_COMENT, CHAR(13), ''), CHAR(10), '')expcom
FROM D3_ZSL_OMS AS dzo
	JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
		JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
			JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dzo.D3_SCID --AND dso2.NSCHET LIKE '%����%'
				LEFT JOIN Yamed_Spr_MedicalEmployee AS ysme ON ysme.SNILS = dso.IDDOKT
					LEFT JOIN D3_SANK_OMS AS dso3 ON dso3.D3_ZSLID = dzo.ID
WHERE  dso2.[MONTH] IN (1, 2,3,4,5,6,7,8) 
AND dso2.[YEAR] = 2025
AND dso2.SchetType IN ('DD', 'DE')
AND (dzo.PR_NOV IS NULL OR dzo.PR_NOV = 0)

--ORDER BY dpo.FAM, dpo.IM, dpo.OT
