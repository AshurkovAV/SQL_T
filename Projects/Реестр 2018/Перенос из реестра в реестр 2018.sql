DECLARE @D3_SCID_old INT = 2022 --������ ������ ��� ��� ������
DECLARE @D3_SCID_new INT = 2021 --����� ������ ���� ����� ���������

--DECLARE @tab TABLE (
--	id INT
--	)
--INSERT INTO @tab(id)VALUES() --��������� id ������������ ������ ������� ����� ���������

UPDATE dz SET dz.D3_SCID = @D3_SCID_new
--SELECT *
FROM D3_ZSL AS dz
WHERE dz.D3_SCID = @D3_SCID_old --AND dz.ID IN (SELECT id FROM @tab)