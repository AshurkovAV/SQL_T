DROP TABLE ztemp_prikrep_not_visit

SELECT t.*
INTO ztemp_prikrep_not_visit
FROM(
			SELECT ap.�������, ap.���, ap.��������, ap.����_��������, 
				ISNULL(ap.�����_����� , '-') + ' ' + isnull(ap.�����_���������_����� , '-') + ' ' + isnull(ap.�����_����� , '-') + ' ' + ISNULL(ap.�����_��� , '-') + ' ' + isnull(ap.�����_������ , '-')  + ' ' + isnull(ap.�����_�������� , '-')  addr, ap.����������_��
			FROM Prikrep AS ap
			WHERE ap.������������ = 'True' AND ap.����_�������� <= '20050101') AS t
LEFT JOIN
	( 
			SELECT dpo.FAM, dpo.IM, dpo.OT, dpo.DR
			FROM D3_SCHET_OMS AS dso2
				JOIN D3_ZSL_OMS AS dzo             ON dzo.D3_SCID  = dso2.ID
					JOIN D3_PACIENT_OMS AS dpo     ON dpo.ID       = dzo.D3_PID
						JOIN D3_SL_OMS AS dso      ON dso.D3_ZSLID = dzo.ID
			WHERE (dso2.[YEAR] = 2023 AND dso2.[MONTH] IN (8,9,10,11,12)) OR 
				   dso2.[YEAR] = 2024 OR 
				  (dso2.[YEAR] = 2025 AND dso2.[MONTH] IN (1,2,3,4,5,6,7))
				  
	)AS t2						ON t2.FAM = t.������� 
									AND t2.IM = t.��� 
									AND t2.OT = t.�������� 
									AND t2.DR = t.����_��������
WHERE t2.FAM IS NULL


---�������� ��������� �� �������-------
SELECT g.*, t.MOBIL_TELEFON, t.mcod
	FROM ztemp_prikrep_not_visit g
		LEFT JOIN telefon1 AS t ON t.NOM = ������� AND t.PRENOM = ��� AND t.PATRONYME = �������� AND t.NE_LE = ����_��������		
WHERE g.����������_�� = '�������' AND
(  
	charindex('�����',    addr)=0 AND  
	charindex('������',   addr)=0 AND
	charindex('�������',  addr)=0 AND
	charindex('��������', addr)=0 AND
	charindex('��������', addr)=0 AND
	charindex('������',   addr)=0  AND
	charindex('�������',  addr)=0 
) 