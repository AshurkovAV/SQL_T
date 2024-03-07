--UPDATE p 
--SET p.D3_SCID=902

--UPDATE zsl 
--SET zsl.D3_scid=902
--if OBJECT_ID('ztemp_protocol_07021') is not null drop table ztemp_protocol_07021
SELECT distinct zsl.id AS zslid,p.ID AS pid
INTO ztemp_protocol_122023
--,sch.id, zsl.id, p.fio, p.fam, p.ot, p.dr, p.NPOLIS, zsl.USL_OK,zsl.sumv, zsl.DATE_Z_1,f.date_ds,isnull(f.date_end,'20221231')
  FROM D3_SCHET_OMS AS SCH
JOIN D3_PACIENT_OMS AS p ON p.D3_SCID = SCH.ID
AND sch.[MONTH] = 12 AND sch.[YEAR] = 2023 AND sch.ID  IN  (17386,17389,17390)
JOIN D3_ZSL_OMS AS zsl ON zsl.D3_PID = p.ID
JOIN kt f ON f.fam = p.fam AND f.im = p.im AND f.ot = p.ot AND f.dr = p.dr
WHERE zsl.DATE_Z_1 >= f.date_ds and zsl.date_z_1<=isnull(f.date_end,'20221231')
--order by fio

/*
DECLARE @D3_SCID_old INT = 1290 --старый реестр где они сейчас
DECLARE @D3_SCID_new INT = 1282 --новый реестр куда нужно перенести

UPDATE dpo SET dpo.D3_SCID = @D3_SCID_new

--SELECT *
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dzo ON dzo.D3_PID = dpo.ID
JOIN ztemp_protokol11 z ON dpo.ID = z.pid 
--WHERE dzo.D3_SCID = @D3_SCID_old 

UPDATE dz SET dz.D3_SCID = @D3_SCID_new
--SELECT *
FROM D3_ZSL_OMS AS dz
JOIN ztemp_protokol11 z ON dz.ID = z.zid 
--WHERE dz.D3_SCID = @D3_SCID_old --AND dz.ID IN (SELECT id FROM @tab)
*/