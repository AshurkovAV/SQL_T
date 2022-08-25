DECLARE @D3_SCID INT = 2072
SELECT dz.id, p.FAM, p.IM, p.OT, p.DR, '������ ���� ��������� ���������'
FROM D3_ZSL AS dz
JOIN D3_SL AS ds ON dz.ID = ds.D3_ZSLID
JOIN PACIENT AS p ON dz.D3_PID = p.ID
WHERE dz.RSLT IS NULL AND dz.D3_SCID = @D3_SCID
UNION
--UPDATE ds SET DET- = 0
SELECT dz.id, p.FAM, p.IM, p.OT, p.DR, '����������� �������� � ������������ ���� ������'
FROM D3_ZSL AS dz
JOIN D3_SL AS ds ON dz.ID = ds.D3_ZSLID
JOIN PACIENT AS p ON dz.D3_PID = p.ID
WHERE ds.IDDOKT IS NULL AND dz.D3_SCID = @D3_SCID
UNION
--UPDATE ds SET DET- = 0
SELECT dz.id, p.FAM, p.IM, p.OT, p.DR, '����������� �������� � ������������ ���� �������'
FROM D3_ZSL AS dz
JOIN D3_SL AS ds ON dz.ID = ds.D3_ZSLID
JOIN PACIENT AS p ON dz.D3_PID = p.ID
WHERE ds.PROFIL IS NULL AND dz.D3_SCID = @D3_SCID
UNION
--UPDATE ds SET DET- = 0
SELECT dz.id, p.FAM, p.IM, p.OT, p.DR, '����������� �������� � ������������ ���� �������������'
FROM D3_ZSL AS dz
JOIN D3_SL AS ds ON dz.ID = ds.D3_ZSLID
JOIN PACIENT AS p ON dz.D3_PID = p.ID
WHERE ds.PRVS IS NULL AND dz.D3_SCID = @D3_SCID
union
SELECT dz.id, p.FAM, p.IM, p.OT, p.DR, '����������� �������� � ������������ ���� �������� �������'
FROM D3_ZSL AS dz
JOIN D3_SL AS ds ON dz.ID = ds.D3_ZSLID
JOIN PACIENT AS p ON dz.D3_PID = p.ID
WHERE ds.DS1 IS NULL AND dz.D3_SCID = @D3_SCID
union
SELECT dz.id, p.FAM, p.IM, p.OT, p.DR, '����������� �������� � ������������ ���� DET'
FROM D3_ZSL AS dz
JOIN D3_SL AS ds ON dz.ID = ds.D3_ZSLID
JOIN PACIENT AS p ON dz.D3_PID = p.ID
WHERE ds.DET IS NULL AND dz.D3_SCID = @D3_SCID
union
SELECT dz.id, p.FAM, p.IM, p.OT, p.DR, '����������� �������� � ������������ ���� VPOLIS'
FROM D3_ZSL AS dz
JOIN D3_SL AS ds ON dz.ID = ds.D3_ZSLID
JOIN PACIENT AS p ON dz.D3_PID = p.ID
WHERE p.VPOLIS IS NULL AND dz.D3_SCID = @D3_SCID
UNION
SELECT dz.id, p.FAM, p.IM, p.OT, p.DR, '����������� �������� � ������������ ���� ���� ��� ���� ����'
FROM D3_ZSL AS dz
JOIN D3_SL AS ds ON dz.ID = ds.D3_ZSLID
JOIN PACIENT AS p ON dz.D3_PID = p.ID
WHERE (ds.DATE_1 IS NULL OR ds.DATE_2 IS NULL) AND dz.D3_SCID = @D3_SCID
UNION
SELECT dz.id, p.FAM, p.IM, p.OT, p.DR, '����������� �������� � ������������ ���� ���� ��� ���� ����'
FROM D3_ZSL AS dz
JOIN D3_SL AS ds ON dz.ID = ds.D3_ZSLID
JOIN PACIENT AS p ON dz.D3_PID = p.ID
WHERE (dz.DATE_Z_1 IS NULL OR dz.DATE_Z_2 IS NULL) AND dz.D3_SCID = @D3_SCID
UNION
SELECT dz.id, p.FAM, p.IM, p.OT, p.DR, '����������� �������� � ������������ ���� ��������� ���� �����'
FROM D3_ZSL AS dz
JOIN D3_SL AS ds ON dz.ID = ds.D3_ZSLID
JOIN PACIENT AS p ON dz.D3_PID = p.ID
WHERE (dz.RSLT IS NULL OR dz.ISHOD IS NULL) AND dz.D3_SCID = @D3_SCID
UNION
SELECT dz.id, p.FAM, p.IM, p.OT, p.DR, '����������� �������� � ������������ ���� ���'
FROM D3_ZSL AS dz
JOIN D3_SL AS ds ON dz.ID = ds.D3_ZSLID
JOIN PACIENT AS p ON dz.D3_PID = p.ID
WHERE p.W IS NULL AND dz.D3_SCID = @D3_SCID