DECLARE @sqltab TABLE ( sqlscript [nvarchar](max))

DECLARE @Code [nvarchar](20),
	@Weight [int] ,
	@Reason [int] ,
	@PG [nvarchar](100) ,
	@Type [int] ,
	@IsEnable [bit] ,
	@DateBegin [datetime] ,
	@DateEnd [datetime] ,
	@Scope [int] ,
	@Query [nvarchar](max) ,
	@Description [nvarchar](254) ,
	@Comments [nvarchar](254) ,
	@Name [nvarchar](100) ,
	@IsAuto [bit] ,
	@PenaltyPercent [money] ,
	@ErrorScope [int] ,
	@RefusalPercent [money] ,
	--@FactExpertCriterionID [int] IDENTITY(1,1) ,
	@Version [int] ,
	@Group [int],
	@FedCode NVARCHAR(25),
	@OidCode NVARCHAR(36),
	@VidId [int]

DECLARE vendor_cursor CURSOR FOR 


	SELECT  [Code],[Weight],[Reason],[PG],[Type],[IsEnable],[DateBegin],[DateEnd],[Scope],[Query],[Description],[Comments],[Name],[IsAuto],[PenaltyPercent]
      ,[ErrorScope],[RefusalPercent],[Version],[Group], FedCode, OidCode, VidId 
    FROM FactExpertCriterion AS fec
	WHERE
	fec.OidCode = 'D7A6BC97-E25F-4D24-B684-09199531CCE7' 
	--fec.Comments LIKE '003K.00.0501%' 
	--fec.Comments LIKE 'результат МП не соответствует условию оказания%'
	
OPEN vendor_cursor

FETCH NEXT FROM vendor_cursor INTO @Code,
	@Weight ,
	@Reason  ,
	@PG  ,
	@Type  ,
	@IsEnable ,
	@DateBegin ,
	@DateEnd ,
	@Scope ,
	@Query ,
	@Description ,
	@Comments ,
	@Name ,
	@IsAuto  ,
	@PenaltyPercent,
	@ErrorScope ,
	@RefusalPercent  ,	
	@Version,
	@Group,
	@FedCode,
	@OidCode,
	@VidId 

WHILE @@FETCH_STATUS = 0
BEGIN	
	
	DECLARE @sql NVARCHAR(MAX) 
	
	SET @sql = 'DECLARE @FactExpertCriterion TABLE(
	[Code] [nvarchar](20) NULL,
	[Weight] [int] NULL,
	[Reason] [int] NULL,
	[PG] [nvarchar](100) NULL,
	[Type] [int] NULL,
	[IsEnable] [bit] NULL,
	[DateBegin] [datetime] NULL,
	[DateEnd] [datetime] NULL,
	[Scope] [int] NULL,
	[Query] [nvarchar](max) NULL,
	[Description] [nvarchar](254) NULL,
	[Comments] [nvarchar](254) NULL,
	[Name] [nvarchar](100) NULL,
	[IsAuto] [bit] NULL,
	[PenaltyPercent] [money] NULL,
	[ErrorScope] [int] NULL,
	[RefusalPercent] [money] NULL,	
	[Version] [int] NULL,
	[Group] [int] NULL,
	FedCode NVARCHAR(25),
	OidCode NVARCHAR(36),
	VidId [int])
	
	INSERT @FactExpertCriterion ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group], FedCode, OidCode, VidId)
	
	VALUES (' + ''''+@Code+'''' + ',' 
	+ CAST( @Weight AS NVARCHAR(5)) + ','
	+  CAST( isnull(@Reason, 0) AS NVARCHAR(5)) + ','
	+ ''''+@PG+''''  + ','
	+ CAST( @Type AS NVARCHAR(5)) + ','
	+ CAST( @IsEnable AS NVARCHAR(5)) + ','
	+ ''''+ CONVERT(NVARCHAR(10), @DateBegin, 104 )+'''' + ','
	+  'NULL' + ','
	+ CAST( @Scope AS NVARCHAR(5)) + ','
	+ ''''+@Query+''''  + ','
	+ ''''+@Description+''''  + ','
	+ ''''+@Comments+''''  + ','
	+ ''''+@Name+''''  + ','
	+ CAST( @IsAuto AS NVARCHAR(5)) + ','
	+ CAST( @PenaltyPercent AS NVARCHAR(115)) + ','
	+ CAST( @ErrorScope AS NVARCHAR(5)) + ','
	+ CAST( @RefusalPercent AS NVARCHAR(115)) + ','
	+ CAST( @Version AS NVARCHAR(5)) + ','
	+ CAST( @Group AS NVARCHAR(5)) + ','
	+ ''''+@FedCode+''''  + ','
	+ ''''+@OidCode+''''  + ','
	+ CAST( @VidId AS NVARCHAR(5)) + ')' 
	+ '
	
	DELETE FROM FactExpertCriterion WHERE OidCode = ''D7A6BC97-E25F-4D24-B684-09199531CCE7'' --[Description] LIKE ''003K.00.0501%''
	
	IF NOT EXISTS(SELECT * FROM FactExpertCriterion WHERE OidCode = ''D7A6BC97-E25F-4D24-B684-09199531CCE7'')--[Description] LIKE ''003K.00.0501%'' ) 	
	BEGIN
	
	INSERT INTO FactExpertCriterion
	(
		Code,
		[Weight],
		Reason,
		PG,
		[Type],
		IsEnable,
		DateBegin,
		DateEnd,
		Scope,
		[Query],
		[Description],
		Comments,
		Name,
		IsAuto,
		PenaltyPercent,
		ErrorScope,
		RefusalPercent,		
		[Version],
		[Group],
		[FedCode],
		[OidCode],
		[VidId]
	)

	SELECT * from @FactExpertCriterion
	END'
	
	INSERT INTO @sqltab
	(
		sqlscript
	)
	VALUES
	(
		@sql
	) 
	
	
	FETCH NEXT FROM vendor_cursor INTO @Code,
	@Weight ,
	@Reason  ,
	@PG  ,
	@Type  ,
	@IsEnable ,
	@DateBegin ,
	@DateEnd ,
	@Scope ,
	@Query ,
	@Description ,
	@Comments ,
	@Name ,
	@IsAuto  ,
	@PenaltyPercent,
	@ErrorScope ,
	@RefusalPercent  ,	
	@Version,
	@Group,
	@FedCode,
	@OidCode,
	@VidId
END;
CLOSE vendor_cursor;
DEALLOCATE vendor_cursor;

SELECT *
FROM @sqltab



--003K.00.0211_Взаимное несоответствие исхода заболевания, результата обращения(При RSLT={102,
--003K.00.0211_Взаимное несоответствие исхода заболевания, результата обращения(RSLT={102, 103, 104, 105, 106, 109, 108,107, 110}	ISHOD <> 101)