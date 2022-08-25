BEGIN TRAN
BEGIN TRY
DECLARE @ErrorMessage NVARCHAR(4000)
		DECLARE @ErrorSeverity INT
		DECLARE @ErrorState INT
		
EXEC [dbo].[versionСheck] 540
--DECLARE @NsiAct-------------------------------------------------------------------------------------------
	declare @NsiAct table 
			(
				ID_THir numeric(1,0),THir_NAME nvarchar(250),DATEBEG date,DATEEND date
			)

insert into @NsiAct (ID_THir,THir_NAME,DATEBEG,DATEEND) values ('1','Первичной опухоли, в том числе с удалением регионарных лимфатических узлов','20180901',NULL)
insert into @NsiAct (ID_THir,THir_NAME,DATEBEG,DATEEND) values ('2','Метастазов','20180901',NULL)
insert into @NsiAct (ID_THir,THir_NAME,DATEBEG,DATEEND) values ('3','Симптоматическое, реконструктивно-пластическое, хирургическая овариальная суперссия, прочее','20180901',NULL)
insert into @NsiAct (ID_THir,THir_NAME,DATEBEG,DATEEND) values ('4','Выполнено хирургическое стадирование (может указываться при раке яичника вместо "1")','20180901',NULL)
insert into @NsiAct (ID_THir,THir_NAME,DATEBEG,DATEEND) values ('5','Регионарных лимфатических узлов без первичной опухоли','20180901',NULL)
insert into @NsiAct (ID_THir,THir_NAME,DATEBEG,DATEEND) values ('6','Криохирургия/криотерапия, лазерная деструкция, фотодинамическая терапия','20180901',NULL)
--INSERT NEW INTO  NsiCur------------------------------------------------------------------------------------------------------------
	insert into N014 (ID_THir,THir_NAME,DATEBEG,DATEEND)
	select 
	NsiAct.ID_THir,NsiAct.THir_NAME,NsiAct.DATEBEG,NsiAct.DATEEND
	from @NsiAct NsiAct
		left join N014 NSiCur
			on NSiCur.ID_THir=NsiAct.ID_THir
	where 
		NSiCur.ID_THir is null

--UPDATE NsiCur------------------------------------------------------------------------------------------------------------
	update NsiCur set
NsiCur.DATEBEG=NsiAct.DATEBEG,
NsiCur.DATEEND=NsiAct.DATEEND,
NsiCur.ID_THir=NsiAct.ID_THir,
NsiCur.THir_NAME=NsiAct.THir_NAME
	from @NsiAct NsiAct
		inner join N014 NsiCur
						on NSiCur.ID_THir=NsiAct.ID_THir
	where
		isnull(NsiCur.DATEBEG,'19000101')<>isnull(NsiAct.DATEBEG,'19000101') or
isnull(NsiCur.DATEEND,'19000101')<>isnull(NsiAct.DATEEND,'19000101') or
isnull(NsiCur.ID_THir,'0')<>isnull(NsiAct.ID_THir,'0') or
isnull(NsiCur.THir_NAME,'')<>isnull(NsiAct.THir_NAME,'') 

EXEC [dbo].[versionUpdate] 541
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

