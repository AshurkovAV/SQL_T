DECLARE @D3_SCID INT = 7047

if exists (select * from INFORMATION_SCHEMA.TABLES where TABLE_NAME = 'ztemp_301' AND TABLE_SCHEMA = 'dbo')
begin
	DROP TABLE ztemp_301
end
CREATE TABLE ztemp_301 (
	ZSLG_ID UNIQUEIDENTIFIER NOT NULL,
	zsl_id INT NOT NULL,
	sl_id INT NOT NULL,
	[NPOLIS] [nvarchar](20) NULL,
	[dr] [datetime] NULL,
	[ds1] [nvarchar](3) NULL,
	[PROFIL] [int] NULL,
	datez_1 DATETIME,
	datez_2 DATETIME)
	
DELETE FROM ztemp_301

INSERT INTO ztemp_301 (ZSLG_ID, zsl_id, sl_id, [NPOLIS],[dr],[ds1],[PROFIL], datez_1, datez_2)
SELECT ZSL_ID, zsl.id, sl.id, p.NPOLIS, dr, LEFT(ds1, 3)ds1, sl.PROFIL, zsl.DATE_Z_1, zsl.DATE_Z_2
FROM [D3_ZSL_OMS] zsl
JOIN [D3_SL_OMS] sl ON sl.d3_zslid = zsl.id
JOIN D3_pacient_OMS p ON d3_pid = p.id
WHERE zsl.id IN ( SELECT zsl.Id
					FROM[D3_ZSL_OMS] zsl
					JOIN [D3_SL_OMS] sl ON sl.d3_zslid = zsl.id AND sl.P_CEL25 IN('1.0', '1.3','2.1')
					JOIN D3_pacient_OMS p ON d3_pid = p.id
					WHERE zsl.D3_SCID = @D3_SCID AND OS_SLUCH_REGION IS NULL 
					AND sl.PROFIL IN (63,85,86,87,88,89,90) 
					AND sl.DS1 NOT LIKE 'Z%'
					AND IDSP IN (9, 29) 
					GROUP BY zsl.id
					HAVING COUNT(*) = 1)

UPDATE dso SET P_CEL25 = '3.0'
FROM D3_SL_OMS AS dso
JOIN ztemp_301 z ON dso.ID = z.sl_id