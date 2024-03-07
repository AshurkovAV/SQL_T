BEGIN TRAN --commit tran

--DECLARE @D3_SCID_old INT = 1290 --старый реестр где они сейчас
DECLARE @D3_SCID_new INT = 2215 --новый реестр куда нужно перенести

UPDATE dpo SET dpo.D3_SCID = @D3_SCID_new

--SELECT *
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dzo ON dzo.D3_PID = dpo.ID
--JOIN ztemp_digCdelete_032021 z ON dpo.ID = z.pid --перекресты
--JOIN ztemp_desh_Cdelete_032021 z ON dpo.ID = z.pid--дешевые
JOIN temp_kokod_V_1_3_vse_C z ON dpo.ID = z.pid  --80 ztemp_desh_Cdelete_022021_new
--JOIN ztemp_covid_032021 z ON dpo.ID = z.pid --ковид
--JOIN ztemp_protocol_03021 z ON dpo.ID = z.pid
--WHERE dzo.D3_SCID in (2004,2092,2007,2085)




UPDATE dz SET dz.D3_SCID = @D3_SCID_new
--SELECT *
FROM D3_ZSL_OMS AS dz
--JOIN ztemp_digCdelete_032021 z ON dz.id = z.zslid --перекресты
--JOIN ztemp_desh_Cdelete_032021 z ON dz.id = z.zslid --дешевые
JOIN  temp_kokod_V_1_3_vse_C z ON dz.id = z.zslid --дешевые
--WHERE dz.D3_SCID in (2004,2092,2007,2085,2001,2002)
--JOIN  ztemp_covid_032021 z ON dz.id = z.zslid --ковид
--JOIN ztemp_protocol_03021 z ON dz.id = z.zslid 
--WHERE dz.D3_SCID = @D3_SCID_old --AND dz.ID IN (SELECT id FROM @tab)



--rollback


SELECT * FROM temp_kokod_V_1_3_vse_C