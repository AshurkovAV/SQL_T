USE [master]
GO

/****** Object:  LinkedServer [SQL_YAMED]    Script Date: 31.07.2018 13:05:23 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'SQL_YAMED', @srvproduct=N'sql', @provider=N'SQLNCLI', @datasrc=N'91.240.209.108,2866'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'SQL_YAMED',@useself=N'False',@locallogin=NULL,@rmtuser=N'sa',@rmtpassword='########'

GO

EXEC master.dbo.sp_serveroption @server=N'SQL_YAMED', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'SQL_YAMED', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'SQL_YAMED', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'SQL_YAMED', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'SQL_YAMED', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'SQL_YAMED', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'SQL_YAMED', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'SQL_YAMED', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'SQL_YAMED', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'SQL_YAMED', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'SQL_YAMED', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'SQL_YAMED', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'SQL_YAMED', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO


