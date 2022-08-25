if OBJECT_ID('ztemp_digCdelete') is not null drop table ztemp_digCdelete
SELECT dzo.ID izslid, dso.ID slid, dzo.D3_PID
INTO ztemp_digCdelete
FROM D3_ZSL_OMS AS dzo
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
WHERE dzo.D3_SCID = 2149 AND dso.DS1 like 'C%'

DELETE FROM D3_SL_OMS
WHERE ID IN (SELECT slid FROM ztemp_digCdelete)

DELETE FROM D3_ZSL_OMS
WHERE ID IN (SELECT izslid FROM ztemp_digCdelete)

DELETE FROM D3_PACIENT_OMS
WHERE ID IN (SELECT D3_PID FROM ztemp_digCdelete)

--FROM D3_ZSL_OMS AS dzo
--JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
--WHERE dso.ID IN (SELECT slid FROM ztemp_digCdelete)


