DECLARE @schet_old INT = 2076
DECLARE @schet_new INT = 2071

--UPDATE SLUCH SET SCHET_ID = @schet_new
--WHERE SCHET_ID = @schet_old

--UPDATE USL SET SCHET_ID = @schet_new
--WHERE SCHET_ID = @schet_old

--UPDATE PACIENT SET SCHET_ID = @schet_new
--WHERE SCHET_ID = @schet_old



UPDATE dz SET dz.D3_SCID = @schet_new
FROM D3_ZSL AS dz
WHERE dz.D3_SCID = @schet_old