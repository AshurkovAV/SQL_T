SELECT a.*
--UPDATE zsl SET EXP_COMENT = a.[�����������]
FROM D3_ZSL_OMS AS zsl
JOIN a AS a ON a.[�����������] = 'ZSL_ID: '+ zsl.ZSL_ID AND zsl.D3_SCID = 2090

--AND a.[�����������] <> '�� ��������� ���� �������� ����������� C_ZAB' AND a.[�����������] <> '�� ��������� ������������ ���� C_ZAB'

 AND a.[�����������]  LIKE '%��%'-- AND a.[�����������] not like  '� �����. �������� COVID19 ����������� ��������������� ������'
-- AND a.[�����������]  not LIKE 
-- '�� ������� ���. �����. �� �� 29.03.2019�. N173�,���� ���������� ���������� ����. �������. � �����. �������������,�������� ����. ����������'
----JOIN D3_SL_OMS AS sl ON sl.D3_ZSLID = zsl.ID

--DROP TABLE a

--SELECT * 
----delete a
--FROM a
----WHERE a.[�����������] = '������������ ������� � ������ ������ �������'
--GROUP BY 
--zsl.SUMV

--SELECT * FROM a AS a

