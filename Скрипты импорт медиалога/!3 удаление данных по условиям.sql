DECLARE @schetid INT = 20292
if OBJECT_ID('ztemp_digCdelete') is not null drop table ztemp_digCdelete
SELECT dzo.ID izslid, dso.ID slid, dzo.D3_PID
INTO ztemp_digCdelete
FROM D3_ZSL_OMS AS dzo
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
WHERE dzo.D3_SCID = @schetid 
AND dso.IDDOKT = '154-483-466 82'
AND dzo.EXP_COMENT LIKE '%Код мед.специальности некорректен для вида помощи 11%'

DELETE FROM D3_SL_OMS
WHERE ID IN (SELECT slid FROM ztemp_digCdelete)

DELETE FROM D3_ZSL_OMS
WHERE ID IN (SELECT izslid FROM ztemp_digCdelete)

DELETE FROM D3_PACIENT_OMS
WHERE ID IN (SELECT D3_PID FROM ztemp_digCdelete)

--DELETE FROM D3_PACIENT_OMS WHERE D3_SCID = @schetid


if OBJECT_ID('ztemp_digCdelete') is not null drop table ztemp_digCdelete
SELECT dzo.ID izslid, dso.ID slid, dzo.D3_PID
INTO ztemp_digCdelete
FROM D3_ZSL_OMS AS dzo
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
--JOIN ztempdel_zsl AS t ON t.zsl_id = dzo.ZSL_ID 
WHERE dzo.D3_SCID = 20292
AND dso.IDDOKT = '154-483-466 82'
AND dzo.EXP_COMENT LIKE '%Код мед.специальности некорректен для вида помощи 11%'


BEGIN TRAN T1;

DELETE FROM D3_USL_OMS
WHERE D3_SLID IN (SELECT slid FROM ztemp_digCdelete)

DELETE FROM D3_SL_OMS
WHERE ID IN (SELECT slid FROM ztemp_digCdelete)

DELETE FROM D3_ZSL_OMS
WHERE ID IN (SELECT izslid FROM ztemp_digCdelete)

DELETE FROM D3_PACIENT_OMS
WHERE ID IN (SELECT D3_PID FROM ztemp_digCdelete)


COMMIT TRAN T1;  

