DECLARE @p1 INT = 9070 --ид реестра где проверяете
--DECLARE @p2 INT = 2347
if OBJECT_ID('ztemp_03062019_1_21delposdet1') is not null drop table ztemp_03062019_1_21delposdet1

--SELECT t.*, t2.OS_SLUCH_REGION
SELECT izslid, slid, D3_PID
INTO ztemp_03062019_1_21delposdet1
FROM (
SELECT dz.ID izslid, ds.ID slid, pa.ID D3_PID,  pa.FAM, pa.IM, pa.OT, pa.DR, ds.DATE_1, ds.DATE_2, ds.PROFIL, dz.ZSL_ID
FROM D3_ZSL_OMS AS dz
JOIN D3_SL_OMS AS ds ON dz.ID = ds.D3_ZSLID
JOIN D3_PACIENT_OMS pa on dz.D3_PID = pa.ID
WHERE dz.D3_SCID = @p1 AND dz.OS_SLUCH_REGION IS NULL --AND ds.P_CEL25 = '2.1'
) AS t
INNER JOIN (
SELECT dz.ID, pa.FAM, pa.IM, pa.OT, pa.DR, cast(u.DATE_IN AS date) DATE_1, cast(u.DATE_OUT AS DATE) DATE_2, u.PROFIL, dz.OS_SLUCH_REGION
FROM D3_ZSL_OMS AS dz
join D3_SCHET_OMS s on dz.D3_SCID = s.ID
JOIN D3_SL_OMS AS ds ON dz.ID = ds.D3_ZSLID
JOIN D3_PACIENT_OMS pa on dz.D3_PID = pa.ID
JOIN D3_USL_OMS AS u ON u.D3_SLID = ds.ID
WHERE s.YEAR = 2022 AND dz.OS_SLUCH_REGION IS NOT NULL) AS t2 
ON t2.FAM = t.FAM AND t2.IM = t.IM AND t2.OT = t.OT AND t2.DR = t.DR AND cast(t.DATE_1 as date) = cast(t2.DATE_1 as date) AND t.izslid <> t2.ID AND t.PROFIL = t2.PROFIL
ORDER BY t2.ID


DELETE FROM D3_SL_OMS
WHERE ID IN (SELECT slid FROM ztemp_03062019_1_21delposdet1)

DELETE FROM D3_ZSL_OMS
WHERE ID IN (SELECT izslid FROM ztemp_03062019_1_21delposdet1)

DELETE FROM D3_PACIENT_OMS
WHERE ID IN (SELECT D3_PID FROM ztemp_03062019_1_21delposdet1)


--UPDATE dz SET dz.D3_SCID = 2139, dz.EXP_COMENT = 'Перекрест случай с услугой'
--FROM D3_ZSL_OMS dz 
--WHERE id IN (
--SELECT id
--FROM ztemp_011042019_1_21delposdet)