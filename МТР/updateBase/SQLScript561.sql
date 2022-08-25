BEGIN TRAN
BEGIN TRY
DECLARE @ErrorMessage NVARCHAR(4000)
		DECLARE @ErrorSeverity INT
		DECLARE @ErrorState INT
EXEC [dbo].[versionСheck] 560

DROP TABLE [dbo].[V026]

CREATE TABLE [dbo].[V026](
	[IDUMP] [int] NULL,
	[K_KPG] NVARCHAR(4) NULL,
	[N_KPG] [nvarchar](254) NULL,
	[KOEF_Z] [numeric](3, 2) NULL,
	[DATEBEG] [date] NULL,
	[DATEEND] [date] NULL,
 CONSTRAINT [PK_COM] UNIQUE NONCLUSTERED 
(
	[IDUMP] ASC,
	[K_KPG] ASC,
	[DATEBEG] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Классификатор клинико-профилактических групп' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'V026', @level2type=N'COLUMN',@level2name=N'IDUMP'

--DECLARE @NsiAct-------------------------------------------------------------------------------------------
	declare @NsiAct table 
			(
				IDUMP int,K_KPG nvarchar(4),N_KPG nvarchar(254),KOEF_Z numeric(3,2),DATEBEG date,DATEEND date
			)

insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('1','1','Акушерское дело','0.50','20180101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('1','2','Акушерство и гинекология','0.80','20180101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('1','3','Аллергология и иммунология','1.25','20180101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('1','4','Гастроэнтерология','1.04','20180101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('1','5','Гематология','1.80','20180101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('1','6','Дерматология','0.80','20180101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('1','7','Детская кардиология','1.84','20180101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('1','8','Детская онкология','4.59','20180101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('1','9','Детская урология-андрология','1.15','20180101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('1','10','Детская хирургия','1.10','20180101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('1','11','Детская эндокринология','1.48','20180101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('1','12','Инфекционные болезни','0.65','20180101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('1','13','Кардиология','1.49','20180101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('1','14','Колопроктология','1.36','20180101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('1','15','Неврология','1.12','20180101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('1','16','Нейрохирургия','1.20','20180101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('1','17','Неонатология','2.96','20180101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('1','18','Нефрология (без диализа)','1.69','20180101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('1','19','Онкология','2.24','20180101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('1','20','Оториноларингология','0.87','20180101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('1','21','Офтальмология','0.92','20180101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('1','22','Педиатрия','0.80','20180101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('1','23','Пульмонология','1.31','20180101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('1','24','Ревматология','1.44','20180101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('1','25','Сердечно-сосудистая хирургия','1.18','20180101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('1','26','Стоматология детская','0.79','20180101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('1','27','Терапия','0.73','20180101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('1','28','Торакальная хирургия','2.09','20180101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('1','29','Травматология и ортопедия','1.37','20180101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('1','30','Урология','1.20','20180101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('1','31','Хирургия','0.90','20180101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('1','32','Хирургия (абдоминальная)','1.20','20180101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('1','33','Хирургия (комбустиология)','1.95','20180101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('1','34','Челюстно-лицевая хирургия','1.18','20180101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('1','35','Эндокринология','1.40','20180101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('1','37','Медицинская реабилитация','1.00','20180101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('1','38','Гериатрия','1.50','20180101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('1','36','Прочее','1.00','20180402',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('1','st01','Акушерское дело','0.50','20190101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('1','st02','Акушерство и гинекология','0.80','20190101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('1','st03','Аллергология и иммунология','1.25','20190101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('1','st04','Гастроэнтерология','1.04','20190101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('1','st05','Гематология','2.85','20190101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('1','st06','Дерматология','0.80','20190101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('1','st07','Детская кардиология','1.84','20190101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('1','st08','Детская онкология','4.37','20190101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('1','st09','Детская урология-андрология','1.15','20190101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('1','st10','Детская хирургия','1.10','20190101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('1','st11','Детская эндокринология','1.48','20190101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('1','st12','Инфекционные болезни','0.65','20190101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('1','st13','Кардиология','1.49','20190101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('1','st14','Колопроктология','1.36','20190101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('1','st15','Неврология','1.12','20190101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('1','st16','Нейрохирургия','1.20','20190101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('1','st17','Неонатология','2.96','20190101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('1','st18','Нефрология (без диализа)','1.69','20190101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('1','st19','Онкология','3.27','20190101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('1','st20','Оториноларингология','0.87','20190101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('1','st21','Офтальмология','0.92','20190101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('1','st22','Педиатрия','0.80','20190101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('1','st23','Пульмонология','1.31','20190101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('1','st24','Ревматология','1.44','20190101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('1','st25','Сердечно-сосудистая хирургия','1.18','20190101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('1','st26','Стоматология детская','0.79','20190101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('1','st27','Терапия','0.73','20190101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('1','st28','Торакальная хирургия','2.09','20190101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('1','st29','Травматология и ортопедия','1.37','20190101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('1','st30','Урология','1.20','20190101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('1','st31','Хирургия','0.90','20190101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('1','st32','Хирургия (абдоминальная)','1.20','20190101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('1','st33','Хирургия (комбустиология)','1.95','20190101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('1','st34','Челюстно-лицевая хирургия','1.18','20190101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('1','st35','Эндокринология','1.40','20190101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('1','st37','Медицинская реабилитация','1.74','20190101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('1','st38','Гериатрия','1.50','20190101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('1','st36','Прочее','1.00','20190101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('2','1','Акушерское дело','0.50','20180101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('2','2','Акушерство и гинекология','0.80','20180101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('2','3','Аллергология и иммунология','0.98','20180101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('2','4','Гастроэнтерология','0.89','20180101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('2','5','Гематология','1.17','20180101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('2','6','Дерматология','1.54','20180101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('2','7','Детская кардиология','0.98','20180101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('2','8','Детская онкология','9.23','20180101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('2','9','Детская урология-андрология','1.42','20180101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('2','10','Детская хирургия','1.60','20180101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('2','11','Детская эндокринология','1.49','20180101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('2','12','Инфекционные болезни','0.92','20180101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('2','13','Кардиология','0.80','20180101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('2','14','Колопроктология','1.70','20180101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('2','15','Неврология','1.05','20180101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('2','16','Нейрохирургия','1.06','20180101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('2','17','Неонатология','1.87','20180101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('2','18','Нефрология (без диализа)','2.74','20180101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('2','19','Онкология','3.01','20180101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('2','20','Оториноларингология','0.98','20180101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('2','21','Офтальмология','0.98','20180101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('2','22','Педиатрия','0.93','20180101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('2','23','Пульмонология','0.90','20180101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('2','24','Ревматология','1.46','20180101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('2','25','Сердечно-сосудистая хирургия','1.88','20180101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('2','26','Стоматология детская','0.98','20180101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('2','27','Терапия','0.74','20180101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('2','28','Торакальная хирургия','1.32','20180101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('2','29','Травматология и ортопедия','1.25','20180101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('2','30','Урология','0.98','20180101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('2','31','Хирургия','0.92','20180101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('2','32','Хирургия (абдоминальная)','1.85','20180101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('2','33','Хирургия (комбустиология)','1.10','20180101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('2','34','Челюстно-лицевая хирургия','0.89','20180101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('2','35','Эндокринология','1.23','20180101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('2','37','Медицинская реабилитация','1.00','20180101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('2','36','Прочее','1.00','20180402',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('2','ds01','Акушерское дело','0.50','20190101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('2','ds02','Акушерство и гинекология','0.80','20190101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('2','ds03','Аллергология и иммунология','0.98','20190101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('2','ds04','Гастроэнтерология','0.89','20190101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('2','ds05','Гематология','5.45','20190101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('2','ds06','Дерматология','1.54','20190101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('2','ds07','Детская кардиология','0.98','20190101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('2','ds08','Детская онкология','7.95','20190101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('2','ds09','Детская урология-андрология','1.42','20190101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('2','ds10','Детская хирургия','1.60','20190101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('2','ds11','Детская эндокринология','1.39','20190101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('2','ds12','Инфекционные болезни','0.92','20190101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('2','ds13','Кардиология','0.80','20190101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('2','ds14','Колопроктология','1.70','20190101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('2','ds15','Неврология','1.05','20190101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('2','ds16','Нейрохирургия','1.06','20190101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('2','ds17','Неонатология','1.79','20190101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('2','ds18','Нефрология (без диализа)','2.74','20190101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('2','ds19','Онкология','6.09','20190101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('2','ds20','Оториноларингология','0.98','20190101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('2','ds21','Офтальмология','0.98','20190101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('2','ds22','Педиатрия','0.93','20190101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('2','ds23','Пульмонология','0.90','20190101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('2','ds24','Ревматология','1.46','20190101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('2','ds25','Сердечно-сосудистая хирургия','1.88','20190101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('2','ds26','Стоматология детская','0.98','20190101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('2','ds27','Терапия','0.74','20190101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('2','ds28','Торакальная хирургия','1.32','20190101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('2','ds29','Травматология и ортопедия','1.25','20190101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('2','ds30','Урология','0.98','20190101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('2','ds31','Хирургия','0.92','20190101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('2','ds32','Хирургия (абдоминальная)','1.85','20190101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('2','ds33','Хирургия (комбустиология)','1.10','20190101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('2','ds34','Челюстно-лицевая хирургия','0.89','20190101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('2','ds35','Эндокринология','1.23','20190101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('2','ds37','Медицинская реабилитация','1.71','20190101',NULL)
insert into @NsiAct (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND) values ('2','ds36','Прочее','1.00','20190101',NULL)
--INSERT NEW INTO  NsiCur------------------------------------------------------------------------------------------------------------
	insert into V026 (IDUMP,K_KPG,N_KPG,KOEF_Z,DATEBEG,DATEEND)
	select 
	NsiAct.IDUMP,NsiAct.K_KPG,NsiAct.N_KPG,NsiAct.KOEF_Z,NsiAct.DATEBEG,NsiAct.DATEEND
	from @NsiAct NsiAct
		left join V026 NSiCur
			on NSiCur.K_KPG=NsiAct.K_KPG
	where 
		NSiCur.K_KPG is null

--UPDATE NsiCur------------------------------------------------------------------------------------------------------------
	update NsiCur set
NsiCur.DATEBEG=NsiAct.DATEBEG,
NsiCur.DATEEND=NsiAct.DATEEND,
NsiCur.IDUMP=NsiAct.IDUMP,
NsiCur.KOEF_Z=NsiAct.KOEF_Z,
NsiCur.K_KPG=NsiAct.K_KPG,
NsiCur.N_KPG=NsiAct.N_KPG
	from @NsiAct NsiAct
		inner join V026 NsiCur
						on NSiCur.K_KPG=NsiAct.K_KPG
	where
		isnull(NsiCur.DATEBEG,'19000101')<>isnull(NsiAct.DATEBEG,'19000101') or
isnull(NsiCur.DATEEND,'19000101')<>isnull(NsiAct.DATEEND,'19000101') or
isnull(NsiCur.IDUMP,'0')<>isnull(NsiAct.IDUMP,'0') or
isnull(NsiCur.KOEF_Z,'0')<>isnull(NsiAct.KOEF_Z,'0') or
isnull(NsiCur.K_KPG,'')<>isnull(NsiAct.K_KPG,'') or
isnull(NsiCur.N_KPG,'')<>isnull(NsiAct.N_KPG,'') 



EXEC [dbo].[versionUpdate] 561
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