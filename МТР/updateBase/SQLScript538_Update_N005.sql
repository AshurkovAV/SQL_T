BEGIN TRAN
BEGIN TRY
DECLARE @ErrorMessage NVARCHAR(4000)
		DECLARE @ErrorSeverity INT
		DECLARE @ErrorState INT
		
EXEC [dbo].[versionСheck] 537	
--DECLARE @NsiAct-------------------------------------------------------------------------------------------
	declare @NsiAct table 
			(
				ID_M numeric(3,0),DS_M nvarchar(3),KOD_M nvarchar(5),M_NAME nvarchar(250),DATEBEG date,DATEEND date
			)

insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('1','C16','M0',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('2','C16','M1',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('3','C56','M0',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('4','C56','M1',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('5','C18','M0',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('6','C18','M1',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('7','C18','M1a',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('8','C18','M1b',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('9','C19','M0',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('10','C19','M1','Наличие отдаленных метастазов','20180901','20181231')
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('11','C19','M1a',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('12','C19','M1b',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('13','C22','Mx','Недостаточно данных для определения отдаленных метастазов','20180901','20181231')
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('14','C22','M0','Нет отдаленных метастазов','20180901','20181231')
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('15','C22','M1','Наличие отдаленных метастазов','20180901','20181231')
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('16','C25','M0',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('17','C25','M1',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('18','C43','M0',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('19','C43','M1','Наличие отдаленных метастазов','20180901','20181231')
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('20','C43','M1a',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('21','C43','M1b',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('22','C43','M1c',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('23','C44','M0',NULL,'20180901','20181231')
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('24','C44','M1',NULL,'20180901','20181231')
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('25','C53','M0',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('26','C53','M1',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('27','C54','M0',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('28','C54','M1',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('29','C61','Mx','Недостаточно данных для определения отдаленных метастазов','20180901','20181231')
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('30','C61','M0',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('31','C61','M1','Наличие отдаленных метастазов','20180901','20181231')
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('32','C61','M1a',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('33','C61','M1b',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('34','C61','M1c',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('35','C64','Mx','Недостаточно данных для определения отдаленных метастазов','20180901','20181231')
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('36','C64','M0',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('37','C64','M1',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('38','C67','M0',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('39','C67','M1',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('40','C73','M0',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('41','C73','M1',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('42','C20','M0',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('43','C20','M1',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('44','C20','M1a',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('45','C20','M1b',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('47','C15','M1',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('48','C34','Mx','Недостаточно данных для определения отдаленных метастазов','20180901','20181231')
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('49','C34','M0',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('50','C34','M1','Наличие отдаленных метастазов','20180901','20181231')
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('51','C34','M1a',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('52','C34','M1b',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('53','C32','Mx','Недостаточно данных для определения отдалённых метастазов','20180901','20181231')
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('54','C32','M0',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('55','C32','M1',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('56',NULL,'Mx',NULL,'20180901','20181231')
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('57',NULL,'M0',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('58',NULL,'M1',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('59','C97','Нет',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('60','C81','Нет',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('61','C82','Нет',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('62','C83','Нет',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('63','C84','Нет',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('64','C85','Нет',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('65','C86','Нет',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('66','C88','Нет',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('67','C90','Нет',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('68','C91','Нет',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('69','C92','Нет',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('70','C93','Нет',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('71','C94','Нет',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('72','C95','Нет',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('73','C96','Нет',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('74','C70','Нет',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('75','C71','Нет',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('76','C72','Нет',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('77','C69','Нет',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('78','C69','Нет',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('79','C69','Нет',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('80','C44','M0',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('81','C44','M1',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('82','C44','M0',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('83','C44','M1',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('84','C44','M0',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('85','C44','M1',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('86','C44','M0',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('87','C44','M1',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('88','C44','M0',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('89','C44','M1',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('90','C44','M0',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('91','C44','M1',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('92','C44','M0',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('93','C44','M1',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('94','C44','M0',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('95','C44','M1',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('96','C44','M0',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('97','C44','M1',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('98','D04','M0',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('99','D04','M0',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('100','D04','M0',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('101','D04','M0',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('102','D04','M0',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('103','D04','M0',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('104','D04','M0',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('105','D04','M0',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('106','D04','M0',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('107','D00','M0',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('108','D00','M0',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('109','D01','M0',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('110','D02','M0',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('111','D06','M0',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('112','D07','M0',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('113','D09','M0',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('114','D01','M0',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('115','D01','M0',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('116','D01','M0',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('117','D03','M0',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('118','D05','M0',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('119','C50','М0',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('120','C50','М1',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('121','C15','М0',NULL,'20180901',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('122','C80','Нет',NULL,'20181201',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('123','C22','M0',NULL,'20181201',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('124','C22','M1',NULL,'20181201',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('125','C64','Нет',NULL,'20181201',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('126','C56','M1a',NULL,'20181201',NULL)
insert into @NsiAct (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND) values ('127','C56','M1b',NULL,'20181201',NULL)
--INSERT NEW INTO  NsiCur------------------------------------------------------------------------------------------------------------
	insert into N005 (ID_M,DS_M,KOD_M,M_NAME,DATEBEG,DATEEND)
	select 
	NsiAct.ID_M,NsiAct.DS_M,NsiAct.KOD_M,NsiAct.M_NAME,NsiAct.DATEBEG,NsiAct.DATEEND
	from @NsiAct NsiAct
		left join N005 NSiCur
			on NSiCur.ID_M=NsiAct.ID_M
	where 
		NSiCur.ID_M is null

--UPDATE NsiCur------------------------------------------------------------------------------------------------------------
	update NsiCur set
NsiCur.DATEBEG=NsiAct.DATEBEG,
NsiCur.DATEEND=NsiAct.DATEEND,
NsiCur.ID_M=NsiAct.ID_M,
NsiCur.DS_M=NsiAct.DS_M,
NsiCur.KOD_M=NsiAct.KOD_M,
NsiCur.M_NAME=NsiAct.M_NAME
	from @NsiAct NsiAct
		inner join N005 NsiCur
						on NSiCur.ID_M=NsiAct.ID_M
	where
		isnull(NsiCur.DATEBEG,'19000101')<>isnull(NsiAct.DATEBEG,'19000101') or
isnull(NsiCur.DATEEND,'19000101')<>isnull(NsiAct.DATEEND,'19000101') or
isnull(NsiCur.ID_M,'0')<>isnull(NsiAct.ID_M,'0') or
isnull(NsiCur.DS_M,'')<>isnull(NsiAct.DS_M,'') or
isnull(NsiCur.KOD_M,'')<>isnull(NsiAct.KOD_M,'') or
isnull(NsiCur.M_NAME,'')<>isnull(NsiAct.M_NAME,'') 

EXEC [dbo].[versionUpdate] 538
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