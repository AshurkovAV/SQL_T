BEGIN TRAN
BEGIN TRY
DECLARE @ErrorMessage NVARCHAR(4000)
		DECLARE @ErrorSeverity INT
		DECLARE @ErrorState INT
		
EXEC [dbo].[versionСheck] 597

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

insert into @NsiAct (IDVID,VIDNAME,DATEBEG,DATEEND) values ('1','МЭК (медико-экономический контроль)','20110101',NULL)
insert into @NsiAct (IDVID,VIDNAME,DATEBEG,DATEEND) values ('2','МЭЭ (медико-экономическая экспертиза)','20110101','20180331')
insert into @NsiAct (IDVID,VIDNAME,DATEBEG,DATEEND) values ('3','ЭКМП (экспертиза качества медицинской помощи)','20110101','20180331')
insert into @NsiAct (IDVID,VIDNAME,DATEBEG,DATEEND) values ('10','Повторный медико-экономический контроль в плановом порядке','20180401',NULL)
insert into @NsiAct (IDVID,VIDNAME,DATEBEG,DATEEND) values ('11','Повторный медико-экономический контроль по претензиям МО','20180401',NULL)
insert into @NsiAct (IDVID,VIDNAME,DATEBEG,DATEEND) values ('12','Повторный медико-экономический контроль по другим причинам','20180401',NULL)
insert into @NsiAct (IDVID,VIDNAME,DATEBEG,DATEEND) values ('20','Плановая тематическая медико-экономическая экспертиза','20180401',NULL)
insert into @NsiAct (IDVID,VIDNAME,DATEBEG,DATEEND) values ('21','Плановая медико-экономическая экспертиза (случайная выборка)','20180401',NULL)
insert into @NsiAct (IDVID,VIDNAME,DATEBEG,DATEEND) values ('22','Целевая медико-экономическая экспертиза по поводу повторных обращенийй по поводу одного и того же заболевания в течение тридцати дней - при оказании медицинской помощи амбулаторно, стационарно; в течение двадцати четырех часов от момента предшествующего вызова - при повторном вызове скорой медицинской помощи','20180401',NULL)
insert into @NsiAct (IDVID,VIDNAME,DATEBEG,DATEEND) values ('23','Целевая медико-экономическая экспертиза по жалобе от застрахованного лица или его представителя на доступность медицинской помощи в медицинской организации','20180401',NULL)
insert into @NsiAct (IDVID,VIDNAME,DATEBEG,DATEEND) values ('24','Повторная медико-экономическая экспертиза в плановом порядке','20180401','20190731')
insert into @NsiAct (IDVID,VIDNAME,DATEBEG,DATEEND) values ('25','Повторная медико-экономическая экспертиза по претензии МО','20180401',NULL)
insert into @NsiAct (IDVID,VIDNAME,DATEBEG,DATEEND) values ('26','Повторная медико-экономическая экспертиза по другим причинам','20180401',NULL)
insert into @NsiAct (IDVID,VIDNAME,DATEBEG,DATEEND) values ('27','Целевая медико-экономическая экспертиза оказания медицинской помощи по профилю "онкология" с применением противоопухолевой терапии','20190801',NULL)
insert into @NsiAct (IDVID,VIDNAME,DATEBEG,DATEEND) values ('28','Целевая МЭЭ по случаям несвоевременной постановки на диспансерное наблюдение (далее-ДН) застрахованных лиц, которым впервые установлены диагнозы, при которых предусмотрено ДН, а также по случаям несоблюдения периодичности осмотров граждан, установленной порядком и периодичностью проведения ДН и перечнем включаемых в них исследований','20190801',NULL)
insert into @NsiAct (IDVID,VIDNAME,DATEBEG,DATEEND) values ('29','Целевая медико-экономическая экспертиза госпитализации застрахованного лица, медицинская помощь которому должна быть оказана в плановой форме в стационаре (структурном подразделении стационара) другого профиля в соответствии с порядками оказания медицинской помощи','20190801',NULL)
insert into @NsiAct (IDVID,VIDNAME,DATEBEG,DATEEND) values ('30','Тематическая экспертиза качества медицинской помощи','20180401',NULL)
insert into @NsiAct (IDVID,VIDNAME,DATEBEG,DATEEND) values ('31','Плановая экспертиза качества медицинской помощи (случайная выборка)','20180401',NULL)
insert into @NsiAct (IDVID,VIDNAME,DATEBEG,DATEEND) values ('32','Целевая экспертиза качества медицинской помощи по жалобе от застрахованного лица или его представителя на доступность и качество медицинской помощи в медицинской организации','20180401',NULL)
insert into @NsiAct (IDVID,VIDNAME,DATEBEG,DATEEND) values ('33','Целевая экспертиза качества медицинской помощи по случаям с летальным исходом','20180401',NULL)
insert into @NsiAct (IDVID,VIDNAME,DATEBEG,DATEEND) values ('34','Целевая экспертиза качества медицинской помощи по случаям внутрибольничного инфицирования и осложнения заболевания','20180401',NULL)
insert into @NsiAct (IDVID,VIDNAME,DATEBEG,DATEEND) values ('35','Целевая экспертиза качества медицинской помощи по случаям первичного выхода на инвалидность лиц трудоспособного возраста и детей','20180401',NULL)
insert into @NsiAct (IDVID,VIDNAME,DATEBEG,DATEEND) values ('36','Целевая экспертиза качества медицинской помощи по поводу повторного обоснованного обращения по поводу одного и того же заболевания (в течение тридцати дней - при оказании медицинской помощи амбулаторно, стационарно; в течение двадцати четырех часов от момента предшествующего вызова - при повторном вызове скорой медицинской помощи)','20180401',NULL)
insert into @NsiAct (IDVID,VIDNAME,DATEBEG,DATEEND) values ('37','Целевая экспертиза качества медицинской помощи по случаям отобранных по результатам целевой медико-экономической экспертизы','20180401',NULL)
insert into @NsiAct (IDVID,VIDNAME,DATEBEG,DATEEND) values ('38','Очная экспертиза качества медицинской помощи','20180401',NULL)
insert into @NsiAct (IDVID,VIDNAME,DATEBEG,DATEEND) values ('39','Повторная экспертиза качества медицинской помощи в плановом порядке','20180401','20190731')
insert into @NsiAct (IDVID,VIDNAME,DATEBEG,DATEEND) values ('40','Повторная экспертиза качества медицинской помощи по претензии МО','20180401',NULL)
insert into @NsiAct (IDVID,VIDNAME,DATEBEG,DATEEND) values ('41','Повторная экспертиза качества медицинской помощи по другим причинам','20180401',NULL)
insert into @NsiAct (IDVID,VIDNAME,DATEBEG,DATEEND) values ('42','Целевая экспертиза качества медицинской помощи по случаям выявления по результатам целевой и тематической медико-экономической экспертизы нарушений при оказании медицинской помощи по профилю "онкология".','20190801',NULL)
insert into @NsiAct (IDVID,VIDNAME,DATEBEG,DATEEND) values ('43','Мультидисциплинарная тематическая экспертиза качества медицинской помощи при заболеваниях, являющихся основными причинами смертности населения на территории субъекта Российской Федерации (по поручению территориального фонда обязательного медицинского страхования)','20190801',NULL)
insert into @NsiAct (IDVID,VIDNAME,DATEBEG,DATEEND) values ('44','Мультидисциплинарная тематическая экспертиза качества медицинской при заболеваниях, являющихся основными причинами смертности населения в Российской Федерации (по поручению Федерального фонда обязательного медицинского страхования)','20190801',NULL)
insert into @NsiAct (IDVID,VIDNAME,DATEBEG,DATEEND) values ('45','Мультидисциплинарная тематическая ЭКМП по случаям, отобранным по результатам МЭЭ, ЭКМП, если указанные результаты не позволяют сделать заключение о соответствии оказанной медицинской помощи порядкам оказания медицинской помощи, клиническим рекомендациям, стандартам медицинской помощи, в том числе при переводе пациента в другие отделения стационара','20190801',NULL)
insert into @NsiAct (IDVID,VIDNAME,DATEBEG,DATEEND) values ('46','Мультидисциплинарная тематическая ЭКМП при необходимости проверки полноты устранения ранее выявленных нарушений при оказании медицинской помощи спустя шесть месяцев со дня окончания предыдущей мультидисциплинарной плановой экспертизы качества медицинской помощи','20190801',NULL)
insert into @NsiAct (IDVID,VIDNAME,DATEBEG,DATEEND) values ('47','Мультидисциплинарная целевая экспертиза качества медицинской помощи по случаю жалобы от застрахованного лица или его представителя на доступность и качество медицинской помощи, оказанной специалистами разных профилей и/или на разных уровнях оказания медицинской помощи','20190801',NULL)
insert into @NsiAct (IDVID,VIDNAME,DATEBEG,DATEEND) values ('48','Мультидисциплинарная целевая экспертиза качества медицинской помощи по случаям летальных исходов с кодами диагнозов по МКБ-10: I20.0, I21-I24, I60-I63, G45-G46, J12-J18, C50, C61','20190801',NULL)
insert into @NsiAct (IDVID,VIDNAME,DATEBEG,DATEEND) values ('49','Мультидисциплинарная целевая экспертиза качества медицинской помощи по случаям первичного выхода на инвалидность лиц трудоспособного возраста и детей','20190801',NULL)
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