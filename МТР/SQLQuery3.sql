DECLARE @localSettings TABLE(
	[SettingsID] [int] NOT NULL,
	[Key] [nvarchar](200) NULL,
	[Value] [nvarchar](max) NULL,
	[Metadata] [nvarchar](max) NULL)
	
INSERT @localSettings ([SettingsID], [Key], [Value], [Metadata]) VALUES (1, N'DefaultOmsVersion', N'{"version":5}', N'{
                        "Id" : "DefaultOmsVersion",
                        "Title" : "Версия формата OMS по умолчанию",
                        "Descriptions" : [
                            {
                                "Id" : "version",
                                "DisplayName" : "Версия",
                                "DefaultValue" : 5,
                                "Typo" : "int",
                                "DisplayCategory" : "Основные настройки"
                            }
                        ] 
                    }')

UPDATE ls SET [Value] = lsn.[Value], Metadata = lsn.Metadata
FROM localSettings AS ls
JOIN @localSettings lsn ON lsn.SettingsID = ls.SettingsID 