DECLARE @D3_SCID_old INT = 2022 --старый реестр где они сейчас
DECLARE @D3_SCID_new INT = 2021 --новый реестр куда нужно перенести

--DECLARE @tab TABLE (
--	id INT
--	)
--INSERT INTO @tab(id)VALUES() --Указываем id законченного случай который нужно перенести

UPDATE dz SET dz.D3_SCID = @D3_SCID_new
--SELECT *
FROM D3_ZSL AS dz
WHERE dz.D3_SCID = @D3_SCID_old --AND dz.ID IN (SELECT id FROM @tab)