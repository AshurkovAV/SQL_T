BEGIN TRAN
BEGIN TRY
DECLARE @ErrorMessage NVARCHAR(4000)
		DECLARE @ErrorSeverity INT
		DECLARE @ErrorState INT
		
EXEC [dbo].[versionСheck] 659

UPDATE ls set [Value] = REPLACE(ls.[Value], '}', ',"fileLoadTer":"D:\\","delXmlMo":false,"delOmsMo":false,"fileLoadMo":"D:\\"}'),
Metadata = '{"Id": "FileXmlOms","Title": "Работа с файлами xml, oms","Descriptions": [{"Id": "delXml","DisplayName": "Удаление xml файлов при загрузке счета(вх.счетов)","DefaultValue": "false","Typo": "bool","DisplayCategory": "Основные настройки для тер. счетов"},{"Id": "delOms","DisplayName": "Удаление oms файлов при загрузке счета(вх.счетов)","DefaultValue": "false","Typo": "bool","DisplayCategory": "Основные настройки для тер. счетов"},{"Id": "fileA","DisplayName": "Путь к месту выгрузки А файлов OMS","DefaultValue": "D:\\","Typo": "string","DisplayCategory": "Основные настройки для тер. счетов"},{"Id": "fileR","DisplayName": "Путь к месту выгрузки R файлов OMS","DefaultValue": "D:\\","Typo": "string","DisplayCategory": "Основные настройки для тер. счетов"},{"Id": "fileD","DisplayName": "Путь к месту выгрузки D файлов OMS","DefaultValue": "D:\\","Typo": "string","DisplayCategory": "Основные настройки для тер. счетов"},{"Id": "fileLoadTer","DisplayName": "Путь к месту загрузки тер. счетов","DefaultValue": "D:\\","Typo": "string","DisplayCategory": "Основные настройки для тер. счетов"},{"Id": "delXmlMo","DisplayName": "Удаление xml файлов при загрузке счетов MO","DefaultValue": "false","Typo": "bool","DisplayCategory": "Основные настройки для счетов МО"},{"Id": "delOmsMo","DisplayName": "Удаление oms файлов при загрузке счетов МО","DefaultValue": "false","Typo": "bool","DisplayCategory": "Основные настройки для счетов МО"},{"Id": "fileLoadMo","DisplayName": "Путь к месту загрузки счетов МО","DefaultValue": "D:\\","Typo": "string","DisplayCategory": "Основные настройки для счетов МО"}],"Methods":[]}'
FROM localSettings AS ls
WHERE ls.[Key] = 'FileXmlOms'

EXEC [dbo].[versionUpdate] 660
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


