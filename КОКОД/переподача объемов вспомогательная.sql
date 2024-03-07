SELECT dzo.D3_PID, dzo.D3_SCID, t.* 
--INTO temp_kokod_6_V_C
FROM temp_kokod_6 t
 JOIN D3_ZSL_OMS AS dzo ON dzo.zsl_id = t.zsl_id
WHERE s_osn not LIKE '1.6.2.' AND schettype LIKE 'H'
--AND t.[וה. מבü¸ל] IN (SELECT name FROM medicalServices AS ms WHERE code_usl BETWEEN 'R01.001.008' AND 'R01.001.036')
--AND dzo.D3_SCID IN (6905,5685)