DECLARE @D3_SCID_old INT = 4209 --старый реестр где они сейчас
DECLARE @D3_SCID_new INT = 9070 --новый реестр куда нужно перенести

UPDATE dpo SET dpo.D3_SCID = @D3_SCID_new
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dzo ON dzo.D3_PID = dpo.ID
WHERE dzo.D3_SCID = @D3_SCID_old 

UPDATE dz SET dz.D3_SCID = @D3_SCID_new
FROM D3_ZSL_OMS AS dz
WHERE dz.D3_SCID = @D3_SCID_old --AND dz.ID IN (SELECT id FROM @tab)


--UPDATE s SET s.SCHET_ID = 2115
--FROM SLUCH AS s
--WHERE s.SCHET_ID = 2112  


--UPDATE dzo SET D3_SCID = 2141
--FROM D3_ZSL_OMS AS dzo
--JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
--WHERE dzo.D3_SCID = 2143

