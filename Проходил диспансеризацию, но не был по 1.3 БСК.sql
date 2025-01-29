DROP TABLE ztemp_not13
SELECT t1.* 
INTO ztemp_not13
FROM (
			SELECT DISTINCT dpo.FAM, dpo.IM, dpo.OT, dpo.DR, dzo.OS_SLUCH_REGION, dzo.DATE_Z_2
			FROM D3_ZSL_OMS AS dzo
				JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
					JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
						JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dzo.D3_SCID
			WHERE dso2.[YEAR] = 2024
			AND dzo.OS_SLUCH_REGION IN (47, 49)
			
) AS t1

LEFT JOIN (
			SELECT DISTINCT dpo.FAM, dpo.IM, dpo.OT, dpo.DR, dzo.OS_SLUCH_REGION
			FROM D3_ZSL_OMS AS dzo
				JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
					JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
						JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dzo.D3_SCID
			WHERE dso2.[YEAR] = 2024
			AND dzo.OS_SLUCH_REGION IN (59)
) AS t2 ON t2.FAM = t1.FAM AND t2.IM = t1.IM AND t2.OT = t1.OT AND t2.DR = t1.DR
		
WHERE t2.FAM IS NULL

--SELECT *
--FROM ztemp_du_bsk

DROP TABLE ztemp_du_bsk
--DROP TABLE ztemp_ztemp_du_bsk_adr
-----------1 ���.
SELECT DISTINCT t.Fam, t.Im, t.Ot, t.Dr, DATE_Z_2, OS_SLUCH_REGION,  [�������#��#��������], �����
INTO ztemp_du_bsk
FROM ztemp_not13 AS t
	JOIN dbo.dubsk AS t1 ON t1.������� = t.fam
														AND t1.��� = t.IM
														AND t1.�������� = t.ot
														AND t1.[��] = t.dr

-----------3.���������� �������� �� ����� ���� ���������---------		
DROP TABLE zt1
SELECT *
INTO zt1
FROM ztemp_du_bsk AS tt
LEFT JOIN [test].[dbo].[Tel] t ON tt.fam=f and tt.im=i and tt.ot=o and tt.dr=d

-----------4.
-----------�������---------------------
SELECT distinct z.*
FROM zt z
LEFT JOIN [test].[dbo].[prikrep7KGP] p ON p.������� = fam 
									AND p.��� = im
									AND p.�������� = ot
WHERE p.������� IS NULL
-----------�������---------------------


-----------���������---------------------
SELECT distinct z.*
FROM zt1 z
LEFT JOIN [test].[dbo].[prikrep7KGP] p ON p.������� = fam 
									AND p.��� = im
									AND p.�������� = ot
									AND p.[���� ��������] = dr
										
WHERE p.������� IS not NULL
-----------���������---------------------			

