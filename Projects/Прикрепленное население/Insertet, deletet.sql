ALTER TRIGGER [dbo].[TrigerUpdater]
ON [dbo].PACIENT
AFTER UPDATE 
AS 
IF ( UPDATE (FAM) )
BEGIN
	DECLARE @FAM NVARCHAR(40);
	DECLARE @IM NVARCHAR(40);
	
	DECLARE @FAMD NVARCHAR(40);
	DECLARE @IMD NVARCHAR(40);
	
	SELECT @FAM = i.FAM FROM inserted i;	
	SELECT @IM = i.IM FROM inserted i;
	SELECT @FAMD = i.FAM FROM deleted i;	
	SELECT @IMD = i.IM FROM deleted i;
	
		PRINT 'Inserted ' + @FAM + ' ' + @IM	
		PRINT 'Deleted ' + @FAMD + ' ' + @IMD 
	
END