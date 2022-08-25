BEGIN TRAN
BEGIN TRY
DECLARE @ErrorMessage NVARCHAR(4000)
		DECLARE @ErrorSeverity INT
		DECLARE @ErrorState INT
		
EXEC [dbo].[version�heck] 539	
--DECLARE @NsiAct-------------------------------------------------------------------------------------------
	declare @NsiAct table 
			(
				ID_TLech numeric(1,0),TLech_NAME nvarchar(250),DATEBEG date,DATEEND date
			)

insert into @NsiAct (ID_TLech,TLech_NAME,DATEBEG,DATEEND) values ('1','������������� �������','20180901',NULL)
insert into @NsiAct (ID_TLech,TLech_NAME,DATEBEG,DATEEND) values ('2','������������� ����������������� �������','20180901',NULL)
insert into @NsiAct (ID_TLech,TLech_NAME,DATEBEG,DATEEND) values ('3','������� �������','20180901',NULL)
insert into @NsiAct (ID_TLech,TLech_NAME,DATEBEG,DATEEND) values ('4','������������ �������','20180901',NULL)
insert into @NsiAct (ID_TLech,TLech_NAME,DATEBEG,DATEEND) values ('5','��������������� ������� (���������� ����������������� �������, ���������/������ ���� ������� (��������), ������)','20180901',NULL)
insert into @NsiAct (ID_TLech,TLech_NAME,DATEBEG,DATEEND) values ('6','�����������','20180901',NULL)
--INSERT NEW INTO  NsiCur------------------------------------------------------------------------------------------------------------
	insert into N013 (ID_TLech,TLech_NAME,DATEBEG,DATEEND)
	select 
	NsiAct.ID_TLech,NsiAct.TLech_NAME,NsiAct.DATEBEG,NsiAct.DATEEND
	from @NsiAct NsiAct
		left join N013 NSiCur
			on NSiCur.ID_TLech=NsiAct.ID_TLech
	where 
		NSiCur.ID_TLech is null

--UPDATE NsiCur------------------------------------------------------------------------------------------------------------
	update NsiCur set
NsiCur.DATEBEG=NsiAct.DATEBEG,
NsiCur.DATEEND=NsiAct.DATEEND,
NsiCur.ID_TLech=NsiAct.ID_TLech,
NsiCur.TLech_NAME=NsiAct.TLech_NAME
	from @NsiAct NsiAct
		inner join N013 NsiCur
						on NSiCur.ID_TLech=NsiAct.ID_TLech
	where
		isnull(NsiCur.DATEBEG,'19000101')<>isnull(NsiAct.DATEBEG,'19000101') or
isnull(NsiCur.DATEEND,'19000101')<>isnull(NsiAct.DATEEND,'19000101') or
isnull(NsiCur.ID_TLech,'0')<>isnull(NsiAct.ID_TLech,'0') or
isnull(NsiCur.TLech_NAME,'')<>isnull(NsiAct.TLech_NAME,'') 

EXEC [dbo].[versionUpdate] 540
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