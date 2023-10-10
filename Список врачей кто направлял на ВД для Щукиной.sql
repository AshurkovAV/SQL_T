IF OBJECT_ID (N'dbo.ztemp_du03082023_2', N'U') IS NOT NULL  
DROP TABLE ztemp_du03082023_2
IF OBJECT_ID (N'dbo.ztemp_sl_2', N'U') IS NOT NULL  
DROP TABLE ztemp_sl_2

SELECT dpo.FAM, dpo.IM, dpo.OT, dpo.DR, dzo.DATE_Z_1, (SELECT TOP 1 ysme.NameWithID
	                                                         FROM Yamed_Spr_MedicalEmployee AS ysme WHERE ysme.SNILS = dso.IDDOKT) doc
	INTO ztemp_sl_2
	FROM D3_ZSL_OMS AS dzo
		JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
		JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
		JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dzo.D3_SCID
	WHERE dzo.D3_SCID IN (20568)


SELECT dpo.FAM, dpo.IM, dpo.OT, dpo.DR, dzo.DATE_Z_1, (SELECT TOP 1 ysme.NameWithID
																 FROM Yamed_Spr_MedicalEmployee AS ysme WHERE ysme.SNILS = dso.IDDOKT) doc
	INTO ztemp_du03082023_2
	FROM D3_ZSL_OMS AS dzo
		JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
		JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
		JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dzo.D3_SCID
	WHERE dzo.D3_SCID IN (20570, 20571)
	

SELECT t2.doc, SUM(t2.[����� ���������])[����� ���������],
	SUM(t2.[������ �� ����� ������]) [������ �� ����� ������],
	SUM(t2.[������ �� ����� ������]) [������ �� ����� ������],
	SUM(t2.[�� ������ ��])[�� ������ ��]
FROM(	
SELECT t.doc, 1 '����� ���������', 
CASE WHEN t.DATE_Z_1 > t1.DATE_Z_1 THEN 1 ELSE 0 END '������ �� ����� ������',
CASE WHEN t.DATE_Z_1 <= t1.DATE_Z_1 THEN 1 ELSE 0 END '������ �� ����� ������', 
CASE WHEN t1.fam IS NULL THEN 1 ELSE 0 END '�� ������ ��'
	FROM ztemp_sl_2 AS t
	LEFT JOIN ztemp_du03082023_2 AS t1 ON t1.FAM = t.FAM AND t1.IM = t.IM AND t1.OT = t.OT AND t1.DR = t.DR) AS t2
GROUP BY t2.doc
ORDER BY doc
