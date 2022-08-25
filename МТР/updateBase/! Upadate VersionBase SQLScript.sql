If EXISTS(SELECT * FROM sysobjects WHERE id = object_id('Version'))
						DROP TABLE [dbo].[Version]

GO

CREATE TABLE [dbo].[Version](
	[id] [int] NULL
) ON [PRIMARY]

GO

INSERT INTO Version (id) VALUES(549)