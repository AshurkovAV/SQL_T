BEGIN TRAN
BEGIN TRY
DECLARE @ErrorMessage NVARCHAR(4000)
		DECLARE @ErrorSeverity INT
		DECLARE @ErrorState INT
		
EXEC [dbo].[versionÑheck] 653

ALTER TABLE F014 ALTER COLUMN kod NVARCHAR(10)
UPDATE f SET f.Kod = f.Kod + '_old'
FROM f014 f
WHERE kod IN (
SELECT f.Kod
FROM F014 f
GROUP BY f.Kod
HAVING COUNT(kod) > 1)
AND DATEEND IS NOT NULL

UPDATE f SET f.Osn = f.Osn + '_old'
FROM f014 f
WHERE Osn IN (
SELECT f.Osn
FROM F014 f
GROUP BY f.Osn
HAVING COUNT(Osn) > 1)
AND DATEEND IS NOT NULL

EXEC [dbo].[versionUpdate] 654
COMMIT TRAN;		
END TRY
		BEGIN CATCH			
			SET @ErrorMessage= ERROR_MESSAGE()
			SET @ErrorSeverity= ERROR_SEVERITY()
			SET @ErrorState= ERROR_STATE()
			RAISERROR (@ErrorMessage,@ErrorSeverity,@ErrorState)
			IF (@@trancount > 0) ROLLBACK TRAN						
		END CATCH
IF (@@trancount > 0) ROLLBACK TRAN;



