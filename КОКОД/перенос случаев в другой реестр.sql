--SELECT TOP 100 *
BEGIN tran
UPDATE p 
SET p.D3_SCID=160
FROM d3_pacient_oms p
JOIN temp_for_160 t ON t.pid=p.id

UPDATE zsl 
SET zsl.D3_scid=160
--SELECT TOP 100 *
FROM D3_ZSL_OMS AS zsl 
JOIN temp_for_160 t ON t.zslid=zsl.id

COMMIT TRAN


