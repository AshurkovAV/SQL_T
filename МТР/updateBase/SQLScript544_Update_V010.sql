BEGIN TRAN
BEGIN TRY
DECLARE @ErrorMessage NVARCHAR(4000)
		DECLARE @ErrorSeverity INT
		DECLARE @ErrorState INT
		
EXEC [dbo].[version�heck] 543
--DECLARE @NsiAct-------------------------------------------------------------------------------------------
	declare @NsiAct table 
			(
				IDSP numeric(2,0),SPNAME nvarchar(254),DATEBEG datetime,DATEEND datetime
			)

insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('1','��������� � �����������','20110101','20140124')
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('2','����������� �������������','20110101','20181231')
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('3','������������������� �������','20110101','20181231')
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('4','�������-��������������� ���������','20110101','20181231')
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('5','�����-���� � �������������� ����������','20110101','20181231')
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('6','�����-���� � ������� ���������� ����������� ����������','20110101','20181231')
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('7','���� ������� � ������� ���������� ���','20110101','20181231')
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('8','���� ������� � ���������� �� ����','20110101','20181231')
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('9','��� � ������������','20110101','20181231')
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('10','�������� ����������� ������ � �����������','20110101','20181231')
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('11','�������������� ���������������','20110101','20181231')
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('12','����������� ������ ������ ��������','20110101','20181231')
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('13','�������� ����������� ������ � ���������� (������� ���)','20110101','20181231')
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('14','������� � ���������� ��������� ����������','20110101','20181231')
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('15','�������� ������ ����������� ������','20110101','20181231')
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('16','�������-��������������  ������','20110101','20140124')
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('17','����������� ������ � �����������','20111004','20181231')
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('18','����������� ������ � �������������� ����������','20111004','20140124')
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('19','����������� ������ � ������� ���������� ����������� ����������','20111004','20140124')
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('20','����������� ������ � ������� ���������� ���','20111004','20140124')
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('21','����������� ������ � ���������� �� ����','20111004','20181231')
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('22','���������','20111213','20140124')
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('23','��������� �� ����','20111213','20181231')
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('24','�� ����� ������ ����������� ������','20130101',NULL)
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('25','�� ���������� ��������� �������������� �� �������������� ��� � ��������� � ������� �� ������� ������ ����������� ������','20130101',NULL)
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('26','�� ���������� ��������� �������������� �� �������������� ��� � ��������� � ������� �� ���������','20130101','20181231')
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('27','�� ���������� ��������� �������������� �� �������������� ��� � ��������� � ������� �� ��������� (����������� ������)','20130101','20181231')
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('28','�� ����������� ������','20130101',NULL)
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('29','�� ���������','20130101',NULL)
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('30','�� ��������� (����������� ������)','20130101',NULL)
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('31','�� ���������� ��������� �������������� �� �������������� ��� � ������ ����������� ���������������� ������������ ����������� �����������','20130101',NULL)
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('32','�� ����������� ������ ������� �����������','20130101',NULL)
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('33','�� ����������� ������ ������� �����������, ����������� � ��������������� ������ ����������� (� ��� ����� �������-�������������� ������ �����������)','20130101',NULL)
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('34','�� ����������� ������ ������� ����������� ��� ������ ����������� ������, ��������� � ������� ����������','20130101','20181231')
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('35','�� ���������� ��������� �������������� ��� ������ ������ ����������� ������','20130101','20181231')
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('36','�� ���������� ��������� �������������� � ��������� � ������� �� ����� ������ ����������� ������','20130101',NULL)
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('37','�� ���������� ��������� �������������� �� �������������� ��� � ��������� � ������� �� ����������� ������ � ����� � ��������� ���������� ������','20130101','20181231')
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('38','�� ���������� ��������� �������������� �� �������������� ��� � ��������� � ������� �� ��������� � ����� � ��������� ���������� ������','20130101','20181231')
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('39','�� ���������� ��������� �������������� �� �������������� ��� � ��������� � ������� �� ��������� (����������� ������) � ����� � ��������� ���������� ������','20130101','20181231')
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('40','�� ����������� ������ � ����� � ��������� ���������� ������','20130101','20181231')
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('41','�� ��������� � ����� � ��������� ���������� ������','20130101','20181231')
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('42','�� ��������� (����������� ������) � ����� � ��������� ���������� ������','20130101','20181231')
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('43','�� ����������� ������ ������� �����������, ����������� � ��������������� ������ ����������� (� ��� ����� �������-�������������� ������ �����������) � ������� ����������','20140101','20181231')
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('44','�� ���������� ��������� �������������� �� �������������� � �� ���, ������� ������ ����������� ������ �� ���� ����� � �������� ��������������� �� ����������� ������, � ������ ����������� ���������������� ������������ ����������� �����������','20190101',NULL)
--INSERT NEW INTO  NsiCur------------------------------------------------------------------------------------------------------------
	insert into V010 (IDSP,SPNAME,DATEBEG,DATEEND,id)
	select 

	NsiAct.IDSP,NsiAct.SPNAME,NsiAct.DATEBEG,NsiAct.DATEEND
	,NsiAct.IDSP
	from @NsiAct NsiAct
		left join V010 NSiCur
			on NSiCur.IDSP=NsiAct.IDSP
	where 
		NSiCur.IDSP is null

--UPDATE NsiCur------------------------------------------------------------------------------------------------------------
	
	update NsiCur set
NsiCur.DATEBEG=NsiAct.DATEBEG,
NsiCur.DATEEND=NsiAct.DATEEND,
NsiCur.IDSP=NsiAct.IDSP,
NsiCur.SPNAME=NsiAct.SPNAME
	from @NsiAct NsiAct
		inner join V010 NsiCur
						on NSiCur.IDSP=NsiAct.IDSP
	where
		isnull(NsiCur.DATEBEG,'19000101')<>isnull(NsiAct.DATEBEG,'19000101') or
isnull(NsiCur.DATEEND,'19000101')<>isnull(NsiAct.DATEEND,'19000101') or
isnull(NsiCur.IDSP,'0')<>isnull(NsiAct.IDSP,'0') or
isnull(NsiCur.SPNAME,'')<>isnull(NsiAct.SPNAME,'') 

EXEC [dbo].[versionUpdate] 544
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