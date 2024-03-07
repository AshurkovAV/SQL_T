--вставка услуг Коагулограммы во временную таблицу
/*
 1у услугу  B03.005.006 (code_usl = 'R01.001.999') заменяем на: 
 A12.05.039 Активированное частичное тромбопластиновое время  R01.001.011 сумма 78,96
 A09.05.050 Исследование уровня фибриногена в крови R01.001.012 сумма 113,57
 A12.05.027 Протромбин, МНО R01.001.013 сумма 68,14
*/
/*
DECLARE @p1 INT=8516


SELECT 
FROM   D3_SL_OMS sl
WHERE sl.D3_ZSLID
AND sch.id=@p1
*/

--1.  создание временной таблицы для Коагулограммы
/*
USE [ElmedKokod2]
GO

CREATE TABLE [dbo].[tmp_koagul_new](
--zsl	
	[zsl_ID] [int]  NOT NULL,
	[zsl_ZSL_ID] [nvarchar](36) NULL,
	[zsl_D3_PID] [int] NOT NULL,
	[zsl_D3_PGID] [nvarchar](36) NULL,
	[zsl_D3_SCID] [int] NOT NULL,
	[zsl_IDCASE] [numeric](11, 0) NULL,
	[zsl_VIDPOM] [int] NULL,
	[zsl_FOR_POM] [int] NULL,
	[zsl_NPR_MO] [nvarchar](6) NULL,
	[zsl_LPU] [nvarchar](6) NULL,
	[zsl_DATE_Z_1] [datetime] NULL,
	[zsl_DATE_Z_2] [datetime] NULL,
	[zsl_RSLT] [int] NULL,
	[zsl_ISHOD] [int] NULL,
	[zsl_IDSP] [int] NULL,
	[zsl_SUMV] [numeric](17, 2) NULL,
	[zsl_MTR] [bit] NOT NULL,
	[zsl_USL_OK] [int] NULL,
	[zsl_NPR_DATE] [date] NULL,
	[zsl_PR_NOV] [int] NULL,
	[zsl_SysDtChange] [datetime] NULL,
--sl
	[sl_ID] [int]  NOT NULL,
	[sl_D3_ZSLID] [int] NOT NULL,
	[sl_D3_ZSLGID] [nvarchar](36) NULL,
	[sl_SL_ID] [nvarchar](36) NULL,
	[sl_LPU_1] [nvarchar](8) NULL,
	[sl_PROFIL] [int] NULL,
	[sl_DET] [int] NULL,
	[sl_P_CEL] [nvarchar](3) NULL,
	[sl_NHISTORY] [nvarchar](50) NULL,
	[sl_DATE_1] [datetime] NULL,
	[sl_DATE_2] [datetime] NULL,
	[sl_DS1] [nvarchar](10) NULL,
	[sl_PRVS] [int] NULL,
	[sl_VERS_SPEC] [nvarchar](4) NULL,
	[sl_IDDOKT] [nvarchar](25) NULL,
	[sl_ED_COL] [numeric](7, 2) NULL,
	[sl_TARIF] [numeric](17, 2) NULL,
	[sl_SUM_M] [numeric](17, 2) NULL,
	[sl_PRVS21] [int] NULL,
	[sl_P_CEL25] [nvarchar](3) NULL,
--usl
	[usl_ID] [int]  NOT NULL,
	[usl_D3_SLID] [int] NOT NULL,
	[usl_D3_ZSLID] [int] NOT NULL,
	[usl_D3_SLGID] [nvarchar](36) NULL,
	[usl_IDSERV] [nvarchar](36) NULL,
	[usl_LPU] [nvarchar](6) NULL,
	[usl_PROFIL] [int] NULL,
	[usl_VID_VME] [nvarchar](16) NULL,
	[usl_DET] [int] NULL,
	[usl_DATE_IN] [datetime] NULL,
	[usl_DATE_OUT] [datetime] NULL,
	[usl_DS] [nvarchar](10) NULL,
	[usl_CODE_USL] [nvarchar](20) NULL,
	[usl_KOL_USL] [numeric](8, 2) NULL,
	[usl_SUMV_USL] [numeric](17, 2) NULL,
	[usl_PRVS] [int] NULL,
	[usl_CODE_MD] [nvarchar](25) NULL,
	--[usl_PRVS_VERS] [nvarchar](9) NULL,	
--PACIENT
	[p_ID] [int]  NOT NULL,
	[p_D3_SCID] [int] NOT NULL,
	[p_ID_PAC] [nvarchar](36) NULL,
	[p_FAM] [nvarchar](40) NULL,
	[p_IM] [nvarchar](40) NULL,
	[p_OT] [nvarchar](40) NULL,
	[p_W] [int] NULL,
	[p_DR] [datetime] NULL,
	[p_DOCTYPE] [int] NULL,
	[p_DOCSER] [nvarchar](10) NULL,
	[p_DOCNUM] [nvarchar](20) NULL,
	[p_SNILS] [nvarchar](14) NULL,
	[p_VPOLIS] [int] NULL,
	[p_SPOLIS] [nvarchar](10) NULL,
	[p_NPOLIS] [nvarchar](20) NULL,
	[p_SMO] [nvarchar](5) NULL,
	[p_NOVOR] [nvarchar](9) NULL,
	[p_N_ZAP] [int] NULL,
	[p_DOST] [int] NULL,
	[p_DOCDATE] [datetime] NULL,
	[p_DOCORG] [nvarchar](1000) NULL,
	[p_ENP] [varchar](16) NULL
)
*/

/*
select *
from [tmp_koagul_new]
*/

--begin tran 
--DROP TABLE [tmp_koagul_new]
--commit tran
--rollback tran 

--2. вставка данных во временную таблицу. 
     --Вставляем исходную запись без изменений
--begin tran
--DECLARE @p1 INT = 8407  
/*
insert into [tmp_koagul_new]([zsl_ID],
	[zsl_ZSL_ID],
	[zsl_D3_PID],
	[zsl_D3_PGID],
	[zsl_D3_SCID],
	[zsl_IDCASE],
	[zsl_VIDPOM],
	[zsl_FOR_POM],
	[zsl_NPR_MO],
	[zsl_LPU],
	[zsl_DATE_Z_1],
	[zsl_DATE_Z_2],
	[zsl_RSLT],
	[zsl_ISHOD],
	[zsl_IDSP],
	[zsl_SUMV],
	[zsl_MTR],
	[zsl_USL_OK],
	[zsl_NPR_DATE],
	[zsl_PR_NOV],
	[zsl_SysDtChange],
--sl
	[sl_ID],
	[sl_D3_ZSLID],
	[sl_D3_ZSLGID],
	[sl_SL_ID],
	[sl_LPU_1],
	[sl_PROFIL],
	[sl_DET],
	[sl_P_CEL],
	[sl_NHISTORY],
	[sl_DATE_1],
	[sl_DATE_2],
	[sl_DS1],
	[sl_PRVS],
	[sl_VERS_SPEC],
	[sl_IDDOKT],
	[sl_ED_COL],
	[sl_TARIF],
	[sl_SUM_M],
	[sl_PRVS21],
	[sl_P_CEL25],
--usl
	[usl_ID],
	[usl_D3_SLID],
	[usl_D3_ZSLID],
	[usl_D3_SLGID],
	[usl_IDSERV],
	[usl_LPU],
	[usl_PROFIL],
	[usl_VID_VME],
	[usl_DET],
	[usl_DATE_IN],
	[usl_DATE_OUT],
	[usl_DS],
	[usl_CODE_USL],
	[usl_KOL_USL],
	[usl_SUMV_USL],
	[usl_PRVS],
	[usl_CODE_MD],
	--[usl_VERS_SPEC])
	
	[p_ID],
	[p_D3_SCID] ,
	[p_ID_PAC],
	[p_FAM],
	[p_IM],
	[p_OT],
	[p_W],
	[p_DR],
	[p_DOCTYPE],
	[p_DOCSER],
	[p_DOCNUM],
	[p_SNILS],
	[p_VPOLIS],
	[p_SPOLIS],
	[p_NPOLIS],
	[p_SMO],
	[p_NOVOR],
	[p_N_ZAP],
	--[FIO]  AS (rtrim((((isnull([FAM],'')+' ')+isnull([IM],''))+' ')+isnull([OT],''))),
	[p_DOST],
	[p_DOCDATE],
	[p_DOCORG],
	[p_ENP]
	)
*/
select zs.ID
	,/*NEWID()*/zs.ZSL_ID
	,zs.D3_PID
	,zs.D3_PGID
	,zs.D3_SCID
	,/*2*/ zs.IDCASE
	,zs.VIDPOM
	,zs.FOR_POM
	,zs.NPR_MO
	,zs.LPU
	,zs.DATE_Z_1
	,zs.DATE_Z_2
	,zs.RSLT
	,zs.ISHOD
	,zs.IDSP
	,zs.SUMV
	,zs.MTR
	,zs.USL_OK
	,zs.NPR_DATE
	,zs.PR_NOV
	,/*GETDATE()*/ zs.SysDtChange
	
	,s.ID
	,s.D3_ZSLID
	,s.D3_ZSLGID
	,s.SL_ID
	,s.LPU_1
	,s.PROFIL
	,s.DET
	,s.P_CEL
	,s.NHISTORY
	,s.DATE_1
	,s.DATE_2
	,s.DS1
	,s.PRVS
	,s.VERS_SPEC
	,s.IDDOKT
	,s.ED_COL
	,s.TARIF
	,s.SUM_M
	,s.PRVS21
	,s.P_CEL25

	,usl.id
	,usl.D3_SLID
	,usl.D3_ZSLID
	,usl.D3_SLGID
	,usl.IDSERV /*'2'*/  /*'3',*/
	,usl.LPU
	,usl.PROFIL
	,usl.VID_VME /*'A12.05.039'*/ /*'A09.05.050',*/
	,usl.DET
	,usl.DATE_IN
	,usl.DATE_OUT
	,usl.DS
	,usl.CODE_USL  /*'R01.001.011'*/ /*'R01.001.012',*/
	,usl.KOL_USL
	,usl.SUMV_USL
	,usl.PRVS
	,usl.CODE_MD
	--,usl.VERS_SPEC
	
	,p.ID
	,p.D3_SCID
	,/*NEWID()*/ p.ID_PAC
	,p.FAM
	,p.IM
	,p.OT
	,p.W
	,p.DR
	,p.DOCTYPE
	,p.DOCSER
	,p.DOCNUM
	,p.SNILS
	,p.VPOLIS
	,p.SPOLIS
	,p.NPOLIS
	,p.SMO
	,p.NOVOR
	,p.N_ZAP
	--,p.FIO
	,p.DOST
	,p.DOCDATE
	,p.DOCORG
	,p.ENP
FROM D3_SCHET_OMS sch                  
inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
								and sch.year=2022 
							    --and sch.month=10 
							    AND sch.id = /*@p1*/ /*8582*/   9160			
inner join D3_ZSL_OMS zs on zs.D3_PID=p.id  and zs.D3_SCID=sch.id 
join	   D3_SL_OMS s on s.D3_ZSLID=zs.ID 
JOIN	   d3_usl_oms usl ON usl.D3_SLID=s.id
left join  Yamed_Spr_UslCode u on u.id=usl.vid_vme
LEFT JOIN  f003 ON f003.mcod = zs.NPR_MO
WHERE usl.VID_VME = 'B03.005.006'

--commit tran
--rollback tran

--проверка
/*
select *
from [tmp_koagul_new]
*/


--2. вставка данных во временную таблицу. 
     --вставляем данные с новыми гуидами
--begin tran

--DECLARE @p1 INT = 8686 /*8581*/  /*8516*/
/*
insert into [tmp_koagul_new]([zsl_ID],
	[zsl_ZSL_ID],
	[zsl_D3_PID],
	[zsl_D3_PGID],
	[zsl_D3_SCID],
	[zsl_IDCASE],
	[zsl_VIDPOM],
	[zsl_FOR_POM],
	[zsl_NPR_MO],
	[zsl_LPU],
	[zsl_DATE_Z_1],
	[zsl_DATE_Z_2],
	[zsl_RSLT],
	[zsl_ISHOD],
	[zsl_IDSP],
	[zsl_SUMV],
	[zsl_MTR],
	[zsl_USL_OK],
	[zsl_NPR_DATE],
	[zsl_PR_NOV],
	[zsl_SysDtChange],
--sl
	[sl_ID],
	[sl_D3_ZSLID],
	[sl_D3_ZSLGID],
	[sl_SL_ID],
	[sl_LPU_1],
	[sl_PROFIL],
	[sl_DET],
	[sl_P_CEL],
	[sl_NHISTORY],
	[sl_DATE_1],
	[sl_DATE_2],
	[sl_DS1],
	[sl_PRVS],
	[sl_VERS_SPEC],
	[sl_IDDOKT],
	[sl_ED_COL],
	[sl_TARIF],
	[sl_SUM_M],
	[sl_PRVS21],
	[sl_P_CEL25],
--usl
	[usl_ID],
	[usl_D3_SLID],
	[usl_D3_ZSLID],
	[usl_D3_SLGID],
	[usl_IDSERV],
	[usl_LPU],
	[usl_PROFIL],
	[usl_VID_VME],
	[usl_DET],
	[usl_DATE_IN],
	[usl_DATE_OUT],
	[usl_DS],
	[usl_CODE_USL],
	[usl_KOL_USL],
	[usl_SUMV_USL],
	[usl_PRVS],
	[usl_CODE_MD],
	--[usl_VERS_SPEC])
	
	[p_ID],
	[p_D3_SCID] ,
	[p_ID_PAC],
	[p_FAM],
	[p_IM],
	[p_OT],
	[p_W],
	[p_DR],
	[p_DOCTYPE],
	[p_DOCSER],
	[p_DOCNUM],
	[p_SNILS],
	[p_VPOLIS],
	[p_SPOLIS],
	[p_NPOLIS],
	[p_SMO],
	[p_NOVOR],
	[p_N_ZAP],
	--[FIO]  AS (rtrim((((isnull([FAM],'')+' ')+isnull([IM],''))+' ')+isnull([OT],''))),
	[p_DOST],
	[p_DOCDATE],
	[p_DOCORG],
	[p_ENP]
	)
*/
select zs.ID
	,NEWID()   --zs.ZSL_ID
	,zs.D3_PID
	,zs.D3_PGID
	,zs.D3_SCID
	,3  /*2*/ --zs.IDCASE
	,zs.VIDPOM
	,zs.FOR_POM
	,zs.NPR_MO
	,zs.LPU
	,zs.DATE_Z_1
	,zs.DATE_Z_2
	,zs.RSLT
	,zs.ISHOD
	,zs.IDSP
	,zs.SUMV
	,zs.MTR
	,zs.USL_OK
	,zs.NPR_DATE
	,zs.PR_NOV
	,GETDATE() --zs.SysDtChange
	
	,s.ID
	,s.D3_ZSLID
	,s.D3_ZSLGID
	,NEWID()	--s.SL_ID
	,s.LPU_1
	,s.PROFIL
	,s.DET
	,s.P_CEL
	,s.NHISTORY
	,s.DATE_1
	,s.DATE_2
	,s.DS1
	,s.PRVS
	,s.VERS_SPEC
	,s.IDDOKT
	,s.ED_COL
	,s.TARIF
	,s.SUM_M
	,s.PRVS21
	,s.P_CEL25

	,usl.id
	,usl.D3_SLID
	,usl.D3_ZSLID
	,usl.D3_SLGID
	,/*usl.IDSERV*/ /*'2'*/  '3'
	,usl.LPU
	,usl.PROFIL
	,/*usl.VID_VME*/ /*'A12.05.039'*/ 'A09.05.050'
	,usl.DET
	,usl.DATE_IN
	,usl.DATE_OUT
	,usl.DS
	,/*usl.CODE_USL*/  /*'R01.001.011'*/ 'R01.001.012'
	,usl.KOL_USL
	,usl.SUMV_USL
	,usl.PRVS
	,usl.CODE_MD
	--,usl.VERS_SPEC
	
	,p.ID
	,p.D3_SCID
	,NEWID() --p.ID_PAC
	,p.FAM
	,p.IM
	,p.OT
	,p.W
	,p.DR
	,p.DOCTYPE
	,p.DOCSER
	,p.DOCNUM
	,p.SNILS
	,p.VPOLIS
	,p.SPOLIS
	,p.NPOLIS
	,p.SMO
	,p.NOVOR
	,p.N_ZAP
	--,p.FIO
	,p.DOST
	,p.DOCDATE
	,p.DOCORG
	,p.ENP

FROM D3_SCHET_OMS sch                  
inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
								and sch.year=2022 
							    AND sch.id = 9160 /*@p1*/ /*8581*/  /*8516*/		
inner join D3_ZSL_OMS zs on zs.D3_PID=p.id  and zs.D3_SCID=sch.id 
join	   D3_SL_OMS s on s.D3_ZSLID=zs.ID 
JOIN	   d3_usl_oms usl ON usl.D3_SLID=s.id
left join  Yamed_Spr_UslCode u on u.id=usl.vid_vme
LEFT JOIN  f003 ON f003.mcod=zs.NPR_MO
WHERE usl.VID_VME = 'B03.005.006'

--inner join tmp_koagul t on zs.ZSL_ID = t.zsl_ZSL_ID

--commit tran
--rollback tran

/*
select  *
from [tmp_koagul_new] t
where t.zsl_d3_scid = 9160
*/

--обновить записи в таблице [tmp_koagul] - добавить новые гуиды и айди
--begin tran
--update tmp_koagul_new  set zsl_zsl_id = newid(), sl_sl_id = newid()  from tmp_koagul_new t where t.zsl_d3_scid = 8686 /*8581*/ /*and t.zsl_d3_pid in (12165210, 12165211, 12165212) /*11483319*/ */  and t.zsl_idcase /*is null*/ = /*2*/ 3
update tmp_koagul_new  
   set sl_d3_zslgid = zsl_zsl_id, 
       usl_d3_slgid = sl_sl_id, 
       zsl_d3_pgid  = p_id_pac
--SELECT *       
from tmp_koagul_new t 
where t.zsl_d3_scid = 9160 /*8581*/   /*and t.zsl_d3_pid in (12165210, 12165211, 12165212) /*= 11483319*/ */  and t.zsl_idcase /*is null*/ = /*2*/ 3
  --AND zsl_id = 12405106
--commit tran
--rollback tran

select *
from tmp_koagul_new t
where t.zsl_d3_scid = 9160
   and t.zsl_idcase is null

--begin tran
update tmp_koagul_new  
   set usl_vid_vme = 'A12.05.027', usl_code_usl = 'R01.001.013', zsl_idcase = 1 
from tmp_koagul_new t 
where t.zsl_d3_scid = 9160 /*8581*/  /* and t.zsl_d3_pid in (12165210, 12165211, 12165212) /*= 11483319*/ */  --and t.zsl_idcase is null /*= 1*/
  AND t.usl_VID_VME = 'B03.005.006'
--commit tran
--rollback tran

--begin tran
/*update tmp_koagul_new  
   set zsl_idcase = 1 
from tmp_koagul_new t 
where t.zsl_d3_scid = 8686 /*8581*/ /*  and t.zsl_d3_pid in (12165210, 12165211, 12165212) /*= 11483319*/ */  --and t.zsl_idcase is null /*= 1*/
  AND t.usl_vid_vme = 'A12.05.027'*/
--commit tran
--rollback tran


--проверка
select *     
  from tmp_koagul_new t 
 where t.zsl_d3_scid = 9160 /*8581*/
   --and t.zsl_d3_pid in (12165210, 12165211, 12165212)	--11483319
   and t.zsl_idcase is null /*= 2*/ /*3*/








/*
--очистка таблицы
--begin tran 
delete 
from tmp_koagul

--commit tran 
--rollback tran 
*/

--------------------------------------------------------------------------------------------------------------------------------------------

--3. вставка данных из временной таблицы tmp_koagul_new в таблицы D3_ZSL_OMS, D3_SL_OMS, d3_usl_oms и D3_PACIENT_OMS
--3.1. вставка в таблицу D3_ZSL_OMS
--begin tran
--DECLARE @p1 INT = 8686 /*8581*/          --старый счёт
--	   ,@p2 INT = 8858 /*8582*/			--новый счёт
/*
insert into D3_ZSL_OMS(--[ID],
	[ZSL_ID],
	[D3_PID],
	[D3_PGID],
	[D3_SCID],
	[IDCASE],
	[VIDPOM],
	[FOR_POM],
	[NPR_MO],
	[LPU],
	[DATE_Z_1],
	[DATE_Z_2],
	[RSLT],
	[ISHOD],
	[IDSP],
	[SUMV],
	[MTR],
	[USL_OK],
	[NPR_DATE],
	[PR_NOV],
	[SysDtChange])
*/
select --  id!!!!!
		--t.zsl_ID,   --&&&&&&&&&&&&&&&&&
		t.zsl_ZSL_ID,
		t.zsl_D3_PID,
		t.zsl_D3_PGID,
		/*@p2*/9160,  /*8578,*/  --t.zsl_D3_SCID,		--вставляем новый счёт
		t.zsl_IDCASE,
		t.zsl_VIDPOM,
		t.zsl_FOR_POM,
		t.zsl_NPR_MO,
		t.zsl_LPU,
		t.zsl_DATE_Z_1,
		t.zsl_DATE_Z_2,
		t.zsl_RSLT,
		t.zsl_ISHOD,
		t.zsl_IDSP,
		t.zsl_SUMV,
		t.zsl_MTR,
		t.zsl_USL_OK,
		t.zsl_NPR_DATE,
		t.zsl_PR_NOV,
		GETDATE() --t.zsl_SysDtChange

  from tmp_koagul_new t 
 where t.zsl_d3_scid = 9160 /*@p1*/ /*8581*/ /*8516*/   /*and t.zsl_d3_pid in (12165210, 12165211, 12165212)*/  /*= 11483319*/
  -- and t.zsl_idcase = /*1*/  /*2*/ 3
--commit tran
--rollback tran

SELECT *
FROM D3_ZSL_OMS zsl 
WHERE zsl.ZSL_ID IN ('29C6C8EB-9F9B-4C89-8D40-9EF70B4DF097', 'EF24760D-1C91-4399-AECA-C1782BB2F59F', '8F5ACC77-9790-4EE2-86F1-F020A49096A8') 

/*DELETE 
FROM D3_ZSL_OMS  
WHERE IDCASE = 138675*/

--проверка
select *
from D3_ZSL_OMS zsl 
where zsl.D3_SCID IN (9160)
  AND zsl.ZSL_ID IN ('29C6C8EB-9F9B-4C89-8D40-9EF70B4DF097', 'EF24760D-1C91-4399-AECA-C1782BB2F59F', '8F5ACC77-9790-4EE2-86F1-F020A49096A8') 		--in ( 8582, 8581)

--3.2. вставка в таблицу D3_SL_OMS
--begin tran 
--DECLARE @p1 INT = 8686 /*8581*/  --старый счёт

insert into D3_SL_OMS([D3_ZSLID],
						[D3_ZSLGID],
						[SL_ID],
						[LPU_1],
						[PROFIL],
						[DET],
						[P_CEL],
						[NHISTORY],
						[DATE_1],
						[DATE_2],
						[DS1],
						[PRVS],
						[VERS_SPEC],
						[IDDOKT],
						[ED_COL],
						[TARIF],
						[SUM_M],
						[PRVS21],
						[P_CEL25])
					
select --t.sl_ID, -- zsl.id as zslid_new,
    zsl.id ,     --t.sl_D3_ZSLID,
	t.sl_D3_ZSLGID,
	t.sl_SL_ID,
	t.sl_LPU_1,
	t.sl_PROFIL,
	t.sl_DET,
	t.sl_P_CEL,
	t.sl_NHISTORY,
	t.sl_DATE_1,
	t.sl_DATE_2,
	t.sl_DS1,
	t.sl_PRVS,
	t.sl_VERS_SPEC,
	t.sl_IDDOKT,
	t.sl_ED_COL,
	t.sl_TARIF,
	t.sl_SUM_M,
	t.sl_PRVS21,
	t.sl_P_CEL25
--select *
  from tmp_koagul_new t 
left join D3_ZSL_OMS zsl  on t.zsl_zsl_id = zsl.zsl_id   and t.zsl_d3_pid = zsl.d3_pid    and t.zsl_idcase = zsl.idcase --and t.zsl_id <> zsl.id and t.zsl_d3_scid <> zsl.d3_scid
 where t.zsl_d3_scid = 9160 /*@p1*/  /*8581*/ /*8516*/   --and t.zsl_d3_pid in (12165210, 12165211, 12165212)  /*= 11483319*/ 
   --and t.zsl_idcase = /*1*/ /*2*/ 3
   --AND zsl.IDCASE <> 138675
   AND  zsl.ZSL_ID IN ('29C6C8EB-9F9B-4C89-8D40-9EF70B4DF097', 'EF24760D-1C91-4399-AECA-C1782BB2F59F', '8F5ACC77-9790-4EE2-86F1-F020A49096A8') 
--commit tran 
--rollback tran 

--проверка
/*
select *
from D3_ZSL_OMS zsl 
inner join D3_SL_OMS sl on sl.D3_ZSLID=zsl.ID
where zsl.D3_SCID in (9160)		--( 8578, 8516)
*/

--3.3. вставка в таблицу d3_usl_oms
--begin tran
--DECLARE @p1 INT = 8686 /*8581*/  --старый счёт

insert into d3_usl_oms(--[ID],
						[D3_SLID],
						[D3_ZSLID],
						[D3_SLGID],
						[IDSERV],
						[LPU],
						[PROFIL],
						[VID_VME],
						[DET],
						[DATE_IN],
						[DATE_OUT],
						[DS],
						[CODE_USL],
						[KOL_USL],
						[SUMV_USL],
						[PRVS],
						[CODE_MD])

select	sl.id,	--t.usl_D3_SLID,
		sl.D3_ZSLID,	--t.usl_D3_ZSLID,
		sl.sl_id,	--t.usl_D3_SLGID,
		t.usl_IDSERV,
		t.usl_LPU,
		t.usl_PROFIL,
		t.usl_VID_VME,
		t.usl_DET,
		t.usl_DATE_IN,
		t.usl_DATE_OUT,
		t.usl_DS,
		t.usl_CODE_USL,
		t.usl_KOL_USL,
		t.usl_SUMV_USL,
		t.usl_PRVS,
		t.usl_CODE_MD
--select *
  from tmp_koagul_new t 
  left join D3_SL_OMS sl on t.sl_d3_zslgid = sl.d3_zslgid
  where /*t.usl_idserv = /*1*/ /*2*/ 3
    and*/ sl.d3_zslid in (select zsl.id      --t.sl_D3_ZSLID,
						  from tmp_koagul_new t2 
						left join D3_ZSL_OMS zsl  on t2.zsl_zsl_id = zsl.zsl_id   and t2.zsl_d3_pid = zsl.d3_pid    and t2.zsl_idcase = zsl.idcase --and t2.zsl_id <> zsl.id and t2.zsl_d3_scid <> zsl.d3_scid
						 where t2.zsl_d3_scid = 9160 /*@p1*/ 
						   /*and t2.zsl_idcase = /*1*/ /*2*/ 3*/	)
--commit tran 
--rollback tran

--3.4. вставка в D3_PACIENT_OMS
--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
--begin tran

INSERT INTO D3_PACIENT_OMS
(
	--[ID],
	[D3_SCID] ,
	[ID_PAC],
	[FAM],
	[IM],
	[OT],
	[W],
	[DR],
	[DOCTYPE],
	[DOCSER],
	[DOCNUM],
	[SNILS],
	[VPOLIS],
	[SPOLIS],
	[NPOLIS],
	[SMO],
	[NOVOR],
	[N_ZAP],
	[DOST],
	[DOCDATE],
	[DOCORG],
	[ENP]
)

SELECT --t.p_ID,
	9160,  --t.p_D3_SCID ,   --новый счёт
	t.p_ID_PAC,
	t.p_FAM,
	t.p_IM,
	t.p_OT,
	t.p_W,
	t.p_DR,
	t.p_DOCTYPE,
	t.p_DOCSER,
	t.p_DOCNUM,
	t.p_SNILS,
	t.p_VPOLIS,
	t.p_SPOLIS,
	t.p_NPOLIS,
	t.p_SMO,
	t.p_NOVOR,
	t.p_N_ZAP,
	--t.FIO  AS (rtrim((((isnull(t.FAM,'')+' ')+isnull(t.IM,''))+' ')+isnull(t.OT,''))),
	t.p_DOST,
	t.p_DOCDATE,
	t.p_DOCORG,
	t.p_ENP
FROM tmp_koagul_new t 
WHERE t.p_d3_scid = 9160   --старый счёт
--commit tran 
--rollback tran
-------------------------------------
-------------------------------
select *
from D3_ZSL_OMS zs
--where zs.zsl_id = 'CE44A201-D08D-4806-A02C-43744A94B3A7'
where zs.idcase is null


select *
from [tmp_koagul] t
where t.zsl_d3_scid = 9160

/*
--begin tran 
update tmp_koagul 
   set zsl_d3_scid = 84072
 where zsl_d3_scid = 8407
--commit tran
*/
--проверка 
select zs.ID
	,/*NEWID()*/zs.ZSL_ID
	,zs.D3_PID
	,zs.D3_PGID
	,zs.D3_SCID
	,/*2*/ zs.IDCASE
	,zs.VIDPOM
	,zs.FOR_POM
	,zs.NPR_MO
	,zs.LPU
	,zs.DATE_Z_1
	,zs.DATE_Z_2
	,zs.RSLT
	,zs.ISHOD
	,zs.IDSP
	,zs.SUMV
	,zs.MTR
	,zs.USL_OK
	,zs.NPR_DATE
	,zs.PR_NOV
	,/*GETDATE()*/ zs.SysDtChange
	
	,s.ID
	,s.D3_ZSLID
	,s.D3_ZSLGID
	,s.SL_ID
	,s.LPU_1
	,s.PROFIL
	,s.DET
	,s.P_CEL
	,s.NHISTORY
	,s.DATE_1
	,s.DATE_2
	,s.DS1
	,s.PRVS
	,s.VERS_SPEC
	,s.IDDOKT
	,s.ED_COL
	,s.TARIF
	,s.SUM_M
	,s.PRVS21
	,s.P_CEL25

	,usl.id
	,usl.D3_SLID
	,usl.D3_ZSLID
	,usl.D3_SLGID
	,usl.IDSERV /*'2'*/  /*'3',*/
	,usl.LPU
	,usl.PROFIL
	,usl.VID_VME /*'A12.05.039'*/ /*'A09.05.050',*/
	,usl.DET
	,usl.DATE_IN
	,usl.DATE_OUT
	,usl.DS
	,usl.CODE_USL  /*'R01.001.011'*/ /*'R01.001.012',*/
	,usl.KOL_USL
	,usl.SUMV_USL
	,usl.PRVS
	,usl.CODE_MD
	--,usl.VERS_SPEC
	
	,p.ID
	,p.D3_SCID
	,/*NEWID()*/ p.ID_PAC
	,p.FAM
	,p.IM
	,p.OT
	,p.W
	,p.DR
	,p.DOCTYPE
	,p.DOCSER
	,p.DOCNUM
	,p.SNILS
	,p.VPOLIS
	,p.SPOLIS
	,p.NPOLIS
	,p.SMO
	,p.NOVOR
	,p.N_ZAP
	--,p.FIO
	,p.DOST
	,p.DOCDATE
	,p.DOCORG
	,p.ENP
FROM D3_SCHET_OMS sch                  
inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
								and sch.year=2022 
							    --and sch.month=10 
							    AND sch.id = 9160 /*@p1*/ /*8582*/   /*8686*/			
--inner join D3_ZSL_OMS zs on zs.D3_PID=p.id  and zs.D3_SCID=sch.id 
inner join D3_ZSL_OMS zs on zs.D3_PGID=p.id_pac  and zs.D3_SCID=sch.id
join	   D3_SL_OMS s on s.D3_ZSLID=zs.ID 
JOIN	   d3_usl_oms usl ON usl.D3_SLID=s.id
left join  Yamed_Spr_UslCode u on u.id=usl.vid_vme
LEFT JOIN  f003 ON f003.mcod = zs.NPR_MO
WHERE usl.VID_VME IN ('A12.05.039', 'A09.05.050', 'A12.05.027') 
  AND zs.ZSL_ID IN ('29C6C8EB-9F9B-4C89-8D40-9EF70B4DF097', 'EF24760D-1C91-4399-AECA-C1782BB2F59F', '8F5ACC77-9790-4EE2-86F1-F020A49096A8') 


-----------------------------------
--апдейт ссылки на pid пациента в таблице D3_ZSL_OMS
--begin tran 
--UPDATE zs
  --SET zs.d3_pid = p.id
  SELECT *
FROM  D3_SCHET_OMS sch                  
inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
								and sch.year=2022 
							    --and sch.month=10 
							    AND sch.id = 9160 /*@p1*/ /*8582*/   /*8686*/			
--inner join D3_ZSL_OMS zs on zs.D3_PID=p.id  and zs.D3_SCID=sch.id 
inner join D3_ZSL_OMS zs on zs.D3_PGID=p.id_pac  and zs.D3_SCID=sch.id
join	   D3_SL_OMS s on s.D3_ZSLID=zs.ID 
JOIN	   d3_usl_oms usl ON usl.D3_SLID=s.id
left join  Yamed_Spr_UslCode u on u.id=usl.vid_vme
LEFT JOIN  f003 ON f003.mcod = zs.NPR_MO
  WHERE usl.VID_VME IN ('A12.05.039', 'A09.05.050', 'A12.05.027') 
  AND zs.ZSL_ID IN ('29C6C8EB-9F9B-4C89-8D40-9EF70B4DF097', 'EF24760D-1C91-4399-AECA-C1782BB2F59F', '8F5ACC77-9790-4EE2-86F1-F020A49096A8') 
  --AND p.id = 15937720
 --commit tran 
 --rollback tran.

 
------------------------------
----ещё раз проверка
 select zs.ID
	,/*NEWID()*/zs.ZSL_ID
	,zs.D3_PID
	,zs.D3_PGID
	,zs.D3_SCID
	,/*2*/ zs.IDCASE
	,zs.VIDPOM
	,zs.FOR_POM
	,zs.NPR_MO
	,zs.LPU
	,zs.DATE_Z_1
	,zs.DATE_Z_2
	,zs.RSLT
	,zs.ISHOD
	,zs.IDSP
	,zs.SUMV
	,zs.MTR
	,zs.USL_OK
	,zs.NPR_DATE
	,zs.PR_NOV
	,/*GETDATE()*/ zs.SysDtChange
	
	,s.ID
	,s.D3_ZSLID
	,s.D3_ZSLGID
	,s.SL_ID
	,s.LPU_1
	,s.PROFIL
	,s.DET
	,s.P_CEL
	,s.NHISTORY
	,s.DATE_1
	,s.DATE_2
	,s.DS1
	,s.PRVS
	,s.VERS_SPEC
	,s.IDDOKT
	,s.ED_COL
	,s.TARIF
	,s.SUM_M
	,s.PRVS21
	,s.P_CEL25

	,usl.id
	,usl.D3_SLID
	,usl.D3_ZSLID
	,usl.D3_SLGID
	,usl.IDSERV /*'2'*/  /*'3',*/
	,usl.LPU
	,usl.PROFIL
	,usl.VID_VME /*'A12.05.039'*/ /*'A09.05.050',*/
	,usl.DET
	,usl.DATE_IN
	,usl.DATE_OUT
	,usl.DS
	,usl.CODE_USL  /*'R01.001.011'*/ /*'R01.001.012',*/
	,usl.KOL_USL
	,usl.SUMV_USL
	,usl.PRVS
	,usl.CODE_MD
	--,usl.VERS_SPEC
	
	,p.ID
	,p.D3_SCID
	,/*NEWID()*/ p.ID_PAC
	,p.FAM
	,p.IM
	,p.OT
	,p.W
	,p.DR
	,p.DOCTYPE
	,p.DOCSER
	,p.DOCNUM
	,p.SNILS
	,p.VPOLIS
	,p.SPOLIS
	,p.NPOLIS
	,p.SMO
	,p.NOVOR
	,p.N_ZAP
	--,p.FIO
	,p.DOST
	,p.DOCDATE
	,p.DOCORG
	,p.ENP
FROM D3_SCHET_OMS sch                  
inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
								and sch.year=2022 
							    --and sch.month=10 
							    AND sch.id = 9160 /*@p1*/ /*8582*/   /*8686*/			
inner join D3_ZSL_OMS zs on zs.D3_PID=p.id  and zs.D3_SCID=sch.id 
--inner join D3_ZSL_OMS zs on zs.D3_PGID=p.id_pac  and zs.D3_SCID=sch.id
join	   D3_SL_OMS s on s.D3_ZSLID=zs.ID 
JOIN	   d3_usl_oms usl ON usl.D3_SLID=s.id
left join  Yamed_Spr_UslCode u on u.id=usl.vid_vme
LEFT JOIN  f003 ON f003.mcod = zs.NPR_MO
WHERE usl.VID_VME IN ('A12.05.039', 'A09.05.050', 'A12.05.027') 
  AND zs.ZSL_ID IN ('29C6C8EB-9F9B-4C89-8D40-9EF70B4DF097', 'EF24760D-1C91-4399-AECA-C1782BB2F59F', '8F5ACC77-9790-4EE2-86F1-F020A49096A8') 