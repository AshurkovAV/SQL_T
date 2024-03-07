DECLARE @D3_SCID_old INT = 175 --старый реестр где они сейчас
DECLARE @D3_SCID_new INT = 170 --новый реестр куда нужно перенести

UPDATE dpo SET dpo.D3_SCID = @D3_SCID_new
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dzo ON dzo.D3_PID = dpo.ID
WHERE dzo.D3_SCID = @D3_SCID_old 
--AND dzo.USERID IS NULL
--AND dz.ID IN (SELECT id FROM @tab)

UPDATE dz SET dz.D3_SCID = @D3_SCID_new
FROM D3_ZSL_OMS AS dz
WHERE dz.D3_SCID = @D3_SCID_old --AND dz.ID IN (SELECT id FROM @tab)