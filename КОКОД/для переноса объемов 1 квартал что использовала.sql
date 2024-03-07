SELECT *
FROM D3_ZSL_OMS AS dz
--JOIN ztemp_digCdelete_032021 z ON dz.id = z.zslid --перекресты
--JOIN ztemp_desh_Cdelete_032021 z ON dz.id = z.zslid --дешевые
JOIN  temp_07_21_V z ON dz.zsl_id = z.zsl_id --дешевые
WHERE dz.D3_SCID in (2678) and z.schettype like 'H'

SELECT dpo.id as pid,dzo.id as zslid,dzo.d3_scid as old_schet_zsl,dpo.d3_scid as old_scer_p,z.*
into temp_kokod_V_6_vse_C
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dzo ON dzo.D3_PID = dpo.ID
--JOIN ztemp_digCdelete_032021 z ON dpo.ID = z.pid --перекресты
--JOIN ztemp_desh_Cdelete_032021 z ON dpo.ID = z.pid--дешевые
JOIN temp_07_21_V z ON dzo.zsl_id = z.zsl_id  --80 ztemp_desh_Cdelete_022021_new
--JOIN ztemp_covid_032021 z ON dpo.ID = z.pid --ковид
--JOIN ztemp_protocol_03021 z ON dpo.ID = z.pid
WHERE dzo.D3_SCID in (2678,2677) and z.schettype like 'C' and dzo.sumv<>3014.30
--select * from  temp_kokod_V_1_3