CREATE PROCEDURE [dbo].[versionСheck] @ver VARCHAR(10)
AS
BEGIN
DECLARE @str VARCHAR(250);

--SET @ver = '530';--ВЕРСИЯ БАЗЫ ДАННЫХ ДЛЯ КОТОРОЙ СДЕЛАНО ОБНОВЛЕНИЕ

SET @str = (SELECT * FROM version)
IF (@ver <> isnull(@str, ''))
BEGIN
  SET @str = 'Это обновление для версии базы данных ' + @ver + '(у Вас ' + @str  + ')'; 
  RAISERROR (@str, 16, 1);
END
END
--------------------------------------------------------------------------------

GO
CREATE PROCEDURE [dbo].[versionUpdate] @ver VARCHAR(10)
AS
BEGIN
IF EXISTS(SELECT * FROM sysobjects WHERE id = object_id('Version'))
						DROP TABLE [dbo].[Version]

CREATE TABLE [dbo].[Version](
	[id] [int] NULL
) ON [PRIMARY]

INSERT INTO Version (id) VALUES(@ver)
END
