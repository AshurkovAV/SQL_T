BEGIN TRAN
BEGIN TRY
DECLARE @ErrorMessage NVARCHAR(4000)
		DECLARE @ErrorSeverity INT
		DECLARE @ErrorState INT
		
EXEC [dbo].[versionСheck] 535	
--DECLARE @NsiAct-------------------------------------------------------------------------------------------
	declare @NsiAct table 
			(
				ID_PrOt numeric(1,0),PrOt_NAME nvarchar(250),DATEBEG date,DATEEND date
			)

insert into @NsiAct (ID_PrOt,PrOt_NAME,DATEBEG,DATEEND) values ('0','Отказ от проведения гистологического исследования','20180901',NULL)
insert into @NsiAct (ID_PrOt,PrOt_NAME,DATEBEG,DATEEND) values ('1','Противопоказания к проведению хирургического лечения','20180901',NULL)
insert into @NsiAct (ID_PrOt,PrOt_NAME,DATEBEG,DATEEND) values ('2','Противопоказания к проведению химиотерапевтического лечения','20180901',NULL)
insert into @NsiAct (ID_PrOt,PrOt_NAME,DATEBEG,DATEEND) values ('3','Противопоказания к проведению лучевой терапии','20180901',NULL)
insert into @NsiAct (ID_PrOt,PrOt_NAME,DATEBEG,DATEEND) values ('4','Отказ от проведения хирургического лечения','20180901',NULL)
insert into @NsiAct (ID_PrOt,PrOt_NAME,DATEBEG,DATEEND) values ('5','Отказ от проведения химиотерапевтического лечения','20180901',NULL)
insert into @NsiAct (ID_PrOt,PrOt_NAME,DATEBEG,DATEEND) values ('6','Отказ от проведения лучевой терапии','20180901',NULL)
insert into @NsiAct (ID_PrOt,PrOt_NAME,DATEBEG,DATEEND) values ('7','Гистологическое подтверждение диагноза не показано','20180901',NULL)
insert into @NsiAct (ID_PrOt,PrOt_NAME,DATEBEG,DATEEND) values ('8','Противопоказания к проведению гистологического исследования','20180901',NULL)
--INSERT NEW INTO  NsiCur------------------------------------------------------------------------------------------------------------
	insert into N001 (ID_PrOt,PrOt_NAME,DATEBEG,DATEEND)
	select 
	NsiAct.ID_PrOt,NsiAct.PrOt_NAME,NsiAct.DATEBEG,NsiAct.DATEEND
	from @NsiAct NsiAct
		left join N001 NSiCur
			on NSiCur.ID_PrOt=NsiAct.ID_PrOt
	where 
		NSiCur.ID_PrOt is null

--UPDATE NsiCur------------------------------------------------------------------------------------------------------------
	update NsiCur set
NsiCur.DATEBEG=NsiAct.DATEBEG,
NsiCur.DATEEND=NsiAct.DATEEND,
NsiCur.ID_PrOt=NsiAct.ID_PrOt,
NsiCur.PrOt_NAME=NsiAct.PrOt_NAME
	from @NsiAct NsiAct
		inner join N001 NsiCur
						on NSiCur.ID_PrOt=NsiAct.ID_PrOt
	where
		isnull(NsiCur.DATEBEG,'19000101')<>isnull(NsiAct.DATEBEG,'19000101') or
isnull(NsiCur.DATEEND,'19000101')<>isnull(NsiAct.DATEEND,'19000101') or
isnull(NsiCur.ID_PrOt,'0')<>isnull(NsiAct.ID_PrOt,'0') or
isnull(NsiCur.PrOt_NAME,'')<>isnull(NsiAct.PrOt_NAME,'') 

EXEC [dbo].[versionUpdate] 536
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