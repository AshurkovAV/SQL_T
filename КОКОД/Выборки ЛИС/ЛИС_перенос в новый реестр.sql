/*BEGIN TRAN --commit tran

DECLARE @D3_SCID_old INT = 1290 --старый реестр где они сейчас
DECLARE @D3_SCID_new INT = 4357 --новый реестр куда нужно перенести



UPDATE dz SET dz.D3_SCID = @D3_SCID_new--, dz.pr_nov=1
--SELECT *
FROM D3_ZSL_OMS AS dz
--JOIN ztemp_digCdelete_122021 z ON dz.id = z.zslid --перекресты
--JOIN ztemp_desh_Cdelete_122021_ds_500 z ON dz.id = z.zslid --AND z.ds_onk IS  null--дешевые

--JOIN  ztemp_desh_Cdelete_102021_ks_new_1 z ON dz.id = z.zslid --дешевые
--JOIN  ztemp_covid_112021 z ON dz.id = z.zslid --ковид
--JOIN temp_kokod_V_9_C z ON dz.id = z.zslid --V
--JOIN ztemp_protocol_12021 z ON dz.id = z.zslid 
JOIN ztemp_lis_03021 z ON dz.id = z.zslid 
--WHERE dz.D3_SCID = 2215--AND dz.ID IN (SELECT id FROM @tab)



  SELECT distinct zs.id AS zslid,p.ID AS pid, p.D3_SCID p_D3_SCID, zs.D3_SCID zs_D3_SCID
--INTO ztemp_lis_03021
--,sch.id, zsl.id, p.fio, p.fam, p.ot, p.dr, p.NPOLIS, zsl.USL_OK,zsl.sumv, zsl.DATE_Z_1,f.date_ds,isnull(f.date_end,'20211231')
 FROM [D3_SCHET_OMS] sch                  
inner join D3_PACIENT_OMS p on p.d3_scid=sch.id
inner join D3_ZSL_OMS zs on zs.D3_PID=p.id 

  where --p.vpolis is NULL AND
   --p.D3_SCID 
   sch.id IN ( 4357) AND zs.D3_SCID<>p.D3_SCID
*/   
   
 

--создание временной таблицы
/*
USE [ElmedKokod2]
GO

/****** Object:  Table [dbo].[ztemp_lis_03021]    Script Date: 11.10.2022 9:10:13 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ztmp_lis_1022]([zslid] [int] NOT NULL,
									[pid] [int] NOT NULL,
									[p_D3_SCID] [int] NOT NULL,
									[zs_D3_SCID] [int] NOT NULL
								) ON [PRIMARY]

GO
*/


--добавление данных во временную таблицу
--SELECT *
--FROM ztmp_lis_1022

--begin tran
--INSERT INTO ztmp_lis_1022(zslid, pid, p_D3_SCID, zs_D3_SCID)
SELECT zs.ID, zs.D3_PID, p.D3_SCID,   zs.D3_SCID
FROM [D3_SCHET_OMS] sch                  
 inner join D3_PACIENT_OMS p on p.d3_scid=sch.id
 inner join D3_ZSL_OMS zs on zs.D3_PID=p.id AND sch.code_mo=460061 
 --AND sch.month=5
 AND sch.YEAR=2022  
 and sch.id IN (8684) --(8221)
  join D3_SL_OMS s on s.D3_ZSLID=zs.ID 
  JOIN D3_USL_OMS u ON u.D3_SLID=s.id


join V009 rz on rz.IDRMP=zs.RSLT
left join F011 doc on doc.Id=p.DOCTYPE
LEFT JOIN f003 ON f003.mcod=zs.NPR_MO
--WHERE iddokt is  NULL --AND sch.SchetType LIKE 'H'
--WHERE (ds1 NOT BETWEEN 'C00' AND 'D09.z') and ds1 NOT BETWEEN 'D45' AND 'D47.z'
left JOIN medicalServices AS ms ON ms.code_usl=u.CODE_USL AND u.DATE_IN >=ms.dataBegin AND u.DATE_OUT<=ISNULL(ms.dataEnd,'20991231') AND ms.code_usl  BETWEEN 'R01.001.008' AND 'R01.001.036'
left join Yamed_Spr_UslCode y on y.ID=u.vid_vme	

WHERE zs.EXP_COMENT IS NOT NULL-- LIKE '%номер полиса%' OR zs.EXP_COMENT LIKE '%ENP%' OR zs.EXP_COMENT LIKE '%vpolis%' OR zs.EXP_COMENT LIKE '%временный полис%' 
	--and p.NPOLIS = '4647730829000200'		--'4651430826000039'
	--AND replace(replace(zs.EXP_COMENT, CHAR(10), ''), CHAR(13), '') like 'МЭК - Дублирование рег услуг в одном реестре%'
	AND u.VID_VME = 'B03.005.006'
	AND p.NPOLIS IN ('4676940845000167', '4651430826000039', '4673150898000139', '4655630832000230', '4653640872000232', '4673250896000055')
--commit tran 	

--перенос в новый реестр
--begin tran 
DECLARE @D3_SCID_old INT = 8684 /*1290*/ --старый реестр где они сейчас
DECLARE @D3_SCID_new INT = 8686 /*4357*/ --новый реестр куда нужно перенести

UPDATE dz SET dz.D3_SCID = @D3_SCID_new--, dz.pr_nov=1
--SELECT *
FROM D3_ZSL_OMS AS dz
JOIN ztmp_lis_1022  z ON dz.id = z.zslid 

--commit tran 