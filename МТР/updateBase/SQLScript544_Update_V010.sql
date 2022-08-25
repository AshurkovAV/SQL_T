BEGIN TRAN
BEGIN TRY
DECLARE @ErrorMessage NVARCHAR(4000)
		DECLARE @ErrorSeverity INT
		DECLARE @ErrorState INT
		
EXEC [dbo].[versionСheck] 543
--DECLARE @NsiAct-------------------------------------------------------------------------------------------
	declare @NsiAct table 
			(
				IDSP numeric(2,0),SPNAME nvarchar(254),DATEBEG datetime,DATEEND datetime
			)

insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('1','Посещение в поликлинике','20110101','20140124')
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('2','Оперативное вмешательство','20110101','20181231')
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('3','Анестезиологическое пособие','20110101','20181231')
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('4','Лечебно-диагностическая процедура','20110101','20181231')
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('5','Койко-день в круглосуточном стационаре','20110101','20181231')
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('6','Койко-день в дневном стационаре больничного учреждения','20110101','20181231')
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('7','День лечения в дневном стационаре АПУ','20110101','20181231')
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('8','День лечения в стационаре на дому','20110101','20181231')
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('9','УЕТ в стоматологии','20110101','20181231')
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('10','Стандарт медицинской помощи в поликлинике','20110101','20181231')
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('11','Дополнительная диспансеризация','20110101','20181231')
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('12','Комплексная услуга центра здоровья','20110101','20181231')
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('13','Стандарт медицинской помощи в стационаре (включая ВМП)','20110101','20181231')
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('14','Лечение в профильном отделении стационара','20110101','20181231')
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('15','Стандарт скорой медицинской помощи','20110101','20181231')
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('16','Клинико-статистические  группы','20110101','20140124')
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('17','Законченный случай в поликлинике','20111004','20181231')
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('18','Законченный случай в круглосуточном стационаре','20111004','20140124')
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('19','Законченный случай в дневном стационаре больничного учреждения','20111004','20140124')
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('20','Законченный случай в дневном стационаре АПУ','20111004','20140124')
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('21','Законченный случай в стационаре на дому','20111004','20181231')
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('22','Посещение','20111213','20140124')
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('23','Посещение на дому','20111213','20181231')
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('24','За вызов скорой медицинской помощи','20130101',NULL)
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('25','По подушевому нормативу финансирования на прикрепившихся лиц в сочетании с оплатой за единицу объема медицинской помощи','20130101',NULL)
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('26','По подушевому нормативу финансирования на прикрепившихся лиц в сочетании с оплатой за посещение','20130101','20181231')
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('27','По подушевому нормативу финансирования на прикрепившихся лиц в сочетании с оплатой за обращение (законченный случай)','20130101','20181231')
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('28','За медицинскую услугу','20130101',NULL)
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('29','За посещение','20130101',NULL)
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('30','За обращение (законченный случай)','20130101',NULL)
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('31','По подушевому нормативу финансирования на прикрепившихся лиц с учетом показателей результативности деятельности медицинской организации','20130101',NULL)
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('32','За законченный случай лечения заболевания','20130101',NULL)
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('33','За законченный случай лечения заболевания, включенного в соответствующую группу заболеваний (в том числе клинико-статистические группы заболеваний)','20130101',NULL)
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('34','За законченный случай лечения заболевания при оплате медицинской помощи, оказанной в дневном стационаре','20130101','20181231')
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('35','По подушевому нормативу финансирования при оплате скорой медицинской помощи','20130101','20181231')
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('36','По подушевому нормативу финансирования в сочетании с оплатой за вызов скорой медицинской помощи','20130101',NULL)
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('37','По подушевому нормативу финансирования на прикрепившихся лиц в сочетании с оплатой за медицинскую услугу в связи с оказанием неотложной помощи','20130101','20181231')
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('38','По подушевому нормативу финансирования на прикрепившихся лиц в сочетании с оплатой за посещение в связи с оказанием неотложной помощи','20130101','20181231')
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('39','По подушевому нормативу финансирования на прикрепившихся лиц в сочетании с оплатой за обращение (законченный случай) в связи с оказанием неотложной помощи','20130101','20181231')
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('40','За медицинскую услугу в связи с оказанием неотложной помощи','20130101','20181231')
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('41','За посещение в связи с оказанием неотложной помощи','20130101','20181231')
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('42','За обращение (законченный случай) в связи с оказанием неотложной помощи','20130101','20181231')
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('43','За законченный случай лечения заболевания, включенного в соответствующую группу заболеваний (в том числе клинико-статистические группы заболеваний) в дневном стационаре','20140101','20181231')
insert into @NsiAct (IDSP,SPNAME,DATEBEG,DATEEND) values ('44','По подушевому нормативу финансирования на прикрепившихся к МО лиц, включая оплату медицинской помощи по всем видам и условиям предоставляемой МО медицинской помощи, с учетом показателей результативности деятельности медицинской организации','20190101',NULL)
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