BEGIN TRAN
BEGIN TRY
DECLARE @ErrorMessage NVARCHAR(4000)
		DECLARE @ErrorSeverity INT
		DECLARE @ErrorState INT
		 
EXEC [dbo].[versionСheck] 603


DECLARE @id INT;

select 
	@id =max(NSiCur.Id)
	from M001 NSiCur
			

--DECLARE @NsiAct-------------------------------------------------------------------------------------------
	declare @NsiAct table 
			( id INT,
	[IDDS] [nvarchar](10) NULL,
	[DSNAME] [nvarchar](254) NULL,
	[DATEBEG] [datetime] NULL,
	[DATEEND] [datetime] NULL,
	[Payable] [int] NULL
			)
			
			
insert into @NsiAct (id, [IDDS],[DSNAME],[DATEBEG],[DATEEND],[Payable]) values (@id + 1, 'U07','Коды для использования в чрезвычайных ситуациях (U07)','20200301',NULL,'1')
insert into @NsiAct (id, [IDDS],[DSNAME],[DATEBEG],[DATEEND],[Payable]) values (@id + 2, 'U07.1','Коронавирусная инфекция, вызванная вирусом COVID-19, вирус идентифицирован (подтвержден лабораторным тестированием независимо от тяжести клинических признаков или симптомов)','20200301',NULL,'1')
insert into @NsiAct (id, [IDDS],[DSNAME],[DATEBEG],[DATEEND],[Payable]) values (@id + 3, 'U07.2','Коронавирусная инфекция, вызванная вирусом COVID-19, вирус не идентифицирован (COVID-19 диагностируется клинически или эпидемиологически, но лабораторные исследования неубедительны или недоступны)','20200301',NULL,'1')
--INSERT NEW INTO  NsiCur------------------------------------------------------------------------------------------------------------
insert into M001 (id, [IDDS],[DSNAME],[DATEBEG],[DATEEND],[Payable])
	select 
	NsiAct.id, NsiAct.[IDDS],NsiAct.[DSNAME],NsiAct.[DATEBEG],NsiAct.[DATEEND],NsiAct.[Payable]
	from @NsiAct NsiAct
		left join M001 NSiCur
			on NSiCur.[IDDS]=NsiAct.[IDDS]

	WHERE NSiCur.[IDDS] is null


EXEC [dbo].[versionUpdate] 604
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

