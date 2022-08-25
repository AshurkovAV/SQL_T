BEGIN TRAN
BEGIN TRY
DECLARE @ErrorMessage NVARCHAR(4000)
		DECLARE @ErrorSeverity INT
		DECLARE @ErrorState INT
		
EXEC [dbo].[version�heck] 659

UPDATE ls set [Value] = REPLACE(ls.[Value], '}', ',"fileLoadTer":"D:\\","delXmlMo":false,"delOmsMo":false,"fileLoadMo":"D:\\"}'),
Metadata = '{"Id": "FileXmlOms","Title": "������ � ������� xml, oms","Descriptions": [{"Id": "delXml","DisplayName": "�������� xml ������ ��� �������� �����(��.������)","DefaultValue": "false","Typo": "bool","DisplayCategory": "�������� ��������� ��� ���. ������"},{"Id": "delOms","DisplayName": "�������� oms ������ ��� �������� �����(��.������)","DefaultValue": "false","Typo": "bool","DisplayCategory": "�������� ��������� ��� ���. ������"},{"Id": "fileA","DisplayName": "���� � ����� �������� � ������ OMS","DefaultValue": "D:\\","Typo": "string","DisplayCategory": "�������� ��������� ��� ���. ������"},{"Id": "fileR","DisplayName": "���� � ����� �������� R ������ OMS","DefaultValue": "D:\\","Typo": "string","DisplayCategory": "�������� ��������� ��� ���. ������"},{"Id": "fileD","DisplayName": "���� � ����� �������� D ������ OMS","DefaultValue": "D:\\","Typo": "string","DisplayCategory": "�������� ��������� ��� ���. ������"},{"Id": "fileLoadTer","DisplayName": "���� � ����� �������� ���. ������","DefaultValue": "D:\\","Typo": "string","DisplayCategory": "�������� ��������� ��� ���. ������"},{"Id": "delXmlMo","DisplayName": "�������� xml ������ ��� �������� ������ MO","DefaultValue": "false","Typo": "bool","DisplayCategory": "�������� ��������� ��� ������ ��"},{"Id": "delOmsMo","DisplayName": "�������� oms ������ ��� �������� ������ ��","DefaultValue": "false","Typo": "bool","DisplayCategory": "�������� ��������� ��� ������ ��"},{"Id": "fileLoadMo","DisplayName": "���� � ����� �������� ������ ��","DefaultValue": "D:\\","Typo": "string","DisplayCategory": "�������� ��������� ��� ������ ��"}],"Methods":[]}'
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


