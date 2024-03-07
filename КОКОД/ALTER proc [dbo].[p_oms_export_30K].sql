USE [ElmedKokod]
GO

/****** Object:  StoredProcedure [dbo].[p_oms_export_30K]    Script Date: 06.02.2020 11:31:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER proc [dbo].[p_oms_export_30K] @sc int
AS --05092018 ��������� PRVS � PROFIL_K ���������
--08112018 ������� ������������� � ��������.
--03122018 ������� �������� �� D3 �� 200 �������.
--14112019 �������� ��� � ������� ���������� ��������.
--28012020  CODEUSL � LT LF .....
BEGIN
--declare @sc int = 47

-- ��������������� ����������� ������������ �����.
update z set usl_ok=s.usl_ok 
from d3_zsl_oms z join d3_sl_oms s on s.d3_zslid=z.id
where z.usl_ok is null

update sl set nhistory=sl.id
from d3_sl_oms sl
where sl.nhistory is null
----

update sc set code=id from d3_schet_oms sc where code is null

declare  @d varchar(20) = convert(varchar,getdate(),105)


declare @Hf varchar(20),@Lf varchar(20)

declare @Hpref varchar(10) = (select SchetType from D3_SCHET_OMS where id=@sc)
declare @Lpref varchar(10) = (select lpref from Yamed_Spr_SchetType where id=@hpref)

--���������� �������� ���������� ��� ��������, ����� ��� ������ ��������� ������.
declare @CountV varchar(10) = cast((select max(isnull(om1.FileIndex,0))+1 from  D3_SCHET_OMS om1
		 join D3_SCHET_OMS sc on om1.CODE_MO =sc.CODE_MO and om1.YEAR=sc.YEAR and om1.MONTH=sc.MONTH and om1.SchetType=sc.SchetType and sc.id=@sc
		) as varchar(10))


set @Hf = @Hpref+'M'+(select CODE_MO from [D3_SCHET_OMS] sc where id=@sc)+'T46_'+(select right(cast([year] as nvarchar(4)),2)+ right('0'+cast([MONTH] as nvarchar(2)),2) from [D3_SCHET_OMS] sc where id=@sc)+@CountV
set @Lf = @Lpref+'M'+(select CODE_MO from [D3_SCHET_OMS] sc where id=@sc)+'T46_'+(select right(cast([year] as nvarchar(4)),2)+ right('0'+cast([MONTH] as nvarchar(2)),2) from [D3_SCHET_OMS] sc where id=@sc)+@CountV



-- ������������� 
-- ����������
declare @countD3 int = (select count(*) from d3_zsl_oms zsl where zsl.d3_scid=@sc )

-- ��������� ���� � �����.
update sc set 
ZapFILENAME = @hf,PersFileName = @Lf
,SD_Z = @countD3
,SUMMAV = (select sum(sumv) from d3_zsl_oms zsl where zsl.d3_scid=@sc)
,SUMMAP = (select sum(sumv) from d3_zsl_oms zsl where zsl.d3_scid=@sc)
,FileIndex=	cast( @CountV as int)
from d3_schet_oms sc where id=@sc

-- ���������� ��������� � D3 ����� ���� ������ ���������� z_sl
update p set N_ZAP = rowN from
(select ROW_NUMBER() OVER (ORDER BY zsl.sumv desc ,p.id)
	as rowN,p.id
from  d3_pacient_oms p	
join [D3_ZSL_OMS] zsl on p.ID=zsl.D3_PID
where zsl.d3_scid=@sc ) sort 
join d3_pacient_oms p on sort.id=p.id

-- � ������ ������� ������� = ������. � ����� ������� ����� �� ������ �������� ����� ���� ��������� �������
update zsl set IDCASE = rowN from
(select ROW_NUMBER() OVER (ORDER BY p.n_zap,zsl.id) --+ @countSluch 
	as rowN,zsl.id
from  [dbo].[D3_ZSL_OMS] zsl join d3_pacient_oms p on zsl.d3_pid=p.id	where zsl.d3_scid=@sc  ) sort 
join [dbo].[D3_ZSL_OMS] zsl on sort.id=zsl.id


-- �������� ����������, ���������� �� ������.
update naz set NAZ_N = rowN from
(select ROW_NUMBER() OVER (PARTITION BY sl.id ORDER BY naz.id) as rowN,naz.id
from  [dbo].[D3_ZSL_OMS] zsl join d3_sl_oms sl on zsl.id=sl.D3_ZSLID
join D3_NAZ_OMS naz on sl.id=naz.D3_SLID
	where zsl.d3_scid=@sc  ) sort 
join [dbo].[D3_NAZ_OMS] naz on sort.id=naz.id

--����� ��������������

select(
SELECT 
(SELECT '3.1' AS [VERSION],convert(date,[DSCHET],20) as [DATA]
	,@hf as [FILENAME], SD_Z
from [D3_SCHET_OMS] sc where id=@sc
FOR xml path('ZGLV'), TYPE) AS[*]
,
(SELECT [CODE],[CODE_MO],[YEAR],[MONTH],[NSCHET],convert(date,[DSCHET],20) [DSCHET],[PLAT], SUMMAV [SUMMAV],SUMMAP SUMMAP,[SANK_MEK],[SANK_MEE],[SANK_EKMP],[DISP]
	from [D3_SCHET_OMS] sc where id=@sc
FOR xml path('SCHET'), ELEMENTS , TYPE) AS[*]
,(SELECT p.N_ZAP,isnull(zsl.PR_NOV,0) PR_NOV
	, (select ID_PAC,VPOLIS,SPOLIS,NPOLIS,ST_OKATO,SMO,SMO_OGRN,SMO_OK,SMO_NAM,INV,MSE,NOVOR,VNOV_D,VETERAN,WORK_STAT
			FOR xml path('PACIENT'), TYPE) AS[*]
	, (select ZSL_ID,IDCASE,zsl.USL_OK,VIDPOM,FOR_POM

	--case when (zsl.USL_OK =1 and FOR_POM=3) or zsl.USL_OK=2 or (zsl.USL_OK=3 and  @Hpref='C' ) then NPR_MO end NPR_MO
		,NPR_MO

	,convert(date,[NPR_DATE],20) NPR_DATE 
	,LPU
	,VBR --���� (������������)
	,convert(date,[DATE_Z_1],20) DATE_Z_1,convert(date,[DATE_Z_2],20) DATE_Z_2
	,P_OTK -- ���� (������������)
	,RSLT_D --���� (������������)
	,KD_Z,VNOV_M,RSLT,ISHOD,OS_SLUCH
	,zsl.P_CEL as DISP -- � ���� ����� ����� ������� ����������������� OS_SLUCH_REGION �� V016
	,case when usl_ok=3 then OS_SLUCH_REGION end OS_SLUCH_REGION  -- ��� �������� �� ��������� �� ������ ������ �� ��������. 06.08.2019
	,VOZR
	,VB_P
	--������ ����� SL
	,(select SL_ID
	,VID_HMP ,METOD_HMP -- � ����� �
	,LPU_1
	--,ot.OTDID_REGION_NOTEDIT as PODR -- ����� ��� � � SL � ���������������
		,sl.PODR -- ����� ��� � � SL � ���������������
	,sl.PROFIL
	,PROFIL_K 
	,DET
	,P_CEL25 as P_CEL --� ����������� � ����� ����� ������������ P_CEL25
	,TAL_NUM --����� ������ �� ���
	,convert(date,[TAL_D],20) TAL_D --���� ������ ������ �� ��� --�� ������ ��� ���� �� ���, � ���� ���� - �� ��� ������
	
	,convert(date,[TAL_P],20) TAL_P -- ���� ����������� �������������� ���
	,NHISTORY
	,P_PER --(USL_OK=1 ��� USL_OK=2):1 - �������������� 2 - ��� 3 - ������� �� ������ �� 4 - ������� ������ �� � ������� �������
	,convert(date,[DATE_1],20) DATE_1,convert(date,[DATE_2],20) DATE_2,KD,DS0,DS1
	,DS1_PR -- ���� ����������� ����������� "1", ���� �������� ������� ������� ������� � ���������� ����������� ���������������/����������������� ������������ �������
	--,DN as PR_D_N  --�� ������ ��� ������ ���� �� �����.
	--�������� Ds2 DS3
	,case when (select count(DS) from D3_DSS_OMS dss where dss.D3_SLID = sl.ID and DS_TYPE=2)>0 then
	(select DS as DS2,DS_PR as DS2_PR
		,PR_DS2_N 
		 from D3_DSS_OMS dss where dss.D3_SLID = sl.ID and DS_TYPE=2 FOR xml path('DS2'), ELEMENTS, TYPE)   end as[*]
	,(select DS as DS3 from D3_DSS_OMS dss where dss.D3_SLID = sl.ID and DS_TYPE=3 FOR xml path(''), ELEMENTS, TYPE) as[*]
	-- ���� NAZ ��� ���������������
	,(select		NAZ_N -- ����� �� �������
				,NAZ_R --����������� ��� ���������� ������ ��������, ����� I � II.1 - ��������� �� ������������ � ����������� ����������� �� ����� ������������;2 - ��������� �� ������������ � ���� ����������� �����������;3 - ��������� �� ������������;4 - ��������� � ������� ���������;5 - ��������� �� ��������������;6 - ��������� � ���������������� ���������.
				,NAZ_SP --�����������, ���� � ���� NAZ_R ����������� ���� 1 ��� 2.
				,NAZ_V --�����������, ���� � ���� NAZ_R =3  ; 1 - ������������ �����������;2 - ���������������� �����������;3 - ������ ������� �����������, �� ����������� �������������;4 - ������������� ������ ������� ����������� (��, ���, �����������)
				,NAZ_USL -- V001, ���� (NAZ_R=3 � DS_ONK=1)
				,convert(date,[NAPR_DATE],20) NAPR_DATE
				,NAPR_MO --F003 (NAZ_R={2,3} � DS_ONK=1)
				,NAZ_PMP -- V002 ������� ��������� �����������, ���� � ���� NAZ_R ����������� ���� 4 ��� 5.
				,NAZ_PK -- V020 ������� ����� �����������, ���� � ���� NAZ_R ���������� ��� 6.
		 from d3_naz_oms where d3_slid=sl.id
		 FOR xml path('NAZ'), TYPE) AS[*]
	,case when (((zsl.usl_ok = 3 and isnull(zsl.OS_SLUCH_REGION,0) not in (9,11,12,13,14,15,16,17,18,22,23,37,38,47,48,49)) or sl.METOD_HMP is not null) and @Hpref='H') or @Hpref='C' 
		then C_ZAB end C_ZAB --3.1
		 --��������� ������ ������, ��� ������� ����� ��������� 19.09.2019
	,case when  ((@Hpref='C') OR (@Hpref='H'  AND (vidpom=32 OR OS_SLUCH_REGION in (7,8,9,49,11,12,17,18,22,47,23,48,37,38)))) then isnull(DS_ONK,0) end DS_ONK -- 3.1 ����+��� +C 1 - ��� ��������� ���������� �� ��������������� ���������������
	,DN --����������� ��� ����������, ���� P_CEL=1.3
	,CODE_MES1,CODE_MES2
	-- ���� NAPR ��� ���(������ �� ��� ���� �������� ����, ���� ��� ���������� �� ���)
	,(select convert(date,[NAPR_DATE],20) NAPR_DATE,NAPR_MO,NAPR_V,MET_ISSL,NAPR_USL 
		from d3_napr_oms na where na.d3_slid=sl.id
		FOR xml path('NAPR'), TYPE) AS[*] 
	-- ����������� �������� � ������������ ���������� �� ������ ��������� ����������� (���������):1 - �������,2 - ����,3 - �� �������� ������������� ����������
	-- ���� CONS ��� ���
	,(select PR_CONS,convert(date,[DT_CONS],20) DT_CONS 
		from d3_cons_oms con where con.d3_slid=sl.id
		FOR xml path('CONS'), TYPE) AS[*] 
	-- ���� ONK_SL
	-- ����� ����� ��� � 200 ������� ��� � ������� �������, ���� ���� � ���.
	,(select DS1_T,STAD,ONK_T,ONK_N,ONK_M,nullif(MTSTZ,0) MTSTZ,SOD,K_FR 	,[WEI] ,[HEI] 	,[BSA] 
		--���� B_DIAG
		,(SELECT convert(date,[DIAG_DATE],20) DIAG_DATE ,DIAG_TIP,DIAG_CODE,DIAG_RSLT,REC_RSLT
			from d3_b_diag_oms where d3_onkslid=onk.id
			FOR xml path('B_DIAG'), TYPE) AS[*] 
		--���� B_PROT
		,(SELECT PROT,convert(date,[D_PROT],20) D_PROT 
			from d3_b_prot_oms where d3_onkslid=onk.id
			FOR xml path('B_PROT'), TYPE) AS[*] 
		--���� ONK_USL
		,(select USL_TIP,HIR_TIP,LEK_TIP_L,LEK_TIP_V
				--,���� LEK_PR
				,(SELECT REGNUM,CODE_SH,convert(date,[DATE_INJ],20) DATE_INJ
					from d3_LEK_PR_oms where d3_onkuslid=onk_u.id
					FOR xml path('LEK_PR'), TYPE) AS[*] 
				,LUCH_TIP 
			from d3_onk_usl_oms onk_u where d3_onkslid=onk.id
			FOR xml path('ONK_USL'), TYPE) AS[*] 
		,SOD 
		from d3_onk_sl_oms onk where onk.d3_slid=sl.id
		FOR xml path('ONK_SL'), TYPE) AS[*] 
	
	,(select ks.N_KSG
		,ks.VER_KSG 
		,ks.KSG_PG,ks.N_KPG,ks.KOEF_Z,ks.KOEF_UP,ks.BZTSZ,ks.KOEF_D,ks.KOEF_U
		,(SELECT CRIT from d3_CRIT_OMS kf where kf.D3_KSGID=ks.id FOR xml path('CRIT'), TYPE ) AS[*]
		,ks.SL_K
		,ks.IT_SL
		,(SELECT IDSL,Z_SL from d3_SL_KOEF_OMS kf where kf.D3_KSGID=ks.id FOR xml path('SL_KOEF'), TYPE ) AS[*]  ---3.1
		from D3_KSG_KPG_OMS ks where ks.D3_SLID=sl.id
		FOR xml path('KSG_KPG'), TYPE) AS[*]
	,nullif(REAB,0) REAB --����������� �������� "1" ��� ������� ������������
	,PRVS --����������� �������� IDSPEC
	,PRVD,VERS_SPEC,IDDOKT,ED_COL,TARIF,SUM_M
	--���� USL   
	   ,(select ROW_NUMBER() OVER (ORDER BY u.id) IDSERV 
		,LPU,LPU_1
		,ot_u.OTDID_REGION_NOTEDIT as PODR
		,u.PROFIL,VID_VME,DET,convert(date,[DATE_IN],20) DATE_IN,convert(date,[DATE_OUT],20) DATE_OUT
		,DS,CODE_USL,isnull(KOL_USL,1) KOL_USL
		,TARIF,isnull(SUMV_USL,0) SUMV_USL
		,PRVS,VERS_SPEC,CODE_MD
		,isnull(P_OTK,0) P_OTK
		,case when u.NPL in (1,2,3,4) then u.NPL else NULL end NPL--����������� �������, �� ������� ������ �� ������� ��� ������� �� � ������ ������.1 - ����������������� ����� ��������,2 - ����������� ����������������,3 - ������ ������� (����, ��������� � ������ ��������� � ��.)4 - ����� ����������� ������ � �������� ������������� ������.
		,COMENTU
			from D3_USL_OMS u left join OtdelDb ot_u on u.podr=ot_u.id
				where u.d3_slid=sl.id FOR xml path('USL'), ELEMENTS , TYPE) AS[*]	
	,COMENTSL
		FROM [dbo].[D3_SL_OMS] sl  left join OtdelDb ot on sl.podr=ot.id --left ������ ��� ����� ��� ��������������� � ��� ���������.
				where sl.d3_zslid=zsl.id 
		FOR xml path('SL'), TYPE) AS[*]
	
	,IDSP,SUMV
	FOR xml path('Z_SL'), TYPE) AS[*] 	from [dbo].[D3_ZSL_OMS] zsl join D3_pacient_OMS p on zsl.d3_scid=@sc and zsl.d3_pid=p.id	
		where p.d3_scid=@sc	order by N_ZAP
FOR xml path('ZAP'), ELEMENTS , TYPE) AS[*]


FOR XML path('ZL_LIST'), ELEMENTS, TYPE ) as HM
,(select 
	( 	SELECT 
			'3.1' as VERSION,
			convert(varchar(10),getdate(),20) as DATA,
			@Lf FILENAME,
			@Hf FILENAME1
		from D3_SCHET_OMS sch
		where sch.ID=@sc
		for xml path('ZGLV'),type
	),(	select 	  distinct  [ID_PAC]      ,[FAM]      ,[IM]      ,[OT]      ,[W]      
		,convert(varchar(10),P.DR,20) [DR],DOST      ,[TEL]      ,[FAM_P]      ,[IM_P]      
		,[OT_P]      ,[W_P]      ,[DR_P],DOST_P      ,[MR]      ,[DOCTYPE]      ,[DOCSER]
      ,[DOCNUM] ,DOCDATE,DOCORG     ,[SNILS]      ,[OKATOG]      ,[OKATOP]      ,[COMENTP]

		from  [dbo].[D3_ZSL_OMS] zsl join d3_pacient_oms p on zsl.d3_pid=p.id where zsl.d3_scid=@sc
	for xml path('PERS'),type )	 
from D3_SCHET_OMS sch
where sch.ID=@sc
for xml path('PERS_LIST'),type) as LM
,@sc sc, @Hf hf_name, @lf lf_name


END
GO


