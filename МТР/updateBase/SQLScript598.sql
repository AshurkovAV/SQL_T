BEGIN TRAN
BEGIN TRY
DECLARE @ErrorMessage NVARCHAR(4000)
		DECLARE @ErrorSeverity INT
		DECLARE @ErrorState INT
		
EXEC [dbo].[version�heck] 597

ALTER TABLE F006 ALTER COLUMN VIDNAME nvarchar(350) NOT NULL
ALTER TABLE F006 ALTER COLUMN IDVID INT NOT NULL
ALTER TABLE F006 ALTER COLUMN DATEBEG datetime NOT NULL

--ALTER TABLE [ZFactSank] DROP CONSTRAINT [FK_ZFactSank_F006]

--ALTER TABLE F006 
--DROP CONSTRAINT [PK_F006] 
--ALTER TABLE F006 
--ADD CONSTRAINT [PK_F006] PRIMARY KEY (
--	ID ASC)
	
--ALTER TABLE [dbo].[ZFactSank]  WITH NOCHECK ADD  CONSTRAINT [FK_ZFactSank_F006] FOREIGN KEY([Type])
--REFERENCES [dbo].[F006] (ID)
--ALTER TABLE [dbo].[ZFactSank] CHECK CONSTRAINT [FK_ZFactSank_F006]

--DECLARE @NsiAct-------------------------------------------------------------------------------------------
	declare @NsiAct table 
			(
				IDVID numeric(2,0),VIDNAME nvarchar(350),DATEBEG datetime,DATEEND datetime
			)

insert into @NsiAct (IDVID,VIDNAME,DATEBEG,DATEEND) values ('1','��� (������-������������� ��������)','20110101',NULL)
insert into @NsiAct (IDVID,VIDNAME,DATEBEG,DATEEND) values ('2','��� (������-������������� ����������)','20110101','20180331')
insert into @NsiAct (IDVID,VIDNAME,DATEBEG,DATEEND) values ('3','���� (���������� �������� ����������� ������)','20110101','20180331')
insert into @NsiAct (IDVID,VIDNAME,DATEBEG,DATEEND) values ('10','��������� ������-������������� �������� � �������� �������','20180401',NULL)
insert into @NsiAct (IDVID,VIDNAME,DATEBEG,DATEEND) values ('11','��������� ������-������������� �������� �� ���������� ��','20180401',NULL)
insert into @NsiAct (IDVID,VIDNAME,DATEBEG,DATEEND) values ('12','��������� ������-������������� �������� �� ������ ��������','20180401',NULL)
insert into @NsiAct (IDVID,VIDNAME,DATEBEG,DATEEND) values ('20','�������� ������������ ������-������������� ����������','20180401',NULL)
insert into @NsiAct (IDVID,VIDNAME,DATEBEG,DATEEND) values ('21','�������� ������-������������� ���������� (��������� �������)','20180401',NULL)
insert into @NsiAct (IDVID,VIDNAME,DATEBEG,DATEEND) values ('22','������� ������-������������� ���������� �� ������ ��������� ���������� �� ������ ������ � ���� �� ����������� � ������� �������� ���� - ��� �������� ����������� ������ �����������, �����������; � ������� �������� ������� ����� �� ������� ��������������� ������ - ��� ��������� ������ ������ ����������� ������','20180401',NULL)
insert into @NsiAct (IDVID,VIDNAME,DATEBEG,DATEEND) values ('23','������� ������-������������� ���������� �� ������ �� ��������������� ���� ��� ��� ������������� �� ����������� ����������� ������ � ����������� �����������','20180401',NULL)
insert into @NsiAct (IDVID,VIDNAME,DATEBEG,DATEEND) values ('24','��������� ������-������������� ���������� � �������� �������','20180401','20190731')
insert into @NsiAct (IDVID,VIDNAME,DATEBEG,DATEEND) values ('25','��������� ������-������������� ���������� �� ��������� ��','20180401',NULL)
insert into @NsiAct (IDVID,VIDNAME,DATEBEG,DATEEND) values ('26','��������� ������-������������� ���������� �� ������ ��������','20180401',NULL)
insert into @NsiAct (IDVID,VIDNAME,DATEBEG,DATEEND) values ('27','������� ������-������������� ���������� �������� ����������� ������ �� ������� "���������" � ����������� ����������������� �������','20190801',NULL)
insert into @NsiAct (IDVID,VIDNAME,DATEBEG,DATEEND) values ('28','������� ��� �� ������� ��������������� ���������� �� ������������ ���������� (�����-��) �������������� ���, ������� ������� ����������� ��������, ��� ������� ������������� ��, � ����� �� ������� ������������ ������������� �������� �������, ������������� �������� � �������������� ���������� �� � �������� ���������� � ��� ������������','20190801',NULL)
insert into @NsiAct (IDVID,VIDNAME,DATEBEG,DATEEND) values ('29','������� ������-������������� ���������� �������������� ��������������� ����, ����������� ������ �������� ������ ���� ������� � �������� ����� � ���������� (����������� ������������� ����������) ������� ������� � ������������ � ��������� �������� ����������� ������','20190801',NULL)
insert into @NsiAct (IDVID,VIDNAME,DATEBEG,DATEEND) values ('30','������������ ���������� �������� ����������� ������','20180401',NULL)
insert into @NsiAct (IDVID,VIDNAME,DATEBEG,DATEEND) values ('31','�������� ���������� �������� ����������� ������ (��������� �������)','20180401',NULL)
insert into @NsiAct (IDVID,VIDNAME,DATEBEG,DATEEND) values ('32','������� ���������� �������� ����������� ������ �� ������ �� ��������������� ���� ��� ��� ������������� �� ����������� � �������� ����������� ������ � ����������� �����������','20180401',NULL)
insert into @NsiAct (IDVID,VIDNAME,DATEBEG,DATEEND) values ('33','������� ���������� �������� ����������� ������ �� ������� � ��������� �������','20180401',NULL)
insert into @NsiAct (IDVID,VIDNAME,DATEBEG,DATEEND) values ('34','������� ���������� �������� ����������� ������ �� ������� ����������������� ������������� � ���������� �����������','20180401',NULL)
insert into @NsiAct (IDVID,VIDNAME,DATEBEG,DATEEND) values ('35','������� ���������� �������� ����������� ������ �� ������� ���������� ������ �� ������������ ��� ��������������� �������� � �����','20180401',NULL)
insert into @NsiAct (IDVID,VIDNAME,DATEBEG,DATEEND) values ('36','������� ���������� �������� ����������� ������ �� ������ ���������� ������������� ��������� �� ������ ������ � ���� �� ����������� (� ������� �������� ���� - ��� �������� ����������� ������ �����������, �����������; � ������� �������� ������� ����� �� ������� ��������������� ������ - ��� ��������� ������ ������ ����������� ������)','20180401',NULL)
insert into @NsiAct (IDVID,VIDNAME,DATEBEG,DATEEND) values ('37','������� ���������� �������� ����������� ������ �� ������� ���������� �� ����������� ������� ������-������������� ����������','20180401',NULL)
insert into @NsiAct (IDVID,VIDNAME,DATEBEG,DATEEND) values ('38','����� ���������� �������� ����������� ������','20180401',NULL)
insert into @NsiAct (IDVID,VIDNAME,DATEBEG,DATEEND) values ('39','��������� ���������� �������� ����������� ������ � �������� �������','20180401','20190731')
insert into @NsiAct (IDVID,VIDNAME,DATEBEG,DATEEND) values ('40','��������� ���������� �������� ����������� ������ �� ��������� ��','20180401',NULL)
insert into @NsiAct (IDVID,VIDNAME,DATEBEG,DATEEND) values ('41','��������� ���������� �������� ����������� ������ �� ������ ��������','20180401',NULL)
insert into @NsiAct (IDVID,VIDNAME,DATEBEG,DATEEND) values ('42','������� ���������� �������� ����������� ������ �� ������� ��������� �� ����������� ������� � ������������ ������-������������� ���������� ��������� ��� �������� ����������� ������ �� ������� "���������".','20190801',NULL)
insert into @NsiAct (IDVID,VIDNAME,DATEBEG,DATEEND) values ('43','�������������������� ������������ ���������� �������� ����������� ������ ��� ������������, ���������� ��������� ��������� ���������� ��������� �� ���������� �������� ���������� ��������� (�� ��������� ���������������� ����� ������������� ������������ �����������)','20190801',NULL)
insert into @NsiAct (IDVID,VIDNAME,DATEBEG,DATEEND) values ('44','�������������������� ������������ ���������� �������� ����������� ��� ������������, ���������� ��������� ��������� ���������� ��������� � ���������� ��������� (�� ��������� ������������ ����� ������������� ������������ �����������)','20190801',NULL)
insert into @NsiAct (IDVID,VIDNAME,DATEBEG,DATEEND) values ('45','�������������������� ������������ ���� �� �������, ���������� �� ����������� ���, ����, ���� ��������� ���������� �� ��������� ������� ���������� � ������������ ��������� ����������� ������ �������� �������� ����������� ������, ����������� �������������, ���������� ����������� ������, � ��� ����� ��� �������� �������� � ������ ��������� ����������','20190801',NULL)
insert into @NsiAct (IDVID,VIDNAME,DATEBEG,DATEEND) values ('46','�������������������� ������������ ���� ��� ������������� �������� ������� ���������� ����� ���������� ��������� ��� �������� ����������� ������ ������ ����� ������� �� ��� ��������� ���������� �������������������� �������� ���������� �������� ����������� ������','20190801',NULL)
insert into @NsiAct (IDVID,VIDNAME,DATEBEG,DATEEND) values ('47','�������������������� ������� ���������� �������� ����������� ������ �� ������ ������ �� ��������������� ���� ��� ��� ������������� �� ����������� � �������� ����������� ������, ��������� ������������� ������ �������� �/��� �� ������ ������� �������� ����������� ������','20190801',NULL)
insert into @NsiAct (IDVID,VIDNAME,DATEBEG,DATEEND) values ('48','�������������������� ������� ���������� �������� ����������� ������ �� ������� ��������� ������� � ������ ��������� �� ���-10: I20.0, I21-I24, I60-I63, G45-G46, J12-J18, C50, C61','20190801',NULL)
insert into @NsiAct (IDVID,VIDNAME,DATEBEG,DATEEND) values ('49','�������������������� ������� ���������� �������� ����������� ������ �� ������� ���������� ������ �� ������������ ��� ��������������� �������� � �����','20190801',NULL)
--INSERT NEW INTO  NsiCur------------------------------------------------------------------------------------------------------------
	insert into F006 (id, IDVID,VIDNAME,DATEBEG,DATEEND)
	select 
	NsiAct.IDVID, NsiAct.IDVID,NsiAct.VIDNAME,NsiAct.DATEBEG,NsiAct.DATEEND
	from @NsiAct NsiAct
		left join F006 NSiCur
			on NSiCur.DATEBEG=NsiAct.DATEBEG
 and NSiCur.IDVID=NsiAct.IDVID

	where 
		NSiCur.IDVID is null

--UPDATE NsiCur------------------------------------------------------------------------------------------------------------
	update NsiCur set
NsiCur.DATEBEG=NsiAct.DATEBEG,
NsiCur.DATEEND=NsiAct.DATEEND,
NsiCur.IDVID=NsiAct.IDVID,
NsiCur.VIDNAME=NsiAct.VIDNAME
	from @NsiAct NsiAct
		inner join F006 NsiCur
						on NSiCur.DATEBEG=NsiAct.DATEBEG
 and NSiCur.IDVID=NsiAct.IDVID

	where
		isnull(NsiCur.DATEBEG,'19000101')<>isnull(NsiAct.DATEBEG,'19000101') or
isnull(NsiCur.DATEEND,'19000101')<>isnull(NsiAct.DATEEND,'19000101') or
isnull(NsiCur.IDVID,'0')<>isnull(NsiAct.IDVID,'0') or
isnull(NsiCur.VIDNAME,'')<>isnull(NsiAct.VIDNAME,'') 


UPDATE F006 SET DATEBEG = '20190801' WHERE IDVID IN (20,27,36)

EXEC [dbo].[versionUpdate] 598
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