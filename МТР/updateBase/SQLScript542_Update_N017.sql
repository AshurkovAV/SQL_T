BEGIN TRAN
BEGIN TRY
DECLARE @ErrorMessage NVARCHAR(4000)
		DECLARE @ErrorSeverity INT
		DECLARE @ErrorState INT
		
EXEC [dbo].[versionСheck] 541
--DECLARE @NsiAct-------------------------------------------------------------------------------------------
	declare @NsiAct table 
			(
				ID_TLuch numeric(1,0),TLuch_NAME nvarchar(250),DATEBEG date,DATEEND date
			)

insert into @NsiAct (ID_TLuch,TLuch_NAME,DATEBEG,DATEEND) values ('1','Первичной опухоли / ложа опухоли','20180901',NULL)
insert into @NsiAct (ID_TLuch,TLuch_NAME,DATEBEG,DATEEND) values ('2','Метастазов','20180901',NULL)
insert into @NsiAct (ID_TLuch,TLuch_NAME,DATEBEG,DATEEND) values ('3','Симптоматическая','20180901','20181231')
--INSERT NEW INTO  NsiCur------------------------------------------------------------------------------------------------------------
	insert into N017 (ID_TLuch,TLuch_NAME,DATEBEG,DATEEND)
	select 
	NsiAct.ID_TLuch,NsiAct.TLuch_NAME,NsiAct.DATEBEG,NsiAct.DATEEND
	from @NsiAct NsiAct
		left join N017 NSiCur
			on NSiCur.ID_TLuch=NsiAct.ID_TLuch
	where 
		NSiCur.ID_TLuch is null

--UPDATE NsiCur------------------------------------------------------------------------------------------------------------
	update NsiCur set
NsiCur.DATEBEG=NsiAct.DATEBEG,
NsiCur.DATEEND=NsiAct.DATEEND,
NsiCur.ID_TLuch=NsiAct.ID_TLuch,
NsiCur.TLuch_NAME=NsiAct.TLuch_NAME
	from @NsiAct NsiAct
		inner join N017 NsiCur
						on NSiCur.ID_TLuch=NsiAct.ID_TLuch
	where
		isnull(NsiCur.DATEBEG,'19000101')<>isnull(NsiAct.DATEBEG,'19000101') or
isnull(NsiCur.DATEEND,'19000101')<>isnull(NsiAct.DATEEND,'19000101') or
isnull(NsiCur.ID_TLuch,'0')<>isnull(NsiAct.ID_TLuch,'0') or
isnull(NsiCur.TLuch_NAME,'')<>isnull(NsiAct.TLuch_NAME,'') 

EXEC [dbo].[versionUpdate] 542
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
