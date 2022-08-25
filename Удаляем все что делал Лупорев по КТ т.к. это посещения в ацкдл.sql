--SELECT dso.ID, dzo.ID, dso.SL_ID, 460026, dso.PROFIL, 'R01.001.037', 0, dso.DATE_1, dso.DATE_2, dso.DS1, 'R01.001.037', 1, dso.PRVS, dso.IDDOKT, 'V021'
if OBJECT_ID('ztemp_03062019_1_21delposdet1') is not null drop table ztemp_03062019_1_21delposdet1

SELECT izslid, slid, D3_PID, duoid
INTO ztemp_03062019_1_21delposdet1
FROM(
SELECT dpo.FAM, dpo.IM, dpo.OT, dpo.DR, dso.DATE_1
FROM D3_ZSL_OMS AS dzo
JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
WHERE dzo.D3_SCID = 8005 AND dso.IDDOKT IN ( '140-296-610 41', '165-712-342 65', '107-905-482 61')
AND (ds1 LIKE 'u%' OR ds1 LIKE 'j%')
AND dso.P_CEL = '1.0') AS t
JOIN(
SELECT dzo.ID izslid, dso.ID slid, dpo.ID D3_PID, duo.ID duoid, dpo.FAM, dpo.IM, dpo.OT, dpo.DR, dso.DATE_1
FROM D3_ZSL_OMS AS dzo
JOIN D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
JOIN D3_USL_OMS AS duo ON duo.D3_SLID = dso.ID
WHERE dzo.D3_SCID = 8005 AND dso.IDDOKT IN ( '157-898-373 47')
AND (ds1 LIKE 'u%' OR ds1 LIKE 'j%')
) AS t1 ON t1.FAM = t.FAM AND t1.IM = t.IM AND t1.OT = t.OT AND t1.DR = t.DR AND t1.DATE_1 = t.DATE_1


--SELECT *
--FROM ztemp_03062019_1_21delposdet1

DELETE FROM D3_USL_OMS
WHERE ID IN (SELECT duoid FROM ztemp_03062019_1_21delposdet1)

DELETE FROM D3_SL_OMS
WHERE ID IN (SELECT slid FROM ztemp_03062019_1_21delposdet1)

DELETE FROM D3_ZSL_OMS
WHERE ID IN (SELECT izslid FROM ztemp_03062019_1_21delposdet1)

DELETE FROM D3_PACIENT_OMS
WHERE ID IN (SELECT D3_PID FROM ztemp_03062019_1_21delposdet1)


--157-898-373 47