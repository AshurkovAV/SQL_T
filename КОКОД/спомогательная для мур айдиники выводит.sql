
SELECT dzo.D3_PID pid, dzo.id zslid, dzo.D3_SCID  --, t.*
INTO  temp_mur_8_2038_1
FROM  temp_mur_8_2038 t
join  D3_ZSL_OMS AS dzo on dzo.zsl_id =ltrim(rtrim(t.zsl_id))
WHERE dzo.D3_SCID=8688