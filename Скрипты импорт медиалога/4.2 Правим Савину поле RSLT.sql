UPDATE dz SET RSLT = 314
FROM D3_ZSL_OMS AS dz
JOIN D3_PACIENT_OMS AS p ON dz.D3_PID = p.ID
WHERE dz.D3_SCID = 2140 AND 
dz.EXP_COMENT LIKE '%Некорректное значение поля Z_SL/RSLT. Значение отсутствует в справочнике V009 или неактуально на момент посещения%'