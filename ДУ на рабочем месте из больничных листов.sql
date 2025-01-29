DROP TABLE ztemp_1410

SELECT bars.*,  max(ais.[���-10]) mkb_ais
INTO ztemp_1410
FROM ( SELECT  *
	   FROM [elmed].[dbo].du101024
       WHERE ������� IS NOT NULL   
				AND [���� ������ � ��] IS NULL ) AS ais
JOIN (
		SELECT *
		FROM [elmed].[dbo].[eln_20241011$]
		WHERE � >= '20240801') AS bars ON bars.������� = ais.������� 
												AND bars.��� = ais.��� 
												AND bars.�������� = ais.�������� 
												AND bars.[���� �������� ��������] = ais.[���� ��������]
												--AND bars.[���� ���-10] = ais.[���-10]
GROUP BY [�����]
      ,[���]
      ,[���������]
      ,bars.[�������]
      ,bars.[���]
      ,bars.[��������]
      ,[�����������]
      ,[����� ��������]
      ,[���� �������� ��������]
      ,[������� ��������]
      ,[��� ��������]
      ,[�������]
      ,[������ �����]
      ,[���� �������� �������������]
      ,[������� �������������]
      ,[��� �������������]
      ,[����� ������]
      ,[����� �����]
      ,[����� ������������ ����������]
      ,[�������� ����]
      ,[��������� ����]
      ,[�]
      ,[��]
      ,[���� ��������]
      ,[����� � ����� ��]
      ,[������� ������-��]
      ,[���# ���]
      ,[��������������� �������]
      ,[�������������� �������]
      ,[����� �� �������]
      ,[���������� ����]
      ,[������]
      ,[���������, ���������� ��]
      ,[���������]
      ,[������]
      ,[��� ��]
--ORDER BY ais.�������

DROP TABLE ztemp_du_pred

SELECT dpo.FAM, dpo.IM, dpo.OT, dpo.DR,
	dbo.GROUP_CONCAT_DS(DISTINCT ysme.NameWithID, N' , ', 1)NameWithID,
	dbo.GROUP_CONCAT_DS(DISTINCT ysme.LPU_ID, N' , ', 1)LPU_ID
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
			AND (dso2.[YEAR] = 2024)
	GROUP BY  dpo.FAM, dpo.IM, dpo.OT, dpo.DR

SELECT dt.�������, dt.���, dt.��������, dt.[���� �������� ��������], 
(SELECT TOP 1 ysme.SNILS
   FROM Yamed_Spr_MedicalEmployee AS ysme WHERE ysme.fam LIKE '%' + SUBSTRING(dt.[�������� ����], 1, CHARINDEX(' ', dt.[�������� ����], 1) - 1) + '%')doc , dt.��, dt.mkb_ais
FROM ztemp_1410 AS dt
	LEFT JOIN ztemp_du_pred AS dp ON dt.[�������] = dp.FAM AND dt.[���] = dp.IM AND dt.[��������] = dp.OT AND dt.[���� �������� ��������] = dp.DR
WHERE dp.fam IS null