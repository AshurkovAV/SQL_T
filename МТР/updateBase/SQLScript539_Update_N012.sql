BEGIN TRAN
BEGIN TRY
DECLARE @ErrorMessage NVARCHAR(4000)
		DECLARE @ErrorSeverity INT
		DECLARE @ErrorState INT
		
EXEC [dbo].[version—heck] 538	
--DECLARE @NsiAct-------------------------------------------------------------------------------------------
	declare @NsiAct table 
			(
				ID_I_D numeric(2,0),DS_Igh nvarchar(3),ID_Igh numeric(2,0),DATEBEG date,DATEEND date
			)

insert into @NsiAct (ID_I_D,DS_Igh,ID_Igh,DATEBEG,DATEEND) values ('1','C16','1','20180901',NULL)
insert into @NsiAct (ID_I_D,DS_Igh,ID_Igh,DATEBEG,DATEEND) values ('2','C43','2','20180901',NULL)
insert into @NsiAct (ID_I_D,DS_Igh,ID_Igh,DATEBEG,DATEEND) values ('3','C43','3','20180901',NULL)
insert into @NsiAct (ID_I_D,DS_Igh,ID_Igh,DATEBEG,DATEEND) values ('4','C18','4','20180901',NULL)
insert into @NsiAct (ID_I_D,DS_Igh,ID_Igh,DATEBEG,DATEEND) values ('5','C19','4','20180901',NULL)
insert into @NsiAct (ID_I_D,DS_Igh,ID_Igh,DATEBEG,DATEEND) values ('6','C20','4','20180901',NULL)
insert into @NsiAct (ID_I_D,DS_Igh,ID_Igh,DATEBEG,DATEEND) values ('7','C34','5','20180901',NULL)
insert into @NsiAct (ID_I_D,DS_Igh,ID_Igh,DATEBEG,DATEEND) values ('8','C34','6','20180901',NULL)
insert into @NsiAct (ID_I_D,DS_Igh,ID_Igh,DATEBEG,DATEEND) values ('9','C34','7','20180901',NULL)
insert into @NsiAct (ID_I_D,DS_Igh,ID_Igh,DATEBEG,DATEEND) values ('10','C50','8','20180901',NULL)
insert into @NsiAct (ID_I_D,DS_Igh,ID_Igh,DATEBEG,DATEEND) values ('11','C50','9','20180901',NULL)
insert into @NsiAct (ID_I_D,DS_Igh,ID_Igh,DATEBEG,DATEEND) values ('12','C50','10','20180901',NULL)
insert into @NsiAct (ID_I_D,DS_Igh,ID_Igh,DATEBEG,DATEEND) values ('13','C50','11','20180901',NULL)
insert into @NsiAct (ID_I_D,DS_Igh,ID_Igh,DATEBEG,DATEEND) values ('14','C50','12','20180901',NULL)
insert into @NsiAct (ID_I_D,DS_Igh,ID_Igh,DATEBEG,DATEEND) values ('15','C18','2','20180901',NULL)
insert into @NsiAct (ID_I_D,DS_Igh,ID_Igh,DATEBEG,DATEEND) values ('16','C19','2','20180901',NULL)
insert into @NsiAct (ID_I_D,DS_Igh,ID_Igh,DATEBEG,DATEEND) values ('17','C20','2','20180901',NULL)
--INSERT NEW INTO  NsiCur------------------------------------------------------------------------------------------------------------
	insert into N012 (ID_I_D,DS_Igh,ID_Igh,DATEBEG,DATEEND)
	select 
	NsiAct.ID_I_D,NsiAct.DS_Igh,NsiAct.ID_Igh,NsiAct.DATEBEG,NsiAct.DATEEND
	from @NsiAct NsiAct
		left join N012 NSiCur
			on NSiCur.ID_I_D=NsiAct.ID_I_D
	where 
		NSiCur.ID_I_D is null

--UPDATE NsiCur------------------------------------------------------------------------------------------------------------
	update NsiCur set
NsiCur.DATEBEG=NsiAct.DATEBEG,
NsiCur.DATEEND=NsiAct.DATEEND,
NsiCur.ID_I_D=NsiAct.ID_I_D,
NsiCur.ID_Igh=NsiAct.ID_Igh,
NsiCur.DS_Igh=NsiAct.DS_Igh
	from @NsiAct NsiAct
		inner join N012 NsiCur
						on NSiCur.ID_I_D=NsiAct.ID_I_D
	where
		isnull(NsiCur.DATEBEG,'19000101')<>isnull(NsiAct.DATEBEG,'19000101') or
isnull(NsiCur.DATEEND,'19000101')<>isnull(NsiAct.DATEEND,'19000101') or
isnull(NsiCur.ID_I_D,'0')<>isnull(NsiAct.ID_I_D,'0') or
isnull(NsiCur.ID_Igh,'0')<>isnull(NsiAct.ID_Igh,'0') or
isnull(NsiCur.DS_Igh,'')<>isnull(NsiAct.DS_Igh,'') 

EXEC [dbo].[versionUpdate] 539
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