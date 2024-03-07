--вставка услуг Коагулограммы
/*
 1у услугу  B03.005.006 (code_usl = 'R01.001.999') заменяем на: 
 A12.05.039 Активированное частичное тромбопластиновое время  R01.001.011 сумма 78,96
 A09.05.050 Исследование уровня фибриногена в крови R01.001.012 сумма 113,57
 A12.05.027 Протромбин, МНО R01.001.013 сумма 68,14
*/
--BEGIN TRAN 
--commit tran
/*
INSERT INTO D3_USL_OMS (
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
	[CODE_MD],
	[VERS_SPEC]
	)
*/	
SELECT 
	usl.D3_SLID,
	usl.D3_ZSLID,
	usl.D3_SLGID,
	'2',  /*'3',*/
	usl.LPU,
	usl.PROFIL,
	'A12.05.039', /*'A09.05.050',*/
	usl.DET,
	usl.DATE_IN,
	usl.DATE_OUT,
	usl.DS,
	'R01.001.011', /*'R01.001.012',*/
	usl.KOL_USL,
	usl.SUMV_USL,
	usl.PRVS,
	usl.CODE_MD,
	usl.VERS_SPEC
	
FROM	   D3_SCHET_OMS sch                  
inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
								and sch.year=2022 
							    and sch.month=9 
							    AND sch.id IN (8516)
inner join D3_ZSL_OMS zs on zs.D3_PID=p.id  and zs.D3_SCID=sch.id 
join	   D3_SL_OMS s on s.D3_ZSLID=zs.ID 
JOIN	   d3_usl_oms usl ON usl.D3_SLID=s.id
left join  Yamed_Spr_UslCode u on u.id=usl.vid_vme
LEFT JOIN  f003 ON f003.mcod=zs.NPR_MO

WHERE usl.VID_VME = 'B03.005.006'


------------------------------------------------
/*заменяем исходную услугу B03.005.006 на A12.05.027*/
--BEGIN TRAN 
--commit tran
/*UPDATE D3_USL_OMS
   SET /*IDSERV = 1,*/
	   VID_VME = 'A12.05.027',
	   CODE_USL = 'R01.001.013'
*/	
SELECT f003.nam_mok, 
	npolis, 
	sch.id AS schid_old,
	p.fam,
	p.im,
	p.ot,
	p.dr,
	p.ID D3_PID,
	sch.id AS sch_id, 
	zs.ISHOD,
	usl.D3_SLID,
	usl.D3_ZSLID,
	usl.D3_SLGID,
	usl.IDSERV,
	usl.LPU,
	usl.PROFIL,
	usl.VID_VME,
	usl.DET,
	usl.DATE_IN,
	usl.DATE_OUT,
	usl.DS,
	usl.CODE_USL,
	usl.KOL_USL,
	usl.SUMV_USL,
	usl.PRVS,
	usl.CODE_MD,
	usl.VERS_SPEC,
	usl.PRVS_VERS 
	
FROM D3_SCHET_OMS sch                  
inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
								and sch.year=2022 
							    and sch.month=9 
							    AND sch.id IN (8516)
inner join D3_ZSL_OMS zs on zs.D3_PID=p.id  and zs.D3_SCID=sch.id 
join	   D3_SL_OMS s on s.D3_ZSLID=zs.ID 
JOIN	   d3_usl_oms usl ON usl.D3_SLID=s.id
left join  Yamed_Spr_UslCode u on u.id=usl.vid_vme
LEFT JOIN  f003 ON f003.mcod=zs.NPR_MO

WHERE usl.VID_VME = 'B03.005.006'


--BEGIN tran
--DELETE FROM  D3_USL_OMS 
SELECT *
FROM D3_USL_OMS usl 
WHERE D3_SLID = 11862170
  AND VID_VME <> 'B03.005.006'
--COMMIT TRAN

--BEGIN TRAN 
/*UPDATE D3_USL_OMS
   SET 
	   VID_VME = 'B03.005.006',
	   CODE_USL = 'R01.001.999'
*/	 
/*SELECT f003.nam_mok, 
	npolis, 
	sch.id AS schid_old,
	p.fam,
	p.im,
	p.ot,
	p.dr,
	p.ID D3_PID,
	sch.id AS sch_id, 
	zs.ISHOD,
	usl.D3_SLID,
	usl.D3_ZSLID,
	usl.D3_SLGID,
	usl.IDSERV,
	usl.LPU,
	usl.PROFIL,
	usl.VID_VME,
	usl.DET,
	usl.DATE_IN,
	usl.DATE_OUT,
	usl.DS,
	usl.CODE_USL,
	usl.KOL_USL,
	usl.SUMV_USL,
	usl.PRVS,
	usl.CODE_MD,
	usl.VERS_SPEC,
	usl.PRVS_VERS 
 */ 
FROM D3_SCHET_OMS sch                  
inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
								and sch.year=2022 
							    and sch.month=9 
							    AND sch.id IN (8516)
inner join D3_ZSL_OMS zs on zs.D3_PID=p.id  and zs.D3_SCID=sch.id 
join	   D3_SL_OMS s on s.D3_ZSLID=zs.ID 
JOIN	   d3_usl_oms usl ON usl.D3_SLID=s.id
left join  Yamed_Spr_UslCode u on u.id=usl.vid_vme
LEFT JOIN  f003 ON f003.mcod=zs.NPR_MO

WHERE usl.IDSERV = 1

--COMMIT TRAN 
------------------------------------------------------------------------
--вставка услуг Коагулограммы2
--1. копируем z_sl, sl, usl дважды
--2. апдейтим нужные теги

--1. вставка z_sl 
--begin tran
/*INSERT INTO D3_ZSL_OMS(
--zs.ID
	zs.ZSL_ID
	,zs.D3_PID
	,zs.D3_PGID
	,zs.D3_SCID
	,zs.IDCASE
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
	--,zs.SumO
	,zs.SysDtChange)
*/	
SELECT --zs.ID,
	NEWID()--zs.ZSL_ID
	,zs.D3_PID
	,zs.D3_PGID
	,zs.D3_SCID
	,2--,zs.IDCASE
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
	--,zs.SumO
	,GETDATE() --,zs.SysDtChange
FROM D3_SCHET_OMS sch                  
inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
								and sch.year=2022 
							    and sch.month=9 
							    AND sch.id IN (8516)
inner join D3_ZSL_OMS zs on zs.D3_PID=p.id  and zs.D3_SCID=sch.id 
join	   D3_SL_OMS s on s.D3_ZSLID=zs.ID 
JOIN	   d3_usl_oms usl ON usl.D3_SLID=s.id
left join  Yamed_Spr_UslCode u on u.id=usl.vid_vme
LEFT JOIN  f003 ON f003.mcod=zs.NPR_MO

WHERE usl.VID_VME = 'B03.005.006'
  AND zs.D3_PID = 11483319
--rollback tran
----commit tran  
  --9C5FB10C-0113-4B05-83F6-2556A09E39D7	1 idcase
  --F37274BD-1BED-4DC0-935C-4AA7899F892E    2 idcase
  
  
  SELECT *
	FROM   D3_ZSL_OMS zsl
   WHERE zsl.D3_PID = 11483319
     AND zsl.D3_SCID = 8516
  
--2. sl копируем без изменений
--begin tran
/*insert into  D3_SL_OMS(D3_ZSLID
	,D3_ZSLGID
	,SL_ID
	,LPU_1
	,PROFIL
	,DET
	,P_CEL
	,NHISTORY
	,DATE_1
	,DATE_2
	,DS1
	,PRVS
	,VERS_SPEC
	,IDDOKT
	,ED_COL
	,TARIF
	,SUM_M
	,PRVS21
	,P_CEL25
	)*/
SELECT --s.ID
	s.D3_ZSLID
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
	--,s.PRVS_VERS
FROM D3_SCHET_OMS sch                  
inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
								and sch.year=2022 
							    and sch.month=9 
							    AND sch.id IN (8516)
inner join D3_ZSL_OMS zs on zs.D3_PID=p.id  and zs.D3_SCID=sch.id 
join	   D3_SL_OMS s on s.D3_ZSLID=zs.ID 
JOIN	   d3_usl_oms usl ON usl.D3_SLID=s.id
left join  Yamed_Spr_UslCode u on u.id=usl.vid_vme
LEFT JOIN  f003 ON f003.mcod=zs.NPR_MO

WHERE usl.VID_VME = 'B03.005.006'
  AND zs.D3_PID = 11483319
--commit tran
--rollback tran  
  
--обновить в SL: D3_ZSLID, D3_ZSLGID
--1) сохранить ID, ZSL_ID из D3_ZSL_OMS во  временную табл
/*USE [ElmedKokod2]
GO
CREATE TABLE [dbo].[tmp_D3_ZSL_OMS_for_update](
	[ID] [int]  NOT NULL,
	[ZSL_ID] [nvarchar](36) NULL,
	[D3_PID] [int] NOT NULL,
	[D3_SCID] [int] NOT NULL,
	[IDCASE] [numeric](11, 0) NULL,
	[DATE_Z_1] [datetime] NULL,
	[SysDtChange] [datetime] NULL)
*/

/*SELECT *
FROM tmp_D3_ZSL_OMS_for_update
*/
--вставка
--begin tran
/*INSERT INTO tmp_D3_ZSL_OMS_for_update([ID],
	[ZSL_ID],
	[D3_PID],
	[D3_SCID],
	[IDCASE],
	[DATE_Z_1],
	[SysDtChange])*/
  SELECT zsl.id, zsl.ZSL_ID, zsl.D3_PID, zsl.D3_SCID, zsl.IDCASE, zsl.DATE_Z_1, zsl.SysDtChange
	FROM   D3_ZSL_OMS zsl
   WHERE zsl.D3_PID = 11483319
     AND zsl.D3_SCID = 8516 
	 AND zsl.id IN (SELECT MAX(zsl1.ID)
	                 FROM D3_ZSL_OMS zsl1 
	                WHERE zsl1.D3_PID = 11483319
					  AND zsl1.D3_SCID = 8516)
					  			  
					  
					  
--commit tran 					  
--11873291	F37274BD-1BED-4DC0-935C-4AA7899F892E	2022-09-26 15:12:26.313					  
--11521739	9C5FB10C-0113-4B05-83F6-2556A09E39D7	11483319	8516	1	2022-08-18 00:00:00.000	2022-09-16 13:39:47.180

--2) ОБНОВИТЬ D3_SL_OMS
--begin tran     
  UPDATE D3_SL_OMS
     SET D3_ZSLID = 11521739
		,D3_ZSLGID = '9C5FB10C-0113-4B05-83F6-2556A09E39D7'  
		--,sl_id = newid()

--	SELECT *
	FROM D3_SL_OMS sl
	WHERE 	sl.D3_ZSLGID = 'F37274BD-1BED-4DC0-935C-4AA7899F892E'
		AND sl.ID in (SELECT  min(sl1.ID)	
		              FROM	 D3_SL_OMS sl1	 
		              WHERE  sl1.D3_ZSLGID = 'F37274BD-1BED-4DC0-935C-4AA7899F892E')
--commit tran 		
--
--проверка
SELECT * 
FROM   D3_SL_OMS sl
WHERE sl.D3_ZSLID IN (11521739, 11873291)         

--BEGIN TRAN  
--UPDATE D3_SL_OMS
  --SET  sl_id = newid()
  
--select *
FROM D3_SL_OMS sl
WHERE 	sl.D3_ZSLGID = 'F37274BD-1BED-4DC0-935C-4AA7899F892E'
--commit tran 

--3. добавить новый USL, копируем его без изменений, вставляя новые IDSERV, VID_VME, CODE_USL
--begin tran
INSERT INTO D3_USL_OMS (
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
	[CODE_MD],
	[VERS_SPEC]
	)
	
SELECT usl.*
	/*usl.D3_SLID,
	usl.D3_ZSLID,
	usl.D3_SLGID,
	'2',  /*'3',*/
	usl.LPU,
	usl.PROFIL,
	'A12.05.039', /*'A09.05.050',*/
	usl.DET,
	usl.DATE_IN,
	usl.DATE_OUT,
	usl.DS,
	'R01.001.011', /*'R01.001.012',*/
	usl.KOL_USL,
	usl.SUMV_USL,
	usl.PRVS,
	usl.CODE_MD,
	usl.VERS_SPEC
	*/
FROM	   D3_SCHET_OMS sch                  
inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
								and sch.year=2022 
							    and sch.month=9 
							    AND sch.id IN (8516)
inner join D3_ZSL_OMS zs on zs.D3_PID=p.id  and zs.D3_SCID=sch.id 
join	   D3_SL_OMS s on s.D3_ZSLID=zs.ID 
JOIN	   d3_usl_oms usl ON usl.D3_SLID=s.id
left join  Yamed_Spr_UslCode u on u.id=usl.vid_vme
LEFT JOIN  f003 ON f003.mcod=zs.NPR_MO

WHERE usl.VID_VME = 'B03.005.006'
--commit tran 

--проверка
SELECT usl.D3_SLID,
	usl.D3_ZSLID,
	usl.D3_SLGID,
	usl.IDSERV, --'2',  /*'3',*/
	usl.LPU,
	usl.PROFIL,
	usl.VID_VME,  --'A12.05.039', /*'A09.05.050',*/
	usl.DET,
	usl.DATE_IN,
	usl.DATE_OUT,
	usl.DS,
	usl.CODE_USL,  --'R01.001.011', /*'R01.001.012',*/
	usl.KOL_USL,
	usl.SUMV_USL,
	usl.PRVS,
	usl.CODE_MD,
	usl.VERS_SPEC
FROM d3_usl_oms usl
WHERE usl.id IN (SELECT usl1.id 
                 FROM D3_SCHET_OMS sch                  
					inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
													and sch.year=2022 
													and sch.month=9 
													AND sch.id IN (8516)
					inner join D3_ZSL_OMS zs on zs.D3_PID=p.id  and zs.D3_SCID=sch.id 
					join	   D3_SL_OMS s on s.D3_ZSLID=zs.ID 
					JOIN	   d3_usl_oms usl1 ON usl1.D3_SLID=s.id
					left join  Yamed_Spr_UslCode u on u.id=usl1.vid_vme
					LEFT JOIN  f003 ON f003.mcod=zs.NPR_MO)
					
--теперь апдейт записи с IDSERV = 2, присваиваем D3_SLID, D3_ZSLID, D3_SLGID из новой записи в таблице D3_SL_OMS
--проверим, какие id присвоены новой записи в D3_ZSL_OMS
SELECT * 
FROM   D3_SL_OMS sl
WHERE sl.D3_ZSLID IN (11521739, 11873291) 

--апдейтить d3_usl_oms с idserv = 2, заменять D3_SLID, D3_ZSLID, D3_SLGID на:  12533214, 11873291, 'F37274BD-1BED-4DC0-935C-4AA7899F892E'
--begin tran 
--UPDATE d3_usl_oms
--  SET D3_SLID = 12533214
--		,D3_ZSLID = 11873291
--		,D3_SLGID = 'F37274BD-1BED-4DC0-935C-4AA7899F892E'
  
select usl.D3_SLID,
	usl.D3_ZSLID,
	usl.D3_SLGID,
	usl.IDSERV, --'2',  /*'3',*/
	usl.LPU,
	usl.PROFIL,
	usl.VID_VME,  --'A12.05.039', /*'A09.05.050',*/
	usl.DET,
	usl.DATE_IN,
	usl.DATE_OUT,
	usl.DS,
	usl.CODE_USL,  --'R01.001.011', /*'R01.001.012',*/
	usl.KOL_USL,
	usl.SUMV_USL,
	usl.PRVS,
	usl.CODE_MD,
	usl.VERS_SPEC  
FROM d3_usl_oms usl 
WHERE usl.id IN (SELECT usl1.id 
                 FROM D3_SCHET_OMS sch                  
					inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
													and sch.year=2022 
													and sch.month=9 
													AND sch.id IN (8516)
					inner join D3_ZSL_OMS zs on zs.D3_PID=p.id  and zs.D3_SCID=sch.id 
					join	   D3_SL_OMS s on s.D3_ZSLID=zs.ID 
					JOIN	   d3_usl_oms usl1 ON usl1.D3_SLID=s.id
					left join  Yamed_Spr_UslCode u on u.id=usl1.vid_vme
					LEFT JOIN  f003 ON f003.mcod=zs.NPR_MO)
  AND usl.					
					
--commit tran