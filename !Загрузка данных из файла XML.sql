
/****** Object:  StoredProcedure [dbo].[p_Load_XML]    Script Date: 04.02.2025 10:35:58 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


ALTER PROC  [dbo].[p_Load_XML] ( /* загрузка хмл файлов в базу.  реестров от МО. */
@FileOMS varchar(250)  /* имя зип-архива с хмл файлами. например: 'DPM220091S22003_18081.ZIP' */
	,@FileNameH varchar(100) 
	,@FileNameL varchar(100) 
	,@SchetType varchar(10) /* тип реестра хмл. */
	,@XmlH xml 
	,@XmlL xml 
	,@sc int
	,@rez    varchar(1000) 
	OUTPUT ) AS 
begin
	/* я расширил до 250 символов имена файлов. */
/*тестовый блок */
/*
	declare	    
	@FileOMS varchar(250)  /* имя зип-архива с хмл файлами. например: 'DPM220091S22003_18081.ZIP' */
	,@FileNameH varchar(100) 
	,@FileNameL varchar(100) 
	,@SchetType varchar(10) /* тип реестра хмл. */
	,@XmlH xml 
	,@XmlL xml 
	,@sc int
	,@rez    varchar(1000)

set @FileOMS  ='1' -- имя зип-архива с хмл файлами. например: 'DPM220091S22003_18081.ZIP'
set @FileNameH  = 'H'
set @FileNameL  =  'L'
set @SchetType = 'H'
set @sc = 0
set @XmlH  = (select FileXML from D3_SCHET_OMS_FILES where id=(select max(id)-1 from D3_SCHET_OMS_FILES))
set	@XmlL  =  (select FileXML from D3_SCHET_OMS_FILES where id=(select max(id) from D3_SCHET_OMS_FILES))
*/
/* конец тестового блока */

/* создание временных таблиц*/

declare @guid_id varchar(36); /*гуид для создания уникального имени главного ключа PK_T_ZSL и индекса UQ__T_VER31__1 временных таблиц*/
set @guid_id = replace(NEWID(), '-', '');
/*select @guid_id;*/
if (OBJECT_ID ('tempdb.dbo.#T_SCHET') IS NOT NULL) drop table #T_SCHET;
if (OBJECT_ID ('tempdb.dbo.#T_SL') IS NOT NULL) drop table #T_SL;
if (OBJECT_ID ('tempdb.dbo.#T_SL_FK') IS NOT NULL) drop table #T_SL_FK;
if (OBJECT_ID ('tempdb.dbo.#T_USL') IS NOT NULL) drop table #T_USL;
if (OBJECT_ID ('tempdb.dbo.#T_VER31') IS NOT NULL) drop table #T_VER31; 
if (OBJECT_ID ('tempdb.dbo.#T_ZSL') IS NOT NULL) drop table #T_ZSL;
if (OBJECT_ID ('tempdb.dbo.#T_SANK') IS NOT NULL) drop table #T_SANK;
if (OBJECT_ID ('tempdb.dbo.#T_LEK_PR_COV') IS NOT NULL) drop table #T_LEK_PR_COV;
if (OBJECT_ID ('tempdb.dbo.#T_MEDDEV') IS NOT NULL) drop table #T_MEDDEV;
if (OBJECT_ID ('tempdb.dbo.#T_INJ') IS NOT NULL) drop table #T_INJ;

select * into #T_SCHET from T_SCHET where 1 = 2;
select * into #T_SL from T_SL where 1 = 2;
select * into #T_SL_FK from T_SL_FK where 1 = 2;
select * into #T_USL from T_USL where 1 = 2;
select * into #T_VER31 from T_VER31 where 1 = 2;
select * into #T_ZSL from T_ZSL where 1 = 2;
select * into #T_SANK from T_SANK where 1 = 2;
select * into #T_LEK_PR_COV from T_LEK_PR_COV where 1 = 2;
select * into #T_MEDDEV from T_MEDDEV where 1 = 2;
select * into #T_INJ from T_INJ where 1 = 2;

/* окончание создания временных таблиц*/


declare @sl varchar(100) = 'SL'  /*наименование блока SL, это по умолчанию */
declare @path varchar(200) /*переменная для типизации полей */
declare @tb_ID table(ID int) /*содержит идентификатор вставленной записи в таблицу D3_SCHET_OMS*/


SET DATEFORMAT ymd; 
/*поищем счёт, в который нужно вставлять, если -1 - значит этот счёт нам и нужен. */
/*select top 1 @sc = ID from D3_SCHET_OMS where code = -1 */
/*set @sc =1334 */

/* обязательные файлы реестр счетов и файл пациентов. */
declare @sluch_xml varchar(max),@pac_xml varchar(max)
declare @idpac int,@idsluch int



/*модуль обработки дополнительного файла. */

declare @tipxml int  
declare @tipL varchar(10)  

select @tipxml=tipxml,@tipL=LPref from Yamed_Spr_SchetType where ID = @SchetType


/* вот тут если остались файлы, привязанные к счёту то их нужно очистить, это были типа ошибки в загрузке. */
/* для дебага в основном, так как уже нет вариантов когда такое будет. */






if @tipxml=2  /*дополнительные файлы записываем в базу, но не обрабатываем. */
begin 
	/*код счёта = 0, потом связать по L файлу. */
	delete from D3_SCHET_OMS_FILES where [FileName]=@FileNameH

    INSERT INTO [dbo].[D3_SCHET_OMS_FILES]   ([FileXML],[FileName],[FileDate],[D3_SCID],SchetType)
VALUES           (@XmlH,@FileNameH,getdate(),@sc,@SchetType)
	set @rez = 0
	Return /*0 */
end
else
begin
	if @sc = 0 /* ���� ������ �����. */
		begin
			insert D3_SCHET_OMS (Code,OmsFileName) output INSERTED.ID into @tb_ID values (-1,@FileOMS)
			set @sc = (select ID from @tb_ID);
--			set @sc = @@identity;
		
		end
	else 
		begin
			/*для флк, в базе тфомс ID не автоматический. */
			insert into D3_SCHET_OMS (ID,Code,OmsFileName) values (@sc,-1,@FileOMS)
			delete D3_SCHET_OMS_FILES where d3_scid=@sc
		end


		/*вставляем пришедшие файлы в таблицу файлов. */
	INSERT INTO [dbo].[D3_SCHET_OMS_FILES]   ([FileXML],[FileName],[FileDate],[D3_SCID],SchetType)
	VALUES           (@XmlH,@FileNameH,getdate(),@sc,@SchetType)
	INSERT INTO [dbo].[D3_SCHET_OMS_FILES]   ([FileXML],[FileName],[FileDate],[D3_SCID],SchetType)
	VALUES           (@XmlL,@FileNameL,getdate(),@sc,@tipL)
end




/*запихуем из него в таблички. */
/*update D3_SCHET_OMS_FILES set d3_scid=@sc where d3_scid=-1 -- привязываем номер нового реестра к файлам хмл */

declare @ver varchar(5) /* версия файла, буду обрабатывать 2.1 и 3.0  3.1 обрабатываю как и 3.0 */
/* курская версия 3.0K */
/* выясняем версию обмена */
select @ver = rtrim(x.m.value('(./VERSION)[1]', 'varchar(100)') )
					from @XmlH.nodes( '/ZL_LIST/ZGLV' ) x(m)

declare @reg varchar(2)  /*регион плательщика, вытягиваем из хмл из PLAT */
select @reg = left(rtrim(x.m.value('(./PLAT)[1]', 'varchar(100)') ),2)
					from @XmlH.nodes( '/ZL_LIST/SCHET' ) x(m)

/*начинаем транзакции //убрал транзакцию, у руслана глючит */
declare @i int = 0 /* счётчик ошибок. */



/*D3_SCHET_OMS */
insert into #T_SCHET (sc ,[CODE] ,[CODE_MO],[YEAR],[MONTH],[NSCHET],[DSCHET],[PLAT],[SUMMAV],[COMENTS],[SUMMAP],
	[SANK_MEK],	[SANK_MEE],	[SANK_EKMP],[DISP],	[SD_Z],	[ZapFileName],[SchetType] )
select top 1 @sc,
 x.m.value('(./CODE)[1]', 'nvarchar(254)') AS CODE
,x.m.value('(./CODE_MO)[1]', 'nvarchar(254)') AS CODE_MO
,x.m.value('(./YEAR)[1]', 'nvarchar(254)') AS YEAR
,x.m.value('(./MONTH)[1]', 'nvarchar(254)') AS MONTH
,x.m.value('(./NSCHET)[1]', 'nvarchar(254)') AS NSCHET
,x.m.value('(./DSCHET)[1]', 'nvarchar(254)') AS DSCHET
,x.m.value('(./PLAT)[1]', 'nvarchar(254)') AS PLAT
,x.m.value('(./SUMMAV)[1]', 'nvarchar(254)') AS SUMMAV
,x.m.value('(./COMENTS)[1]', 'nvarchar(254)') AS COMENTS
,x.m.value('(./SUMMAP)[1]', 'nvarchar(254)') AS SUMMAP
,x.m.value('(./SANK_MEK)[1]', 'nvarchar(254)') AS SANK_MEK
,x.m.value('(./SANK_MEE)[1]', 'nvarchar(254)') AS SANK_MEE
,x.m.value('(./SANK_EKMP)[1]', 'nvarchar(254)') AS SANK_EKMP
,x.m.value('(./DISP)[1]', 'nvarchar(254)') AS DISP
,x.m.value('(../ZGLV/SD_Z)[1]', 'nvarchar(254)') AS SD_Z
,x.m.value('(../ZGLV/FILENAME)[1]', 'nvarchar(254)') AS FILENAME
,@SchetType
from @XmlH.nodes( '/ZL_LIST/SCHET' ) x(m)

if @@ERROR<>0 set @i = @i+1

UPDATE D3_SCHET_OMS SET 
 [CODE]=CONVERT(NUMERIC(12,0), tt.[CODE])
,[CODE_MO]=tt.[CODE_MO]
,[YEAR]=CONVERT(INT, tt.[YEAR])
,[MONTH]=CONVERT(INT, tt.[MONTH])
,[NSCHET]=tt.[NSCHET]
,[DSCHET]=CONVERT(date, tt.[DSCHET])
,[PLAT]=tt.[PLAT]
,[SUMMAV]=case when tt.[SUMMAV]='' then 0 else CONVERT(NUMERIC(15, 2), tt.[SUMMAV]) end /* для пустых реестров. */
,[COMENTS]=tt.[COMENTS]
,[SUMMAP]=case when tt.[SUMMAP]='' then 0 else CONVERT(NUMERIC(15, 2), tt.[SUMMAP]) end /* для пустых реестров. */
,[SANK_MEK]=case when tt.[SANK_MEK]='' then null else CONVERT(NUMERIC(15, 2), tt.[SANK_MEK]) end /* для пустых реестров. */
,[SANK_MEE]=case when tt.[SANK_MEE]='' then null else CONVERT(NUMERIC(15, 2), tt.[SANK_MEE]) end /* для пустых реестров. */
,[SANK_EKMP]=case when tt.[SANK_EKMP]='' then null else CONVERT(NUMERIC(15, 2), tt.[SANK_EKMP]) end /* для пустых реестров. */
,[DISP]=tt.[DISP]
,[SD_Z]=case when tt.[SD_Z]='' then 0 else CONVERT(INT, tt.[SD_Z]) end
,ZapFileName = @FileNameH
,SchetType = @SchetType

/*(case when left(tt.[FILENAME],1) in ('L') then left(tt.[FILENAME],3) when left(tt.[FILENAME],1) in ('D') then left(tt.[FILENAME],2) else left(tt.[FILENAME],1) end )  */
From D3_SCHET_OMS sc Join #T_SCHET tt on sc.ID = tt.sc

if @@ERROR<>0 set @i = @i+1
/* файл пациент един для всех хмл файлов */
select @pac_xml = '<?xml version="1.0" encoding="windows-1251"?> '+cast (@XmlL as varchar(max))
EXEC sp_xml_preparedocument @idpac OUTPUT, @pac_xml

if @@ERROR<>0 set @i = @i+1

declare @tmpxml xml = @XmlH

/*логи */
/*insert into Schet (code_mo,coments) values (670039,'перед курсором') */

BEGIN
/*тормозит сильно при плохой кодировке. */

select @sluch_xml = '<?xml version="1.0" encoding="windows-1251"?> '+cast (@tmpxml as varchar(max))
EXEC sp_xml_preparedocument @idsluch OUTPUT, @sluch_xml
if @@ERROR<>0 set @i = @i+1



if @ver like '3.%' or @ver like '4.%' or @ver like '5.%'
print 'zsl'
	insert into #T_ZSL (	 SC,idcase ,ID_PAC ,VPOLIS ,   SPOLIS ,   NPOLIS,   SMO ,[ST_OKATO],[SMO_OGRN],[SMO_OK],[SMO_NAM] ,[INV] ,[MSE] 
	  ,Novor ,VNOV_D,SOC,LPU_P,LPU_DATE,FAM, IM , OT, W , DR ,[TEL] ,[FAM_P],[IM_P],[OT_P],[W_P],[DR_P]
	  ,[MR], DOCTYPE , DOCSER, DOCNUM ,DOCDATE,DOCORG, SNILS , OKATOG , OKATOP ,[COMENTP],DOST,DOST_P  
	
	,N_ZAP,PR_NOV , USL_OK, ZSL_ID , VIDPOM , FOR_POM 
,NPR_MO
,	NPR_DATE,LPU ,P_CEL
		  , VBR  , DATE_Z_1, DATE_Z_2 , DTP, T_ARRIVAL,[P_OTK] ,[RSLT_D],[KD_Z] ,[VNOV_M], RSLT, ISHOD 
		  ,[OS_SLUCH], OS_SLUCH_REGION , VOZR ,[VB_P], SUMV , SUMP ,[OPLATA],[SANK_IT]
		  ,MEK_COMENT,MEK_COUNT,MEE_COUNT,OSP_COMENT
		  , IDSP  
)
	
	select  distinct @sc dd,idcase 
	,ID_PAC ,VPOLIS ,   SPOLIS ,    
	case when @SchetType='H' and VPOLIS = 3 then isnull(ENP,NPOLIS) 
		 when @SchetType<>'C' then isnull(NPOLIS,ENP) 
		 else NPOLIS end as NPOLIS,   
	SMO ,[ST_OKATO],[SMO_OGRN],[SMO_OK],[SMO_NAM] ,[INV] ,[MSE] 
	  ,Novor,VNOV_D, isnull(SOC, '000'), LPU_P,LPU_DATE,FAM, IM , OT, W , DR ,[TEL] ,[FAM_P],[IM_P],[OT_P],[W_P],[DR_P]
	  ,[MR], DOCTYPE , DOCSER, DOCNUM ,DOCDATE,DOCORG, SNILS , OKATOG , OKATOP ,[COMENTP],DOST,DOST_P   
	
	,N_ZAP,PR_NOV , USL_OK, isnull(ZSL_ID,IDCASE) ZSL_ID , VIDPOM , FOR_POM 
,left(NPR_MO,6) /*алтай 04 в LAB файлах длинные бывают направления */
,	NPR_DATE, LPU ,left(P_CEL,3) dsd
		  , VBR  , DATE_Z_1, DATE_Z_2 , DTP, T_ARRIVAL,[P_OTK] ,[RSLT_D],[KD_Z] ,[VNOV_M], RSLT, ISHOD 
		  ,[OS_SLUCH], OS_SLUCH_REGION , VOZR ,[VB_P], SUMV , SUMP ,[OPLATA],[SANK_IT]
		  ,cast(rtrim(MEK_COMENT) as nvarchar(4000)),MEK_COUNT,MEE_COUNT,OSP_COMENT
		  , IDSP 
	/*	  into ##dddd */
	FROM  OPENXML (@idsluch, N'ZL_LIST/ZAP/Z_SL',2)
	WITH (  idcase numeric(11,0) '*[local-name() = "Z_SL_ID" or local-name() = "IDCASE"] '
			,ID_PAC nvarchar(36) '../PACIENT/ID_PAC'
			,VPOLIS nvarchar(36) '../PACIENT/VPOLIS[text()!=""]'
	  ,   SPOLIS nvarchar(20) '../PACIENT/SPOLIS[text()!=""]'
	  ,   NPOLIS nvarchar(20) '../PACIENT/NPOLIS[text()!=""]'
	   ,   ENP nvarchar(20) '../PACIENT/ENP[text()!=""]'
	  ,   SMO nvarchar(5) '../PACIENT/SMO[text()!=""]'
	  ,[ST_OKATO] nvarchar(254) '../PACIENT/ST_OKATO[text()!=""]'
	  ,[SMO_OGRN] nvarchar(254) '../PACIENT/SMO_OGRN[text()!=""]'
      ,[SMO_OK] nvarchar(254) '../PACIENT/SMO_OK[text()!=""]'
      ,[SMO_NAM] nvarchar(254) '../PACIENT/SMO_NAM[text()!=""]'
      ,[INV] nvarchar(254) '../PACIENT/INV[text()!=""]'
      ,[MSE] nvarchar(254) '../PACIENT/MSE[text()!=""]'
	  ,Novor nvarchar(9) '../PACIENT/NOVOR[text()!=""]'
	  ,VNOV_D int '../PACIENT/VNOV_D[text()!=""]'
	  ,SOC nvarchar(3) '../PACIENT/SOC[text()!=""]'
	  ,LPU_P nvarchar(254) '../PACIENT/LPU_P[text()!=""]' /* для орла */
	  ,LPU_DATE date '../PACIENT/LPU_DATE[text()!=""]' /* для орла */
	  /*zsl */
		,N_ZAP int '../N_ZAP' /* номер записи в хмл файле */
			,PR_NOV int '../PR_NOV' /* признак исправленной записи */
		  , USL_OK int 'USL_OK' /* в нормальном 3.0 usl_ok именно в zsl */
		   ,P_CEL nvarchar(36) '*[local-name() = "P_CEL" or local-name() = "DISP"]' /* для орла будем диспансеризацию сюда кидать */
		  , ZSL_ID nvarchar(36) '*[contains(local-name(), "SL_ID") ] ' /* будет работать только там, где выгружают ZSL_ID d в перьми Z_SL_ID */
		  , VIDPOM int  'VIDPOM[text()!=""]'
		  , FOR_POM int  'FOR_POM[text()!=""]'
		  ,	NPR_MO nvarchar(10)   'NPR_MO[text()!=""]'
		  ,	NPR_DATE date 'NPR_DATE[text()!=""]'
		  , LPU nvarchar(10) 'LPU[text()!=""]'
		  , VBR int 'VBR[text()!=""]' 
		  , DATE_Z_1 date 'DATE_Z_1[text()!=""]' /* остановился. */
		  , DATE_Z_2 date 'DATE_Z_2[text()!=""]'
		  , DTP int 'DTP[text()!=""]' /*Обязательно заполняется значением 1 при выезде бригады скорой медицинской помощи (USL_OK=4) на дорожно-транспортное происшествие. В остальных случаях - 0  */
		  , T_ARRIVAL int 'T_ARRIVAL[text()!=""]' /*Обязательно заполняется значением при выезде бригады скорой медицин-ской помощи (USL_OK=4):1 – до 20 минут;2 – от 21 до 40 минут;3 – от 41 до 60 минут;4 – более 60 минут.При других условиях оказания медицинской помощи значением  – 0 */
		  ,[P_OTK] nvarchar(255) 'P_OTK[text()!=""]'
		  ,[RSLT_D] nvarchar(255) 'RSLT_D[text()!=""]'
		  ,[KD_Z] int 'KD_Z[text()!=""]'
		  ,[VNOV_M] nvarchar(255) 'VNOV_M[text()!=""]'
		  , RSLT nvarchar(10) 'RSLT[text()!=""]'
		  , ISHOD nvarchar(10) 'ISHOD[text()!=""]'
		  ,[OS_SLUCH] int 'OS_SLUCH[text()!=""]'
		  , OS_SLUCH_REGION nvarchar(10) 'OS_SLUCH_REGION[text()!=""]'
		  , VOZR nvarchar(10) 'VOZR[text()!=""]'
		  ,[VB_P] int 'VB_P[text()!=""]'
		  , SUMV numeric(17,2) '*[text()!="" and contains(local-name(), "SUMV")]'
		  , SUMP numeric(17,2) '*[text()!="" and contains(local-name(), "SUMP")]'
		   ,[OPLATA] int 'OPLATA[text()!=""]'
			,[SANK_IT] numeric(17,2) '*[local-name() = "SANK_IT" or local-name() = "SANKIT"]' /*в старом SANKIT в новом SANK_IT */
		  --,MEK_COMENT nvarchar(max) '*[local-name() = "SANK/S_COM" or local-name() = "MEK_COMENT"]'
		  ,MEK_COMENT nvarchar(max) 'SANK/S_COM[text()!=""]'
		  ,MEK_COUNT int   'MEK_COUNT[text()!=""]'
		  ,MEE_COUNT int   'MEE_COUNT[text()!=""]'
		  ,OSP_COMENT nvarchar(1000) 'OSP_COMENT[text()!=""]'
		  , IDSP nvarchar(10) 'IDSP[text()!=""]'
	) sp
	join
OPENXML (@idpac, N'PERS_LIST/PERS',2)
            WITH (FAM nvarchar(30) 'FAM'
			,ID_PAC_P nvarchar(36) 'ID_PAC'
			, IM nvarchar(50) 'IM'
, OT nvarchar(50) 'OT[text()!=""]'
, W nvarchar(10) 'W[text()!=""]'
, DR nvarchar(100) 'DR[text()!=""]'
           ,[TEL] nvarchar(254) 'TEL[text()!=""]'
           ,[FAM_P] nvarchar(254) 'FAM_P[text()!=""]'
           ,[IM_P] nvarchar(254) 'IM_P[text()!=""]'
           ,[OT_P] nvarchar(254) 'OT_P[text()!=""]'
           ,[W_P] nvarchar(254) 'W_P[text()!=""]'
           ,[DR_P] date 'DR_P[text()!=""]'
           ,[MR] nvarchar(254) 'MR[text()!=""]'
, DOCTYPE nvarchar(10) 'DOCTYPE[text()!=""]'
, DOCSER nvarchar(18) 'DOCSER[text()!=""]'
, DOCNUM nvarchar(20) 'DOCNUM[text()!=""]'
, DOCDATE date 'DOCDATE[text()!=""]'
, DOCORG nvarchar(1000) 'DOCORG[text()!=""]'
, SNILS nvarchar(20) 'SNILS[text()!=""]'
, OKATOG nvarchar(20) 'OKATOG[text()!=""]'
, OKATOP nvarchar(20) 'OKATOP[text()!=""]'
,[COMENTP] nvarchar(254) 'COMENTP[text()!=""]' 
/*новые поля по 200 приказу */
,DOST nvarchar(20) 'DOST[text()!=""]' /*Код надежности идентификации пациента */
,DOST_P nvarchar(20) 'DOST_P[text()!=""]' /*Код надежности идентификации представителя */

			) p on sp.id_pac=p.id_pac_p
print error_message()


if @ver like '2.1%'	or @ver like '1.%'
	insert into #T_ZSL (	 SC,idcase ,ID_PAC ,VPOLIS ,   SPOLIS ,   NPOLIS,   SMO ,[ST_OKATO],[SMO_OGRN],[SMO_OK],[SMO_NAM] ,[INV] ,[MSE] 
	  ,Novor ,VNOV_D ,LPU_P,LPU_DATE,FAM, IM , OT, W , DR ,[TEL] ,[FAM_P],[IM_P],[OT_P],[W_P],[DR_P]
	  ,[MR], DOCTYPE , DOCSER, DOCNUM , SNILS , OKATOG , OKATOP ,[COMENTP]  
	
	,N_ZAP,PR_NOV , USL_OK, ZSL_ID , VIDPOM , FOR_POM ,NPR_MO,	NPR_DATE , LPU ,P_CEL
		  , VBR  , DATE_Z_1, DATE_Z_2 , DTP, T_ARRIVAL,[P_OTK] ,[RSLT_D],[KD_Z] ,[VNOV_M], RSLT, ISHOD 
		  ,[OS_SLUCH], OS_SLUCH_REGION , VOZR ,[VB_P], SUMV , SUMP ,[OPLATA],[SANK_IT], IDSP  )
	select distinct @sc,idcase 
	,ID_PAC ,VPOLIS ,   SPOLIS ,   NPOLIS,   SMO ,[ST_OKATO],[SMO_OGRN],[SMO_OK],[SMO_NAM] ,[INV] ,[MSE] 
	  ,Novor ,VNOV_D ,LPU_P,LPU_DATE,FAM, IM , OT, W , DR ,[TEL] ,[FAM_P],[IM_P],[OT_P],[W_P],[DR_P]
	  ,[MR], DOCTYPE , DOCSER, DOCNUM , SNILS , OKATOG , OKATOP ,[COMENTP]  
	
	,N_ZAP,PR_NOV , USL_OK, ZSL_ID , VIDPOM , FOR_POM ,NPR_MO,	NPR_DATE , LPU ,P_CEL
		  , VBR  , DATE_Z_1, DATE_Z_2 , DTP, T_ARRIVAL,[P_OTK] ,[RSLT_D],[KD_Z] ,[VNOV_M], RSLT, ISHOD 
		  ,[OS_SLUCH], OS_SLUCH_REGION , VOZR ,[VB_P], SUMV , SUMP ,[OPLATA],[SANK_IT], IDSP  
	FROM  OPENXML (@idsluch, N'ZL_LIST/ZAP/SLUCH',2)
	WITH (  idcase numeric(11,0) 'IDCASE'
			,ID_PAC nvarchar(36) '../PACIENT/ID_PAC'
			,VPOLIS nvarchar(36) '../PACIENT/VPOLIS[text()!=""]'
	  ,   SPOLIS nvarchar(20) '../PACIENT/SPOLIS[text()!=""]'
	  ,   NPOLIS nvarchar(20) '../PACIENT/NPOLIS[text()!=""]'
	  ,   SMO nvarchar(5) '../PACIENT/SMO[text()!=""]'
	  ,[ST_OKATO] nvarchar(254) '../PACIENT/ST_OKATO[text()!=""]'
	  ,[SMO_OGRN] nvarchar(254) '../PACIENT/SMO_OGRN[text()!=""]'
      ,[SMO_OK] nvarchar(254) '../PACIENT/SMO_OK[text()!=""]'
      ,[SMO_NAM] nvarchar(254) '../PACIENT/SMO_NAM[text()!=""]'
      ,[INV] nvarchar(254) '../PACIENT/INV[text()!=""]'
      ,[MSE] nvarchar(254) '../PACIENT/MSE[text()!=""]'
	  ,Novor nvarchar(9) '../PACIENT/NOVOR[text()!=""]'
	  ,VNOV_D int '../PACIENT/VNOV_D[text()!=""]'
	  ,LPU_P nvarchar(254) '../PACIENT/LPU_P[text()!=""]' /* для орла */
	  ,LPU_DATE date '../PACIENT/LPU_DATE[text()!=""]' /* для орла */
			,N_ZAP int '../N_ZAP'
			,PR_NOV int '../PR_NOV' /* признак исправленной записи */
		  , USL_OK int 'USL_OK'
		   ,P_CEL nvarchar(36) '*[contains(local-name(), "CEL")]' /* это в орле такое поле, и свой справочник целей */
		  , ZSL_ID nvarchar(36) '*[local-name() = "ZSL_ID" or local-name() = "IDCASE"] '
		  , VIDPOM int  'VIDPOM'
		  , FOR_POM int  'FOR_POM'
		  ,	NPR_MO nvarchar(10)   'NPR_MO'
		  ,	NPR_DATE date 'NPR_DATE'
		  , LPU nvarchar(10) 'LPU'
		  , VBR int 'VBR' 
		  , DATE_Z_1 date 'DATE_1'
		  , DATE_Z_2 date 'DATE_2'
		  , DTP int 'DTP'
		  , T_ARRIVAL int 'T_ARRIVAL'
		  ,[P_OTK] nvarchar(255) 'P_OTK' 
		  ,[RSLT_D] nvarchar(255) 'RSLT_D' 
		  ,[KD_Z] int 'KD_Z' 
		  ,[VNOV_M] nvarchar(255) 'VNOV_M' 
		  , RSLT nvarchar(10) 'RSLT'
		  , ISHOD nvarchar(10) 'ISHOD'
		  ,[OS_SLUCH] int 'OS_SLUCH'
		  , OS_SLUCH_REGION nvarchar(10) 'OS_SLUCH_REGION'
		  , VOZR nvarchar(10) 'VOZR' 
		  ,[VB_P] int '*[local-name() = "VB_P" or local-name() = "EXTR"]' /* запишем экстренных в это поле, так как в 2.1 оно ещё есть. */
		  , SUMV numeric(17,2) 'SUMV'
		  , SUMP numeric(17,2) 'SUMP'
		   ,[OPLATA] int 'OPLATA'
			,[SANK_IT] numeric(17,2) 'SANK_IT' 
		  , IDSP nvarchar(10) 'IDSP'
	) sp
	join
OPENXML (@idpac, N'PERS_LIST/PERS',2)
            WITH (FAM nvarchar(30) 'FAM'
			,ID_PAC_P nvarchar(36) 'ID_PAC'
			, IM nvarchar(50) 'IM'
, OT nvarchar(50) 'OT[text()!=""]'
, W nvarchar(10) 'W[text()!=""]'
, DR nvarchar(100) 'DR[text()!=""]'
           ,[TEL] nvarchar(254) 'TEL[text()!=""]'
           ,[FAM_P] nvarchar(254) 'FAM_P[text()!=""]'
           ,[IM_P] nvarchar(254) 'IM_P[text()!=""]'
           ,[OT_P] nvarchar(254) 'OT_P[text()!=""]'
           ,[W_P] nvarchar(254) 'W_P[text()!=""]'
           ,[DR_P] date 'DR_P[text()!=""]'
           ,[MR] nvarchar(254) 'MR[text()!=""]'
, DOCTYPE nvarchar(10) 'DOCTYPE[text()!=""]'
, DOCSER nvarchar(18) 'DOCSER[text()!=""]'
, DOCNUM nvarchar(20) 'DOCNUM[text()!=""]'
, SNILS nvarchar(20) 'SNILS[text()!=""]'
, OKATOG nvarchar(20) 'OKATOG[text()!=""]'
, OKATOP nvarchar(20) 'OKATOP[text()!=""]'
,[COMENTP] nvarchar(254) 'COMENTP[text()!=""]' 
			) p on sp.id_pac=p.id_pac_p
if @@ERROR<>0 set @i = @i+1
print '@zsl: '
/*теперь очищаем даты, которые ошибочные в хмл, чтобы из date преобразовалось нормально в datetime */
update #t_zsl set dr=null,MEK_COMENT='дата рождения некорректная' where year(dr)<1900 or year(dr)>2100
update #t_zsl set dr_p=null,MEK_COMENT='дата рождения представителя некорректная' where year(dr_p)<1900 or year(dr_p)>2100
update #t_zsl set npr_date=null,MEK_COMENT='дата направления некорректная' where year(npr_date)<1900 or year(npr_date)>2100
update #t_zsl set docdate=null,MEK_COMENT='дата документа некорректная' where year(docdate)<1900 or year(docdate)>2100


if @reg='59' set @sl = 'SLUCH'

set @path ='ZL_LIST/ZAP/Z_SL/'+@sl

if @ver like '3.%' or @ver like '4.%' or @ver like '5.%'

	insert into #T_SL (
	sc,SL_ID ,D3_ZSLGID,USL_OK ,[VID_HMP],[METOD_HMP]
	,MP_HMP
	,LPU_1,PODR,PROFIL,PROFIL_K
		 ,DET,P_CEL,[TAL_NUM],TAL_D,[TAL_P],NHISTORY,[P_PER],DATE_1,DATE_2,KD,DS0,DS1
		 ,[DS1_PR],[C_ZAB],DS_ONK,[DN],[CODE_MES1],[CODE_MES2],[N_KSG],[VER_KSG],[KSG_PG]
		 ,[N_KPG],[KOEF_Z],[KOEF_UP],[BZTSZ],[KOEF_D],[KOEF_U],[DKK1],[DKK2],[SL_K],[IT_SL] 
	,[REAB],PRVS,PRVD,VERS_SPEC,IDDOKT,ED_COL,TARIF,SUM_M,[COMENTSL]
	,KLPU,SZ,BRIGADA,N_BRIGADA,PRIEM_VIZ,PERED_VIZ,PRIB_VIZ,ADRES_VIZ,WEI
	)
	select distinct @sc, SL_ID  ,isnull(D3_ZSLGID,idcase) D3_ZSLGID,USL_OK ,[VID_HMP],[METOD_HMP]
	,MP_HMP
	,cast(LPU_1 as varchar(8)) LPU_1,PODR,PROFIL,PROFIL_K
		 ,DET,left(P_CEL,3) /* в алтае04 фонд добавляет, так получается:1.0.1 */
		 ,[TAL_NUM],TAL_D,[TAL_P],NHISTORY,[P_PER],DATE_1,DATE_2,KD,DS0,DS1
		 ,[DS1_PR],[C_ZAB],DS_ONK,[DN],[CODE_MES1],[CODE_MES2],[N_KSG],[VER_KSG],[KSG_PG]
		 ,[N_KPG],[KOEF_Z],[KOEF_UP],[BZTSZ],[KOEF_D],[KOEF_U],[DKK1],[DKK2],[SL_K],[IT_SL] 
	,[REAB],PRVS,PRVD,VERS_SPEC,IDDOKT,ED_COL,TARIF,SUM_M,left([COMENTSL],250)
	,KLPU,SZ,BRIGADA,N_BRIGADA,PRIEM_VIZ,PERED_VIZ,PRIB_VIZ,ADRES_VIZ,WEI
	FROM  OPENXML (@idsluch, @path,2)
	WITH (
		 SL_ID nvarchar(36) '*[local-name() = "CASEGUID" or local-name() = "SL_ID" ]'
		 ,D3_ZSLGID nvarchar(36) '../*[contains(local-name(), "SL_ID")  ] '/* связь с zsl (от гуида отказываюсь, это не по 79 приказу) */
		 ,idcase numeric(11,0) '../*[local-name() = "Z_SL_ID" or local-name() = "IDCASE"] '
		 ,USL_OK int 'USL_OK[text()!=""]'
		 ,[VID_HMP] nvarchar(254) 'VID_HMP[text()!=""]'
         ,[METOD_HMP] nvarchar(254) 'METOD_HMP[text()!=""]'
		 ,[MP_HMP] int 'MP_HMP[text()!=""]'
		 /*EXTR - экстренность сохранили в орле */
		 ,LPU_1 varchar(20) 'LPU_1[text()!=""]'
		 ,PODR varchar(20) 'PODR[text()!=""]'
		 ,PROFIL int 'PROFIL[text()!=""]'
		 ,PROFIL_K int 'PROFIL_K[text()!=""]'
		 ,DET int 'DET[text()!=""]'
		 ,P_CEL nvarchar(36) '*[(text()!="") and (local-name() = "P_CEL" or local-name() = "OBR") ]'
		 ,[TAL_NUM] nvarchar(254) 'TAL_NUM[text()!=""]' 
         ,[TAL_D] date 'TAL_D[text()!=""]'
         ,[TAL_P] date 'TAL_P[text()!=""]'
		 ,NHISTORY nvarchar(36) 'NHISTORY[text()!=""]' /* номер истории содержит запятую */
		 ,[P_PER] nvarchar(254) 'P_PER[text()!=""]'
		 ,DATE_1 date 'DATE_1[text()!=""]'
		 ,DATE_2 date 'DATE_2[text()!=""]'
		 ,KD int 'KD[text()!=""]'  
		 ,DS0 nvarchar(6) 'DS0[text()!=""]'
		 ,DS1 nvarchar(36) 'DS1[text()!=""]'
		 ,[DS1_PR] nvarchar(254) 'DS1_PR[text()!=""]'
         
		 ,[C_ZAB] int 'C_ZAB[text()!=""]'
		 
		 ,DS_ONK int 'DS_ONK[text()!=""]'


		 ,[DN] nvarchar(254) '*[local-name() = "DN" or local-name() = "PR_D_N"]' /* два поля записываем в одно. */
         ,[CODE_MES1] nvarchar(254) 'CODE_MES1[text()!=""]'
         ,[CODE_MES2] nvarchar(254) 'CODE_MES2[text()!=""]'
		 /* делаю по 79 приказу.  у нас  в курске отличается. */

		 /* */
		 ,[N_KSG] nvarchar(20) 'KSG_KPG/N_KSG[text()!=""]' /*Номер КСГ (V023) */
		 ,[VER_KSG] int 'KSG_KPG/VER_KSG[text()!=""]' /*Указывается версия модели определения КСГ (год) */
		 ,[KSG_PG] int 'KSG_KPG/KSG_PG[text()!=""]' /*KSG_PG 0 - подгруппа КСГ не применялась; 1 - подгруппа КСГ применялась */
		 ,[N_KPG] int 'KSG_KPG/N_KPG[text()!=""]'	/*Номер КПГ (V026). */
		 ,[KOEF_Z]  numeric(7,5) 'KSG_KPG/KOEF_Z[text()!=""]' /*Коэффициент затратоемкости	Значение коэффициента затратоемкости группы/подгруппы КСГ или КПГ */
		 ,[KOEF_UP]  numeric(7,5) 'KSG_KPG/KOEF_UP[text()!=""]' /*Управленческий коэффициент Значение управленческого коэффициента для КСГ или КПГ. При отсутствии указывается "1" */
		 ,[BZTSZ]  numeric(8,2) 'KSG_KPG/BZTSZ[text()!=""]' /*Базовая ставка Значение базовой ставки, указывается в рублях */
		 ,[KOEF_D]  numeric(7,5) 'KSG_KPG/KOEF_D[text()!=""]' /*Коэффициент дифференциации Значение коэффициента дифференциации */
		 ,[KOEF_U]  numeric(7,5) 'KSG_KPG/KOEF_U[text()!=""]' /*Коэффициент уровня/подуровня оказания медицинской помощи Значение коэффициента уровня/подуровня оказания медицинской помощи */
		 ,[DKK1] nvarchar(10) 'KSG_KPG/DKK1[text()!=""]' /*Дополнительный классификационный критерий */
		 ,[DKK2] nvarchar(10) 'KSG_KPG/DKK2[text()!=""]' /*Дополнительный классификационный критерий */
		 ,[SL_K] bit 'KSG_KPG/SL_K' /*Признак использования КСЛП 0 - КСЛП не применялся; 1 - КСЛП применялся */
		 ,[IT_SL] numeric(6,5) 'KSG_KPG/IT_SL[text()!=""]' /*Примененный коэффициент сложности лечения пациента Итоговое значение коэффициента сложности лечения пациента для данного случая. Указывается только при использовании. */
	
		/* */
         ,[REAB] nvarchar(254) 'REAB[text()!=""]'
		 ,PRVS int 'PRVS[text()!=""]'
		 ,PRVD int 'PRVD[text()!=""]' /** у орла есть код специальности специалиста АПУ */
		 ,VERS_SPEC nvarchar(36) 'VERS_SPEC[text()!=""]'
		 ,IDDOKT nvarchar(36) 'IDDOKT[text()!=""]'


		 ,ED_COL numeric(17,2) 'ED_COL[text()!=""]'
		 ,TARIF numeric(17,2) 'TARIF[text()!=""]'
		 ,SUM_M numeric(17,2) '*[(text()!="") and (local-name() = "SUM_M" or local-name() = "SUMV") ]'
		 ,[COMENTSL] nvarchar(254) 'COMENTSL[text()!=""]'
		 /*Калининград */
		 ,[KLPU] nvarchar(255) 'KLPU[text()!=""]'
		 ,[SZ] nvarchar(255) 'SZ[text()!=""]'
		 ,[BRIGADA] nvarchar(255) 'BRIGADA[text()!=""]'
		 ,[N_BRIGADA] nvarchar(255) 'N_BRIGADA[text()!=""]'
		 ,[PRIEM_VIZ] nvarchar(255) 'PRIEM_VIZ[text()!=""]'
		 ,[PERED_VIZ] nvarchar(255) 'PERED_VIZ[text()!=""]'
		 ,[PRIB_VIZ] nvarchar(255) 'PRIB_VIZ[text()!=""]'
		 ,[ADRES_VIZ] nvarchar(255) 'ADRES_VIZ[text()!=""]'
		 ,[WEI] numeric(4,1) 'WEI[text()!=""]'
		) 



set @path ='ZL_LIST/ZAP/Z_SL/'+@sl+'/LEK_PR'

if @ver like '3.%' or @ver like '4.%' or @ver like '5.%'
	insert into #T_LEK_PR_COV(
			sc
           ,[D3_SLGID]
		   ,[D3_ZSLGID]
           ,[DATA_INJ]
           ,[CODE_SH]
           ,[REG_NUM]
           ,[COD_MARK]
           ,[ED_IZM]
           ,[DOSE_INJ]
           ,[METHOD_INJ]
           ,[COL_INJ])

	select distinct 
	        @sc
           ,[D3_SLGID]
		   ,isnull([D3_ZSLGID],idcase)
           ,[DATA_INJ]
           ,[CODE_SH]
           ,[REG_NUM]
           ,[COD_MARK]
           ,[ED_IZM]
           ,[DOSE_INJ]
           ,[METHOD_INJ]
           ,[COL_INJ]
		   
FROM  OPENXML (@idsluch, @path,2)
with (
	--[D3_SLID] int ''
    [D3_SLGID] nvarchar(36) '../*[local-name() = "CASEGUID" or local-name() = "SL_ID" ]' /* связь с посещением */
		,D3_ZSLGID nvarchar(36) '../../*[contains(local-name(), "SL_ID")  ] '
		,idcase numeric(11,0) '../../*[local-name() = "Z_SL_ID" or local-name() = "IDCASE"] '
    ,[DATA_INJ] date 'DATA_INJ[text()!=""]'
    ,[CODE_SH] varchar(50) 'CODE_SH[text()!=""]'
    ,[REG_NUM] varchar(6) 'REGNUM[text()!=""]'
    ,[COD_MARK] varchar(100) 'COD_MARK[text()!=""]'
    ,[ED_IZM] varchar(3) 'LEK_DOSE/ED_IZM[text()!=""]'
    ,[DOSE_INJ] numeric(7,2) 'LEK_DOSE/DOSE_INJ[text()!=""]'
    ,[METHOD_INJ] varchar(3) 'LEK_DOSE/METHOD_INJ[text()!=""]'
    ,[COL_INJ] numeric(5,0) 'LEK_DOSE/COL_INJ[text()!=""]'	   
	)



set @path ='ZL_LIST/ZAP/Z_SL/'+@sl+'/KSG_KPG'
if @ver like '3.%' or @ver like '4.%' or @ver like '5.%'
 insert into #T_SL_FK (D3_SLGID,D3_ZSLGID,N_KSG,VER_KSG,KSG_PG,N_KPG,KOEF_Z,KOEF_UP,BZTSZ,KOEF_D,KOEF_U,DKK1,DKK2,SL_K,IT_SL)
	select distinct SL_ID,isnull(D3_ZSLGID,idcase) D3_ZSLGID,N_KSG,isnull(VER_KSG,year(getdate())),KSG_PG,N_KPG,KOEF_Z,KOEF_UP,BZTSZ,KOEF_D,KOEF_U,DKK1,DKK2,SL_K,IT_SL
FROM  OPENXML (@idsluch, @path,2)
WITH ( SL_ID nvarchar(36) '../*[local-name() = "CASEGUID" or local-name() = "SL_ID" ]' /*связка со случаем и с посещением. */
	 ,D3_ZSLGID nvarchar(36) '../../*[contains(local-name(), "SL_ID")  ] '
	 ,idcase numeric(11,0) '../../*[local-name() = "Z_SL_ID" or local-name() = "IDCASE"] '
,N_KSG nvarchar(20)  '*[text()!="" and (local-name() = "N_KSG" or local-name() = "KSG") ]'
,VER_KSG int  'VER_KSG[text()!=""]'
,KSG_PG bit  'KSG_PG[text()!=""]'
,N_KPG int  'N_KPG[text()!=""]'
,KOEF_Z numeric(7,5) 'KOEF_Z[text()!=""]'
,KOEF_UP numeric(7,5) 'KOEF_UP[text()!=""]'
,BZTSZ numeric(8,2) 'BZTSZ[text()!=""]'
,KOEF_D numeric(7,5) 'KOEF_D[text()!=""]'
,KOEF_U numeric(7,5) 'KOEF_U[text()!=""]'
,DKK1 nvarchar(10)  '*[local-name() = "DKK1" or local-name() = "CRIT"]'
,DKK2 nvarchar(10)  'DKK2[text()!=""]'
,SL_K bit 'SL_K[text()!=""]'
,IT_SL numeric(6,5) 'IT_SL[text()!=""]'
)


set @path ='ZL_LIST/ZAP/Z_SL/'+@sl+'/NAPR'
if @ver like '3.%' or @ver like '4.%' or @ver like '5.%'
 insert into #T_SL_FK (D3_SLGID,D3_ZSLGID,NAPR_DATE,NAPR_MO,NAPR_V,MET_ISSL,NAPR_USL)
	 select distinct D3_SLGID,isnull(D3_ZSLGID,idcase) D3_ZSLGID,NAPR_DATE,NAPR_MO,NAPR_V,MET_ISSL,NAPR_USL
	FROM  OPENXML (@idsluch,@path,2)
	WITH ( 
	 D3_SLGID nvarchar(36) '../*[local-name() = "CASEGUID" or local-name() = "SL_ID" ]' /*связка со случаем и с посещением. */
	 ,D3_ZSLGID nvarchar(36) '../../*[contains(local-name(), "SL_ID") ] '
	 ,idcase numeric(11,0) '../../*[local-name() = "Z_SL_ID" or local-name() = "IDCASE"] '
	,NAPR_DATE datetime 'NAPR_DATE[text()!=""]'
	,NAPR_MO nvarchar(6) 'NAPR_MO[text()!=""]'
	,NAPR_V int 'NAPR_V[text()!=""]'
	,MET_ISSL int 'MET_ISSL[text()!=""]'
	,NAPR_USL nvarchar(16)  'NAPR_USL[text()!=""]'	)



set @path ='ZL_LIST/ZAP/Z_SL/'+@sl+'/CONS'
if @ver like '3.%' or @ver like '4.%' or @ver like '5.%'
 insert into #T_SL_FK (D3_SLGID,D3_ZSLGID,PR_CONS,DT_CONS)
		 select distinct D3_SLGID,isnull(D3_ZSLGID,idcase) D3_ZSLGID,PR_CONS,DT_CONS
		FROM  OPENXML (@idsluch,@path,2)
		WITH ( 
		D3_SLGID nvarchar(36) '../*[local-name() = "CASEGUID" or local-name() = "SL_ID" ]'
		 ,D3_ZSLGID nvarchar(36) '../../*[contains(local-name(), "SL_ID") ] '
		 ,idcase numeric(11,0) '../../*[local-name() = "Z_SL_ID" or local-name() = "IDCASE"] '
		,PR_CONS int 'PR_CONS[text()!=""]'
		,DT_CONS datetime 'DT_CONS[text()!=""]'
		) p /*where PR_CONS is not null */


if @@ERROR<>0 set @i = @i+1


set @path ='ZL_LIST/ZAP/Z_SL/'+@sl+'/ONK_SL'
if @ver like '3.%' or @ver like '4.%' or @ver like '5.%'
 insert into #T_SL_FK (D3_SLGID,D3_ZSLGID,DS1_T,STAD,ONK_T,ONK_N,ONK_M,MTSTZ,SOD,K_FR 	,[WEI] ,[HEI] 	,[BSA] )
	 select distinct D3_SLGID,isnull(D3_ZSLGID,idcase) D3_ZSLGID,DS1_T,STAD,ONK_T,ONK_N,ONK_M,MTSTZ,SOD,K_FR 	,[WEI] ,[HEI] 	,[BSA] 
	FROM  OPENXML (@idsluch,@path,2)
	WITH (
	D3_SLGID nvarchar(36) '../*[local-name() = "CASEGUID" or local-name() = "SL_ID" ]'
	,D3_ZSLGID nvarchar(36) '../../*[contains(local-name(), "SL_ID") ] '
	 ,idcase numeric(11,0) '../../*[local-name() = "Z_SL_ID" or local-name() = "IDCASE"] '
	,DS1_T int 'DS1_T[text()!=""]' 
	,STAD int 'STAD[text()!=""]'
	,ONK_T int 'ONK_T[text()!=""]'
	,ONK_N int 'ONK_N[text()!=""]'
	,ONK_M int 'ONK_M[text()!=""]'
	,MTSTZ int 'MTSTZ[text()!=""]'
	,SOD numeric(6,2) 'SOD[text()!=""]'
	,	K_FR int 'K_FR[text()!=""]'
	,[WEI] [numeric](4, 1) 'WEI[text()!=""]'
	,[HEI] int 'HEI[text()!=""]'
	,[BSA] nvarchar(6) 'BSA[text()!=""]'
	)  p /*where STAD is not null */



set @path ='ZL_LIST/ZAP/Z_SL/'+@sl+'/ONK_SL/B_DIAG'
/*сюда нужно вставить подгруппы внутри онкологии */
 insert into #T_SL_FK (D3_SLGID,D3_ZSLGID,DIAG_DATE,DIAG_TIP,DIAG_CODE,DIAG_RSLT,REC_RSLT)
	 select distinct D3_ONKSLGID,isnull(D3_ZSLGID,idcase) D3_ZSLGID,DIAG_DATE,DIAG_TIP,DIAG_CODE,DIAG_RSLT,REC_RSLT
	FROM  OPENXML (@idsluch,@path,2)
	WITH (
	 D3_ONKSLGID nvarchar(36) '../../*[local-name() = "CASEGUID" or local-name() = "SL_ID" ]' /*онкослучай может быть только один в случае. */
	,D3_ZSLGID nvarchar(36) '../../../*[contains(local-name(), "SL_ID")  ]'
	 ,idcase numeric(11,0) '../../../*[local-name() = "Z_SL_ID" or local-name() = "IDCASE"] '
	,DIAG_DATE datetime 'DIAG_DATE[text()!=""]'
	,DIAG_TIP int 'DIAG_TIP[text()!=""]'
	,DIAG_CODE int 'DIAG_CODE[text()!=""]'
	,DIAG_RSLT int 'DIAG_RSLT[text()!=""]'
	,REC_RSLT int 'REC_RSLT[text()!=""]'
	)  p /*where (DIAG_DATE is not null) or (DIAG_TIP is not null) --обязательно или то или другое. */

 
set @path ='ZL_LIST/ZAP/Z_SL/'+@sl+'/ONK_SL/B_PROT' 
 insert into #T_SL_FK (D3_SLGID,D3_ZSLGID,PROT,D_PROT)
		select distinct D3_ONKSLGID,isnull(D3_ZSLGID,idcase) D3_ZSLGID,PROT,D_PROT
	FROM  OPENXML (@idsluch,@path,2)
	WITH ( D3_ONKSLGID nvarchar(36) '../../*[local-name() = "CASEGUID" or local-name() = "SL_ID" ]' /*онкослучай может быть только один в случае. */
	,D3_ZSLGID nvarchar(36) '../../../*[contains(local-name(), "SL_ID") ] '
	 ,idcase numeric(11,0) '../../../*[local-name() = "Z_SL_ID" or local-name() = "IDCASE"] '
	,PROT int 'PROT[text()!=""]'
	,D_PROT datetime 'D_PROT[text()!=""]'
	)  p /*where PROT is not null */


 set @path ='ZL_LIST/ZAP/Z_SL/'+@sl+'/ONK_SL/ONK_USL' 
 insert into #T_SL_FK (D3_SLGID,D3_ZSLGID,USL_TIP,HIR_TIP,LEK_TIP_L,LEK_TIP_V,LUCH_TIP,PPTR)
	 select distinct D3_ONKSLGID,isnull(D3_ZSLGID,idcase) D3_ZSLGID,USL_TIP,HIR_TIP,LEK_TIP_L,LEK_TIP_V,LUCH_TIP,PPTR
	FROM  OPENXML (@idsluch,@path,2)
	WITH ( D3_ONKSLGID nvarchar(36) '../../*[local-name() = "CASEGUID" or local-name() = "SL_ID" ]' /*онкослучай может быть только один в случае. */
	,D3_ZSLGID nvarchar(36) '../../../*[contains(local-name(), "SL_ID")  ]'
	,idcase numeric(11,0) '../../../*[local-name() = "Z_SL_ID" or local-name() = "IDCASE"] '
	,USL_TIP int 'USL_TIP[text()!=""]'
	,HIR_TIP int 'HIR_TIP[text()!=""]'
	,LEK_TIP_L int 'LEK_TIP_L[text()!=""]'
	,LEK_TIP_V int 'LEK_TIP_V[text()!=""]'
	,LUCH_TIP int 'LUCH_TIP[text()!=""]'
	,PPTR int 'PPTR[text()!=""]'
	) p where USL_TIP is not null


 set @path ='ZL_LIST/ZAP/Z_SL/'+@sl+'/ONK_SL/ONK_USL/LEK_PR' 
 insert into #T_SL_FK (D3_SLGID,D3_ZSLGID,USL_TIP,REGNUM,DATE_INJ,CODE_SH,LEK_PR_ID,LEK_PR_GUID)
 select distinct D3_ONKUSLGID,isnull(D3_ZSLGID,idcase) D3_ZSLGID,USL_TIP,REGNUM,DATE_INJ,CODE_SH,HASHBYTES('SHA1', 'SL_ID' + SL_ID + 'REGNUM' + REGNUM + 'CODE_SH' + CODE_SH), newid()
FROM  OPENXML (@idsluch,@path,2)
WITH ( 
D3_ONKUSLGID nvarchar(36) '../../../*[local-name() = "CASEGUID" or local-name() = "SL_ID" ]' /*предположим что онкоуслуга только одна, ибо хз как привязывать */
,D3_ZSLGID nvarchar(36) '../../../../*[contains(local-name(), "SL_ID")  ]'
,idcase numeric(11,0) '../../../../*[local-name() = "Z_SL_ID" or local-name() = "IDCASE"] '
,USL_TIP int '../USL_TIP[text()!=""]' /* для того чтобы привязать к лекарственной терапии конкретно */
,REGNUM nvarchar(40) 'REGNUM[text()!=""]'
,REGNUM_DOP nvarchar(25) 'REGNUM_DOP[text()!=""]'
,DATE_INJ datetime 'DATE_INJ[text()!=""]'
,CODE_SH nvarchar(10) 'CODE_SH[text()!=""]'
,SL_ID nvarchar(36) '../../../SL_ID[text()!=""]'
)  p /*where REGNUM is not null */

set @path ='ZL_LIST/ZAP/Z_SL/'+@sl+'/ONK_SL/ONK_USL/LEK_PR/INJ' 
if @ver like '5.%'
insert into #T_INJ (LEK_PR_ID, LEK_PR_GUID, DATE_INJ, KV_INJ, KIZ_INJ, S_INJ, SV_INJ, SIZ_INJ, RED_INJ)
select 
HASHBYTES('SHA1', 'SL_ID' + t.SL_ID + 'REGNUM' + t.REGNUM + 'CODE_SH' + t.CODE_SH), tt.LEK_PR_GUID, t.DATE_INJ, t.KV_INJ, t.KIZ_INJ, t.S_INJ, t.SV_INJ, t.SIZ_INJ, t.RED_INJ
from OPENXML (@idsluch,@path,2)
WITH (
SL_ID nvarchar(36) '../../../../SL_ID[text()!=""]',
REGNUM nvarchar(40) '../REGNUM[text()!=""]',
CODE_SH nvarchar(10) '../CODE_SH[text()!=""]',
DATE_INJ datetime 'DATE_INJ[text()!=""]',
KV_INJ numeric(11,3) 'KV_INJ[text()!=""]', 
KIZ_INJ numeric(11,3) 'KIZ_INJ[text()!=""]', 
S_INJ numeric(21,6) 'S_INJ[text()!=""]', 
SV_INJ numeric(17,2) 'SV_INJ[text()!=""]', 
SIZ_INJ numeric(17,2) 'SIZ_INJ[text()!=""]', 
RED_INJ int 'RED_INJ[text()!=""]'
) t
join #T_SL_FK tt on HASHBYTES('SHA1', 'SL_ID' + t.SL_ID + 'REGNUM' + t.REGNUM + 'CODE_SH' + t.CODE_SH) = tt.LEK_PR_ID


 set @path ='ZL_LIST/ZAP/Z_SL/'+@sl+'/NAZ' 
if @reg='59' set @path ='ZL_LIST/ZAP/Z_SL/'+@sl+'/NAZ_DISP' 

 insert into #T_SL_FK (D3_SLGID,D3_ZSLGID,NAZ_N,NAZ_R,NAZ_SP,NAZ_V,NAZ_USL,NAPR_DATE,NAPR_MO,NAZ_PMP,NAZ_PK, NAZ_IDDOKT)
 select distinct D3_SLGID,isnull(D3_ZSLGID,idcase) D3_ZSLGID,NAZ_N,NAZ_R,NAZ_SP,NAZ_V,NAZ_USL,NAPR_DATE,NAPR_MO,NAZ_PMP,NAZ_PK,NAZ_IDDOKT
	FROM  OPENXML (@idsluch,@path,2)
	WITH ( 
	D3_SLGID nvarchar(36) '../*[local-name() = "CASEGUID" or local-name() = "SL_ID" ]'
	,D3_ZSLGID nvarchar(36) '../../*[contains(local-name(), "SL_ID")  ]'
	,idcase numeric(11,0) '../../*[local-name() = "Z_SL_ID" or local-name() = "IDCASE"] '
	,NAZ_N int '*[(text()!="") and (local-name() = "NAZ_N" or local-name() = "NAZN") ]'
	,NAZ_R int '*[(text()!="") and (local-name() = "NAZ_R" or local-name() = "NAZR") ]'
	,NAZ_SP int 'NAZ_SP[text()!=""]'
	,NAZ_V int 'NAZ_V[text()!=""]'
	,NAZ_USL nvarchar(16) 'NAZ_USL[text()!=""]'
	,NAPR_DATE datetime 'NAPR_DATE[text()!=""]'
	,NAPR_MO nvarchar(6) 'NAPR_MO[text()!=""]'
	,NAZ_PMP int 'NAZ_PMP[text()!=""]'
	,NAZ_PK int 'NAZ_PK[text()!=""]'
	,NAZ_IDDOKT nvarchar(25) 'NAZ_IDDOKT[text()!=""]'
	) p /*where NAZ_N is not null */



if @ver like '2.1%'	or @ver like '1.%'
	insert into #T_SL (
	SL_ID ,D3_ZSLGID,USL_OK ,[VID_HMP],[METOD_HMP],LPU_1,PODR,PROFIL,PROFIL_K
		 ,DET,P_CEL,[TAL_NUM],TAL_D,[TAL_P],NHISTORY,[P_PER],DATE_1,DATE_2,KD,DS0,DS1
		 ,[DS1_PR],[C_ZAB],DS_ONK,[DN],[CODE_MES1],[CODE_MES2],[N_KSG],[VER_KSG],[KSG_PG]
		 ,[N_KPG],[KOEF_Z],[KOEF_UP],[BZTSZ],[KOEF_D],[KOEF_U],[DKK1],[DKK2],[SL_K],[IT_SL] 
	,[REAB],PRVS,PRVD,VERS_SPEC,IDDOKT,ED_COL,TARIF,SUM_M,[COMENTSL] )
	select distinct * 
	FROM  OPENXML (@idsluch, N'ZL_LIST/ZAP/SLUCH',2)
	WITH (
		 SL_ID nvarchar(36) 'IDCASE'
		 ,D3_ZSLGID nvarchar(36) 'IDCASE' /* связь с zsl */
		 ,USL_OK int 'USL_OK'
		 ,[VID_HMP] nvarchar(254) 'VID_HMP'
         ,[METOD_HMP] nvarchar(254) 'METOD_HMP'
		 ,LPU_1 varchar(20) 'LPU_1' /* в орле неверно используют данное поле, ставят туда полный код чего-то */
		 ,PODR varchar(20) 'PODR'
		 ,PROFIL int 'PROFIL'
		 ,PROFIL_K int 'PROFIL_K'
		 ,DET int 'DET'
		 ,P_CEL nvarchar(36) '*[contains(local-name(), "CEL")]' /* в орле CEL_P , и свой справочник целей */
		 ,[TAL_NUM] nvarchar(254) 'TAL_NUM'
         ,[TAL_D] date 'TAL_D' 
         ,[TAL_P] date 'TAL_P' 
		 ,NHISTORY nvarchar(36) 'NHISTORY' /* номер истории содержит запятую */
		 ,[P_PER] nvarchar(254) 'P_PER' /* есть */
		 ,DATE_1 date 'DATE_1'
		 ,DATE_2 date 'DATE_2'
		 ,KD int 'KD'  
		 ,DS0 nvarchar(6) 'DS0'
		 ,DS1 nvarchar(36) 'DS1'
		 ,[DS1_PR] nvarchar(254) 'DS1_PR' 
		 ,DS_ONK int 'DS_ONK[text()!=""]'
		 ,[C_ZAB] int 'C_ZAB[text()!=""]'
         ,[DN] nvarchar(254) '*[local-name() = "DN" or local-name() = "PR_D_N"]' /* два поля записываем в одно. */
         ,[CODE_MES1] nvarchar(254) 'CODE_MES1' 
         ,[CODE_MES2] nvarchar(254) 'CODE_MES2'
		  
		 ,[N_KSG] nvarchar(20) '*[local-name() = "CODE_KSG" or local-name() = "N_KSG"]' /*'CODE_KSG' --так в орле  */
		 ,[VER_KSG] int 'VER_KSG' /*Указывается версия модели определения КСГ (год) */
		 ,[KSG_PG] int '*[local-name() = "IDTKSG" or local-name() = "KSG_PG"]' /*'IDTKSG' --так в орле (какой-то доп критерий) */
		 ,[N_KPG] int 'N_KPG'	/*Номер КПГ (V026). */
		 ,[KOEF_Z]  numeric(7,5) 'KOEF_Z' /*в 3.0 */
		 ,[KOEF_UP]  numeric(7,5) 'KOEF_UP' /*в 3.0 */
		 ,[BZTSZ]  numeric(8,2) 'BZTSZ' /*в 3.0 */
		 ,[KOEF_D]  numeric(7,5) 'KOEF_D' /*в 3.0 */
		 ,[KOEF_U]  numeric(7,5) 'KOEF_U' /*в 3.0 */
		 ,[DKK1] nvarchar(10) 'DKK1' /*в 3.0 */
		 ,[DKK2] nvarchar(10) 'DKK2' /*в 3.0 */
		 ,[SL_K] bit 'SL_K' /*Признак использования КСЛП 0 - КСЛП не применялся; 1 - КСЛП применялся */
		 ,[IT_SL] numeric(6,5) 'IT_SL'    
 
         ,[REAB] nvarchar(254) 'REAB' 
		 ,PRVS int 'PRVS'
		 ,PRVD int 'PRVD'
		 ,VERS_SPEC nvarchar(36) 'VERS_SPEC'
		 ,IDDOKT nvarchar(36) 'IDDOKT'
		 ,ED_COL numeric(17,2) 'ED_COL'
		 ,TARIF numeric(17,2) 'TARIF'
		 ,SUM_M numeric(17,2) 'SUMV'
		 ,[COMENTSL] nvarchar(254) 'COMENTSL' 
		 
	)
if @@ERROR<>0 set @i = @i+1
print '@sl: '

/* коэффициенты в ксг */
 set @path ='ZL_LIST/ZAP/Z_SL/'+@sl+'/KSG_KPG/SL_KOEF' 
	insert into #T_SL_FK (D3_SLGID,[D3_ZSLGID],IDSL,Z_SL)
	select [SL_ID],isnull(D3_ZSLGID,idcase) D3_ZSLGID,IDSL,Z_SL
	FROM  OPENXML (@idsluch, @path,2)
	WITH (
		 SL_ID nvarchar(36) '../../*[local-name() = "CASEGUID" or local-name() = "SL_ID" ]'
		,D3_ZSLGID nvarchar(36) '../../../*[contains(local-name(), "SL_ID")  ]'
		,idcase numeric(11,0) '../../../*[local-name() = "Z_SL_ID" or local-name() = "IDCASE"] '
		,IDSL int 'IDSL[text()!=""]' /*Номер коэффициента сложности лечения пациента */
		,Z_SL numeric(6,5) '*[local-name() = "SL_KOEF_ZN" or local-name() = "Z_SL"]' /* Значение коэффициента сложности лечения пациента */
		 )	/*SL_KOEF_ZN - пермь */
		 if @@ERROR<>0 set @i = @i+1
print '@sl_koef: '
/*логи */
/*D3_USL_OMS */
 set @path ='ZL_LIST/ZAP/Z_SL/'+@sl+'/USL' 
if @ver like '3.%' or @ver like '4.%' or @ver like '5.%'/* обязателен тот порядок полей, какой и в объявлении таблицы. */
	insert into  #T_USL (sc,IDSERV ,[D3_SLGID] ,D3_ZSLGID,LPU 
		,LPU_1 ,PODR ,PROFIL,VID_VME,DET ,DATE_IN,DATE_OUT ,P_OTK ,DS,CODE_USL
		,KOL_USL,TARIF,SUMV_USL,PRVS,PRVD,CODE_MD,NPL,COMENTU)
	select distinct @sc,IDSERV ,[D3_SLGID] ,isnull(D3_ZSLGID,idcase) D3_ZSLGID,LPU 
		,cast(LPU_1 as varchar(8)) LPU_1 ,PODR ,PROFIL,cast([VID_VME] as nvarchar(16)) VID_VME,DET ,DATE_IN,DATE_OUT ,P_OTK ,DS,CODE_USL
		,KOL_USL,TARIF,SUMV_USL, ISNULL(PRVS_MR, PRVS) as PRVS ,PRVD, ISNULL(CODE_MD_MR, CODE_MD) AS CODE_MD, NPL,COMENTU
	FROM  OPENXML (@idsluch,@path,2)

	WITH (
		IDSERV varchar(36) 'IDSERV'
		,[D3_SLGID] nvarchar(36) '../*[local-name() = "CASEGUID" or local-name() = "SL_ID" ]' /* связь с посещением */
		,D3_ZSLGID nvarchar(36) '../../*[contains(local-name(), "SL_ID")  ] '
		,idcase numeric(11,0) '../../*[local-name() = "Z_SL_ID" or local-name() = "IDCASE"] '
		,LPU int 'LPU[text()!=""]'
		,LPU_1 varchar(200) 'LPU_1[text()!=""]'
		,PODR varchar(20) 'PODR[text()!=""]'
		,PROFIL int 'PROFIL[text()!=""]'
		,VID_VME nvarchar(36) 'VID_VME[text()!=""]'
		,DET int 'DET[text()!=""]'
		,DATE_IN date 'DATE_IN[text()!=""]'
		,DATE_OUT date 'DATE_OUT[text()!=""]'
		,P_OTK int 'P_OTK[text()!=""]'
		,DS nvarchar(36) 'DS[text()!=""]'
		,CODE_USL nvarchar(36) 'CODE_USL[text()!=""]'
		,KOL_USL nvarchar(36) 'KOL_USL[text()!=""]'
		,TARIF nvarchar(36) 'TARIF[text()!=""]'
		,SUMV_USL nvarchar(36) 'SUMV_USL[text()!=""]'


		, PRVS int 'PRVS[text() != ""]'
		, PRVS_MR int 'MR_USL_N/PRVS[text() != ""]'
		--PRVS int '//*[contains(local-name(), "PRVS")]'
		--, PRVS int './/*[contains(local-name(), "PRVS")]'
		


		,PRVD int 'PRVD[text()!=""]' /* у орла. АПУ */
		,CODE_MD nvarchar(36) 'CODE_MD[text() != ""]'
		,CODE_MD_MR nvarchar(36) 'MR_USL_N/CODE_MD[text() != ""]'
		--,CODE_MD nvarchar(36) 'CODE_MD[text()!=""]'
		,NPL int 'NPL[text()!=""]'
		,COMENTU nvarchar(255) 'COMENTU[text()!=""]'

		--,CODE_MEDDEV int 'MED_DEV/CODE_MEDDEV[text()!=""]'
		--,NUMBER_SER nvarchar(100) 'MED_DEV/NUMBER_SER[text()!=""]'
		--,DATE_MED nvarchar(36) 'MED_DEV/DATE_MED[text()!=""]'
	)

if @ver like '2.1%'	or @ver like '1.%'
	insert into  #T_USL (sc,IDSERV ,[D3_SLGID] ,D3_ZSLGID,LPU 
		,LPU_1 ,PODR ,PROFIL,VID_VME,DET ,DATE_IN,DATE_OUT ,P_OTK ,DS,CODE_USL
		,KOL_USL,TARIF,SUMV_USL,PRVS,PRVD,CODE_MD,NPL,COMENTU )
	select distinct @sc,IDSERV ,[D3_SLGID] ,D3_ZSLGID,LPU 
		,LPU_1 ,PODR ,PROFIL,VID_VME,DET ,DATE_IN,DATE_OUT ,P_OTK ,DS,CODE_USL
		,KOL_USL,TARIF,SUMV_USL,PRVS,PRVD,CODE_MD,NPL,COMENTU 
	FROM  OPENXML (@idsluch, N'ZL_LIST/ZAP/SLUCH/USL',2)
	WITH (
		IDSERV varchar(36) 'IDSERV'
		,[D3_SLGID] nvarchar(36) '../IDCASE' /* связь с посещением */
		,D3_ZSLGID nvarchar(36) '../*[contains(local-name(), "SL_ID") or local-name() = "IDCASE" ] ' /* связь с случаем */
		,LPU int 'LPU'
		,LPU_1 varchar(200) 'LPU_1'
		,PODR varchar(20) 'PODR'
		,PROFIL int 'PROFIL'
		,VID_VME nvarchar(36) 'VID_VME'
		,DET int 'DET'
		,DATE_IN nvarchar(36) 'DATE_IN'
		,DATE_OUT nvarchar(36) 'DATE_OUT'
		,P_OTK int 'P_OTK'
		,DS nvarchar(36) 'DS'
		,CODE_USL nvarchar(36) 'CODE_USL'
		,KOL_USL nvarchar(36) 'KOL_USL'
		,TARIF nvarchar(36) 'TARIF'
		,SUMV_USL nvarchar(36) 'SUMV_USL'
		,PRVS int 'PRVS'
		,PRVD int 'PRVD'
		,CODE_MD nvarchar(36) 'CODE_MD'
		,NPL int 'NPL'
		,COMENTU nvarchar(255) 'COMENTU'
	)
	if @@ERROR<>0 set @i = @i+1
print '@usl'
/*логи */
/*
INSERT INTO @D3_CRIT_OMS (D3_ZSLGID,D3_SLGID,CRIT)
	select 
	    sl.m.value('(../../IDCASE			)[1]','nvarchar(254)') as D3_ZSLGID 
	   ,sl.m.value('(../SL_ID			)[1]','nvarchar(254)') as D3_SLGID
      ,c.m.value('(.		)[1]','nvarchar(254)') as CRIT
	from @XmlH.nodes( N'ZL_LIST/ZAP/Z_SL/SL/KSG_KPG' ) sl(m)
		cross apply sl.m.nodes( 'CRIT') c(m)
*/

set @path ='ZL_LIST/ZAP/Z_SL/'+@sl+'/USL/MED_DEV' 
if @ver like '3.%' or @ver like '4.%'  or @ver like '5.%'
	insert into #T_MEDDEV (sc, D3_ZSLGID ,D3_SLGID, IDSERV, DATE_MED, CODE_MEDDEV, NUMBER_SER)
	select distinct @sc, D3_ZSLGID ,D3_SLGID, IDSERV, DATE_MED, CODE_MEDDEV, NUMBER_SER
	from OPENXML (@idsluch,@path,2)
	with (
		D3_ZSLGID nvarchar(36) '../../../*[contains(local-name(), "SL_ID")  ] '
		,D3_SLGID nvarchar(36) '../../*[local-name() = "CASEGUID" or local-name() = "SL_ID" ]'
		,IDSERV int '../*[local-name() = "IDSERV"]'
		,DATE_MED nvarchar(36) 'DATE_MED[text()!=""]'
		,CODE_MEDDEV int 'CODE_MEDDEV[text()!=""]'
		,NUMBER_SER nvarchar(100) 'NUMBER_SER[text()!=""]'
	)

set @path ='ZL_LIST/ZAP/Z_SL/'+@sl+'/KSG_KPG/CRIT' 
INSERT INTO #T_SL_FK (D3_ZSLGID,D3_SLGID,CRIT)
 SELECT isnull(D3_ZSLGID,idcase) D3_ZSLGID, D3_SLGID, CRIT FROM openxml(@idsluch, @path, 2)
    WITH
    (
       D3_ZSLGID VARCHAR(36) '../../../*[contains(local-name(), "ZSL_ID")  ] '
	   ,idcase numeric(11,0) '../../../*[local-name() = "Z_SL_ID" or local-name() = "IDCASE"] '
		,D3_SLGID VARCHAR(36) '../../*[local-name() = "CASEGUID" or local-name() = "SL_ID" ]',
      CRIT VARCHAR(10) '.'
    )
set @path ='ZL_LIST/ZAP/Z_SL/'+@sl+'/DS3' 
INSERT INTO #T_SL_FK (D3_ZSLGID,[D3_SLGID],[DS],DS_PR,[DS_TYPE], PR_DS2_N)
 SELECT isnull(D3_ZSLGID,idcase) D3_ZSLGID, D3_SLGID, DS,NULL,3,null FROM openxml(@idsluch, @path, 2)
    WITH
    (
       D3_ZSLGID VARCHAR(36) '../../*[contains(local-name(), "ZSL_ID") ] '
	    ,idcase numeric(11,0) '../../*[local-name() = "Z_SL_ID" or local-name() = "IDCASE"] '
		,D3_SLGID VARCHAR(36) '../*[local-name() = "CASEGUID" or local-name() = "SL_ID" ]',
      DS VARCHAR(10) '.'  
    )

set @path ='ZL_LIST/ZAP/Z_SL/'+@sl+'/DS2' 
INSERT INTO #T_SL_FK (D3_ZSLGID,[D3_SLGID],[DS],DS_PR,[DS_TYPE], PR_DS2_N)
	 SELECT isnull(D3_ZSLGID,idcase) D3_ZSLGID, D3_SLGID, DS,NULL,2,null FROM openxml(@idsluch, @path, 2)
    WITH
    (
       D3_ZSLGID VARCHAR(36) '../../*[contains(local-name(), "ZSL_ID") ] '
	   ,idcase numeric(11,0) '../../*[local-name() = "Z_SL_ID" or local-name() = "IDCASE"] '
		,D3_SLGID VARCHAR(36) '../*[local-name() = "CASEGUID" or local-name() = "SL_ID" ]',
      DS VARCHAR(10) '.'  
    )

 INSERT INTO #T_SL_FK (D3_ZSLGID,[D3_SLGID],[DS],DS_PR,[DS_TYPE], PR_DS2_N)
 SELECT isnull(D3_ZSLGID,idcase) D3_ZSLGID, D3_SLGID, [DS],DS_PR,2, PR_DS2_N FROM openxml(@idsluch, 'ZL_LIST/ZAP/Z_SL/SL/DS2_N', 2)
    WITH
    (
       D3_ZSLGID VARCHAR(36) '../../*[contains(local-name(), "ZSL_ID")  ] '
	   ,idcase int '../../*[local-name() = "Z_SL_ID" or local-name() = "IDCASE"] '
		,D3_SLGID VARCHAR(36) '../*[local-name() = "CASEGUID" or local-name() = "SL_ID" ]',
      DS VARCHAR(10) 'DS2',  
	  DS_PR VARCHAR(10) 'DS2_PR',
	  PR_DS2_N VARCHAR(10) 'PR_DS2_N'
    )

  INSERT INTO #T_SL_FK (D3_ZSLGID,[D3_SLGID],[DS],DS_PR,[DS_TYPE], PR_DS2_N)
 SELECT isnull(D3_ZSLGID,idcase) D3_ZSLGID, D3_SLGID, [DS],DS_PR,2, PR_DS2_N FROM openxml(@idsluch, 'ZL_LIST/ZAP/Z_SL/SL/DS2', 2)
    WITH
    (
       D3_ZSLGID VARCHAR(36) '../../*[contains(local-name(), "ZSL_ID")  ] '
	    ,idcase numeric(11,0) '../../*[local-name() = "Z_SL_ID" or local-name() = "IDCASE"] '
		,D3_SLGID VARCHAR(36) '../*[local-name() = "CASEGUID" or local-name() = "SL_ID" ]',
      DS VARCHAR(10) 'DS2',  
	  DS_PR VARCHAR(10) 'DS2_PR',
	  PR_DS2_N VARCHAR(10) 'PR_DS2_N'
    )
-----
--OPTION (QUERYTRACEON 460);--Проверочка
-----
/* чистка от кривых сопутствующих */
delete from #T_SL_FK where len(DS)>5 and DS_TYPE is not null
/*D3_DSS_OMS */
/* в версиях ниже 3.0 не было такого подсправочника? */
/*declare @dss table(D3_SLID int, [D3_SLGID] nvarchar(36),[DS] [nvarchar](10),DS_PR [int],[DS_TYPE] [int], PR_DS2_N int) */
/*
INSERT INTO #T_SL_FK (D3_ZSLGID,[D3_SLGID],[DS],DS_PR,[DS_TYPE], PR_DS2_N)
	select 
	    sl.m.value('(../ZSL_ID			)[1]','nvarchar(254)') as D3_ZSLGID 
	   ,sl.m.value('(./SL_ID			)[1]','nvarchar(254)') as D3_SLGID
      ,ds2.m.value('(./DS2		)[1]','nvarchar(254)') as DS
      ,ds2.m.value('(./DS2_PR		)[1]','nvarchar(254)') as DS_PR
	  ,2 as DS_TYPE
	   ,ds2.m.value('(./PR_DS2_N		)[1]','nvarchar(254)') as PR_DS2_N
	from @XmlH.nodes( '/ZL_LIST/ZAP/Z_SL/SL' ) sl(m)
		cross apply sl.m.nodes( 'DS2') ds2(m)

UNION ALL 	
	
	select 
	    sl.m.value('(../ZSL_ID			)[1]','nvarchar(254)') as D3_ZSLGID 
	   ,sl.m.value('(./SL_ID			)[1]','nvarchar(254)') as D3_SLGID
      ,ds2.m.value('(./DS2		)[1]','nvarchar(254)') as DS
      ,ds2.m.value('(./DS2_PR		)[1]','nvarchar(254)') as DS_PR
	  ,2 as DS_TYPE
	   ,ds2.m.value('(./PR_DS2_N		)[1]','nvarchar(254)') as PR_DS2_N
	from @XmlH.nodes( '/ZL_LIST/ZAP/Z_SL/SL' ) sl(m)
		cross apply sl.m.nodes( 'DS2_N') ds2(m)


UNION ALL 
	select 
	   sl.m.value('(../IDCASE			)[1]','nvarchar(254)') as D3_ZSLGID 
	   ,sl.m.value('(./SL_ID			)[1]','nvarchar(254)') as D3_SLGID
      ,ds3.m.value('(.		)[1]','nvarchar(254)')      ,NULL	  ,3,null
	from @XmlH.nodes( '/ZL_LIST/ZAP/Z_SL/SL' ) sl(m)
		cross apply sl.m.nodes( 'DS3') ds3(m)

UNION ALL 
	select 
	   sl.m.value('(../IDCASE			)[1]','nvarchar(254)') as D3_ZSLGID 
	   ,sl.m.value('(./SL_ID			)[1]','nvarchar(254)') as D3_SLGID
      ,ds0.m.value('(.		)[1]','nvarchar(254)')      ,NULL	  ,1,null
	from @XmlH.nodes( '/ZL_LIST/ZAP/Z_SL/SL' ) sl(m)
		cross apply sl.m.nodes( 'DS2') ds0(m) --DS0- не множественный.
*/
/* в смо будет так. DS2 - 1, DS2_N - 2, DS3 - 3 */

update #T_SL_FK set sc=@sc
update #T_SL set sc=@sc

if @@ERROR<>0 set @i = @i+1
print '@dss'

/*Вставляем МЭКИ*/
--if @reg=83
--begin
INSERT INTO #T_SANK(S_CODE,  S_SUM,  S_TIP,  S_OSN,  S_COM,  S_IST,  S_DATE,d3_zslid, D3_ZSLGID,  SC,   DATE_ACT,  NUM_ACT)
	select 
	    sa.m.value('(./S_CODE			)[1]','nvarchar(254)') as S_CODE
		,sa.m.value('(./S_SUM			)[1]','numeric(17,2)') as S_SUM
		,sa.m.value('(./S_TIP			)[1]','int') as S_TIP
		,f.osn as S_OSN
		,sa.m.value('(./S_COM			)[1]','nvarchar(254)') as S_COM
		,sa.m.value('(./S_IST			)[1]','int') as S_IST
	   ,sa.m.value('(./DATE_ACT			)[1]','datetime') as S_DATE 
	   ,-1 as d3_zslid
	   ,sa.m.value('(../IDCASE			)[1]','nvarchar(254)') as D3_ZSLGID
		,-1 as sc     
	  ,sa.m.value('(./DATE_ACT			)[1]','datetime') as DATE_ACT
	   ,sa.m.value('(./NUM_ACT			)[1]','nvarchar(254)') as NUM_ACT
      
	from @XmlH.nodes( '/ZL_LIST/ZAP/Z_SL/SANK' ) sa(m)
	join f014 f on sa.m.value('(./S_TIP			)[1]','int')=f.kod
	join #T_ZSL tz on isnull(zsl_id,idcase)=sa.m.value('(../IDCASE			)[1]','nvarchar(254)')
	
	update #T_SANK set sc=@sc


--end

/*подчищаем пустые диагнозы, которые образовались из-за разных форматов DS2 - составного и нет. */
/*delete from @dss where DS is null */
/* очищаем переменные */
EXEC sp_xml_removedocument @idsluch
if @@ERROR<>0 set @i = @i+1
/*логи */

END

/* очищаем пациента. */
EXEC sp_xml_removedocument @idpac

if @@ERROR<>0 set @i = @i+1


/*обновляем уиды. */
update #T_ZSL set UID_ZSL=HASHBYTES('SHA1', ZSL_ID+'SC'+cast(SC as varchar(10))	)
,UID_PAC = HASHBYTES('SHA1', ZSL_ID+'PAC'+ID_PAC+'ZAP'+cast(N_ZAP as varchar(10))+'SC'+cast(SC as varchar(10)) )

update #T_SANK set UID_ZSL=HASHBYTES('SHA1', D3_ZSLGID+'SC'+cast(SC as varchar(10))	)

UPDATE #T_SL set UID_SL =  HASHBYTES('SHA1', D3_ZSLGID+'SL'+SL_ID+'SC'+cast(SC as varchar(10)) )
, UID_ZSL=HASHBYTES('SHA1', D3_ZSLGID+'SC'+cast(SC as varchar(10))	)

/*это работает только там, где выгружается региональный код.  */
--update sl set podr=o.ID
--from OtdelDb o join #T_SL sl on sl.podr=o.OTDID_REGION_NOTEDIT

--select*from #T_USL
--select*from #T_LEK_PR_COV
--select*from #T_SL
--select UID_SL =  HASHBYTES('SHA1', D3_ZSLGID+'SL'+[D3_SLGID]+'SC'+cast(SC as varchar(10)) ),D3_ZSLGID,D3_SLGID,cast(SC as varchar(10)) from #T_LEK_PR_COV where d3_zslgid=1003
--select UID_SL =  HASHBYTES('SHA1', D3_ZSLGID+'SL'+[D3_SLGID]+'SC'+cast(SC as varchar(10)) ),D3_ZSLGID,D3_SLGID,cast(SC as varchar(10)) from #T_USL where d3_zslgid=1003
--select UID_SL =  HASHBYTES('SHA1', D3_ZSLGID+'SL'+[SL_ID]+'SC'+cast(SC as varchar(10)) ),D3_ZSLGID,SL_ID,cast(SC as varchar(10)) from #T_SL where d3_zslgid=1003


UPDATE #T_USL        set UID_SL =  HASHBYTES('SHA1', D3_ZSLGID+'SL'+[D3_SLGID]+'SC'+cast(SC as varchar(10)) )
UPDATE #T_USL        set UID_USL =  HASHBYTES('SHA1', D3_ZSLGID+'SL'+[D3_SLGID]+'SC'+cast(SC as varchar(10))+'IDS'+IDSERV )
UPDATE #T_MEDDEV     set UID_USL =  HASHBYTES('SHA1', D3_ZSLGID+'SL'+[D3_SLGID]+'SC'+cast(SC as varchar(10))+'IDS'+cast(IDSERV as varchar(10)) )
UPDATE #T_LEK_PR_COV set UID_SL =  HASHBYTES('SHA1', D3_ZSLGID+'SL'+[D3_SLGID]+'SC'+cast(SC as varchar(10)) )
update #T_SL_FK      set UID_SL =  HASHBYTES('SHA1', D3_ZSLGID+'SL'+[D3_SLGID]+'SC'+cast(SC as varchar(10)) )


--select*from #T_USL
--select*from #T_LEK_PR_COV
--select*from #T_SL


declare @fil nvarchar(1000)


exec p_t_fillD3  @fil output

/*select @fil */
if @i>0
 set @rez = 'ошибка в хмл'
 else	
 set @rez = @fil
 print @rez
end
GO


