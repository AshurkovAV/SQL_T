BEGIN TRAN
BEGIN TRY
DECLARE @ErrorMessage NVARCHAR(4000)
		DECLARE @ErrorSeverity INT
		DECLARE @ErrorState INT
		
EXEC [dbo].[version�heck] 542

--DECLARE @NsiAct-------------------------------------------------------------------------------------------
	declare @NsiAct table 
			(
				IDVMP numeric(4,0),VMPNAME nvarchar(254),DATEBEG date,DATEEND date
			)

insert into @NsiAct (IDVMP,VMPNAME,DATEBEG,DATEEND) values ('1','��������� ������-���������� ������','20110101',NULL)
insert into @NsiAct (IDVMP,VMPNAME,DATEBEG,DATEEND) values ('2','������, � ��� ����� ������������������, ����������� ������','20110101',NULL)
insert into @NsiAct (IDVMP,VMPNAME,DATEBEG,DATEEND) values ('3','������������������, � ��� ����� �������������������, ����������� ������','20110101',NULL)
insert into @NsiAct (IDVMP,VMPNAME,DATEBEG,DATEEND) values ('4','������������ ����������� ������','20130101',NULL)
insert into @NsiAct (IDVMP,VMPNAME,DATEBEG,DATEEND) values ('11','��������� ����������� ������-���������� ������','20130101',NULL)
insert into @NsiAct (IDVMP,VMPNAME,DATEBEG,DATEEND) values ('12','��������� ��������� ������-���������� ������','20130101',NULL)
insert into @NsiAct (IDVMP,VMPNAME,DATEBEG,DATEEND) values ('13','��������� ������������������ ������-���������� ������','20130101',NULL)
insert into @NsiAct (IDVMP,VMPNAME,DATEBEG,DATEEND) values ('14','��������� ������-���������� ������ � ����������� ��������������� ����������','20190101',NULL)
insert into @NsiAct (IDVMP,VMPNAME,DATEBEG,DATEEND) values ('21','������ ������������������ ����������� ������','20130101',NULL)
insert into @NsiAct (IDVMP,VMPNAME,DATEBEG,DATEEND) values ('22','���������-����������� ����������� ������','20130101',NULL)
insert into @NsiAct (IDVMP,VMPNAME,DATEBEG,DATEEND) values ('23','������, � ��� ����� ������������������, ����������� ������ � ����������� ��������������� ����������','20190101',NULL)
insert into @NsiAct (IDVMP,VMPNAME,DATEBEG,DATEEND) values ('31','������������������ ����������� ������','20130101',NULL)
insert into @NsiAct (IDVMP,VMPNAME,DATEBEG,DATEEND) values ('32','������������������� ������������������ ����������� ������','20130101',NULL)
insert into @NsiAct (IDVMP,VMPNAME,DATEBEG,DATEEND) values ('33','������������������, � ��� ����� �������������������, ����������� ������ � ����������� ��������������� ����������','20190101',NULL)
--INSERT NEW INTO  NsiCur------------------------------------------------------------------------------------------------------------
	insert into V008 (IDVMP,VMPNAME,DATEBEG,DATEEND,id)
	select 
	NsiAct.IDVMP,NsiAct.VMPNAME,NsiAct.DATEBEG,NsiAct.DATEEND
	,NsiAct.IDVMP
	from @NsiAct NsiAct
		left join V008 NSiCur
			on NSiCur.IDVMP=NsiAct.IDVMP
	where 
		NSiCur.IDVMP is null

--UPDATE NsiCur------------------------------------------------------------------------------------------------------------
	update NsiCur set
NsiCur.DATEBEG=NsiAct.DATEBEG,
NsiCur.DATEEND=NsiAct.DATEEND,
NsiCur.IDVMP=NsiAct.IDVMP,
NsiCur.VMPNAME=NsiAct.VMPNAME
	from @NsiAct NsiAct
		inner join V008 NsiCur
						on NSiCur.IDVMP=NsiAct.IDVMP
	where
		isnull(NsiCur.DATEBEG,'19000101')<>isnull(NsiAct.DATEBEG,'19000101') or
isnull(NsiCur.DATEEND,'19000101')<>isnull(NsiAct.DATEEND,'19000101') or
isnull(NsiCur.IDVMP,'0')<>isnull(NsiAct.IDVMP,'0') or
isnull(NsiCur.VMPNAME,'')<>isnull(NsiAct.VMPNAME,'') 

EXEC [dbo].[versionUpdate] 543
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