SELECT * --DISTINCT [zsl_id]
FROM [tmp_jan_dubli4] AS td
--28481354	28654759
--4754

--begin tran   --commit tran  --rollback tran
/*DELETE FROM tmp_dec_dubli_usl
WHERE zsl_id = 28481354
*/

USE [ElmedKokod2]
GO
CREATE TABLE [dbo].[tmp_jan_dubli4]([zsl_id] [int] NOT NULL,
									 [pid] [int] NOT NULL	)
									 
/*									 
USE [ElmedKokod2]
GO
CREATE TABLE [dbo].[tmp_jan_dubli_usl]([usl_id] [int] NOT NULL)		
*/																 

/*									 
USE [ElmedKokod2]
GO
CREATE TABLE [dbo].[tmp_novemb_newUSL]([zsl_id] [int] NOT NULL,
									 [pid] [int] NOT NULL	)*/

--begin tran   --commit tran   --1641
--insert into [tmp_jan_dubli3]([zsl_id],
							  [pid])

/*
SELECT v.zslid as zsl_id, v.pid 
--into temp_lis_duble_6_26
from
(
SELECT --distinct usl.CODE_USL, usl.VID_VME,u.name

 distinct  ROW_NUMBER() OVER(PARTITION BY usl.CODE_USL, usl.VID_VME,p.fam,p.im,isnull(p.ot,''),p.dr,usl.DATE_IN order BY usl.CODE_USL, usl.VID_VME,p.fam,p.im,isnull(p.ot,''),p.dr,usl.DATE_IN) 
    n_p_p,
    sch.id, zs.id zslid,p.id as pid,s.nhistory, zs.NPR_MO, f003.nam_mok,usl.CODE_USL, usl.VID_VME,u.name, p.npolis,usl.DATE_IN, p.fam,p.im,isnull(p.ot,'') ot,p.dr,zs.D3_SCID AS zs_schid,p.D3_SCID AS p_schid
--sch.id, zs.id, usl.CODE_USL, usl.VID_VME,ms.ishod,zs.ISHOD

FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
  and sch.year=2024 and sch.month= 1 AND   sch.id   IN (18419)
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id  and zs.[D3_SCID]=sch.id --and zs.usl_ok in (1,2) --AND zs.id=20906231
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID 
 JOIN d3_usl_oms usl ON usl.D3_SLID=s.id
left join Yamed_Spr_UslCode u on u.id=usl.vid_vme
LEFT JOIN f003 ON f003.mcod=zs.NPR_MO
JOIN(
select usl.CODE_USL, usl.VID_VME,  isnull(p.npolis, p.ENP) npolis ,usl.DATE_IN,COUNT(*) kol_vo
--sch.id, zs.id, usl.CODE_USL, usl.VID_VME,ms.ishod,zs.ISHOD

FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
  and sch.year=2024 and sch.month = 1 AND   sch.id   IN (18419)
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id  and zs.[D3_SCID]=sch.id    --and zs.usl_ok in (1,2) --AND zs.id=20906231
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID 
 JOIN d3_usl_oms usl ON usl.D3_SLID=s.id
JOIN medicalServices AS ms ON ms.code_usl=usl.CODE_USL AND usl.DATE_IN >=ms.dataBegin AND usl.DATE_OUT<=ISNULL(ms.dataEnd,'20241231')
where p.npolis not like ''-- AND npolis LIKE '4670050885000154'
GROUP BY  usl.CODE_USL, usl.VID_VME, isnull(p.npolis, p.ENP),usl.DATE_IN
HAVING COUNT(*)>1
) t ON t.npolis=isnull(p.NPOLIS, p.enp) AND t.CODE_USL=usl.CODE_USL AND t.vid_vme=usl.VID_VME
--ORDER BY npolis,p.fam,p.im,isnull(p.ot,''),p.dr, usl.CODE_USL, usl.VID_VME,usl.date_in

) 
v
WHERE n_p_p>1
--*/
--1596
-------------
--/* 

--begin tran   --commit tran   --2656  --rollback tran
--insert into [tmp_jan_dubli4]([zsl_id]
							  ,[pid])

 SELECT 

 DISTINCT  
		zs.ID AS zsl_id, p.ID AS pid
		
 /*
 zs.ZSL_ID, p.NPOLIS, p.ENP , --, p.SMO as [Страховая компания],
				p.fam AS [Фамилия]
				,p.im AS [Имя]
				,isnull(p.ot,'') AS [Отчество] 
				,p.W as [Пол]
				,p.DR as [Дата рождения]
				,replace(replace(zs.EXP_COMENT, CHAR(10), ''), CHAR(13), '') AS [ОСП] 
				--,COUNT(zs.id) AS [кол-во]
				,f003.nam_mok AS [Направившая МО]
				,p.SMO as [Страховая компания]
				,p.VPOLIS
				,p.SPOLIS
				,p.NPOLIS
				,p.ENP
				--/*
				,zs.DATE_Z_1
				,u.VID_VME
				,u.CODE_USL
				,p.DOCTYPE, p.DOCSER, p.DOCNUM, p.DOCDATE, p.DOCORG
				,p.ID
				,u.CODE_MD
				,zs.OS_SLUCH
				,zs.ISHOD
				,zs.ID
				,zs.ZSL_ID
				,u.ID
				,zs.OS_SLUCH
				--*/
  --,zs.SUMV
*/ 
--SELECT MAX(u.ID)
FROM [D3_SCHET_OMS] sch                  
 inner join D3_PACIENT_OMS p on p.d3_scid=sch.id
 inner join D3_ZSL_OMS zs on zs.D3_PID=p.id AND sch.code_mo = 460061 
 --AND sch.month=5
 AND sch.YEAR = 2024
 and sch.id IN ( /*11794*/ 18419) 
  join D3_SL_OMS s on s.D3_ZSLID=zs.ID 
  JOIN D3_USL_OMS u ON u.D3_SLID=s.id


join V009 rz on rz.IDRMP=zs.RSLT
left join F011 doc on doc.Id=p.DOCTYPE
   LEFT JOIN f003 ON f003.mcod=zs.NPR_MO
   
--WHERE iddokt is  NULL --AND sch.SchetType LIKE 'H'
--WHERE (ds1 NOT BETWEEN 'C00' AND 'D09.z') and ds1 NOT BETWEEN 'D45' AND 'D47.z'
--/*
left JOIN medicalServices AS ms ON ms.code_usl=u.CODE_USL AND u.DATE_IN >=ms.dataBegin AND u.DATE_OUT<=ISNULL(ms.dataEnd,'20991231') AND ms.code_usl  BETWEEN 'R01.001.008' AND 'R01.001.036'
left join Yamed_Spr_UslCode y on y.ID=u.vid_vme	
--*/
--WHERE zs.EXP_COMENT /*IS NOT NULL */ /*LIKE '% CODE_USL не из справочника;  в случае должна быть одна услуга;%'*/  /*LIKE '%Дублирование рег услуг в одном реестре%'*/   --OR zs.EXP_COMENT LIKE '%ENP%' OR zs.EXP_COMENT LIKE '%vpolis%' OR zs.EXP_COMENT LIKE '%временный полис%' 
 --WHERE zs.EXP_COMENT LIKE '%в случае должна быть одна услуг%';
 WHERE zs.EXP_COMENT LIKE '%Дублирование рег услуг в одном реестре%'; 
 --OR zs.EXP_COMENT LIKE '%CODE_USL не из справочника;%'
 --ORDER BY zs.ZSL_ID
--GROUP BY sch.ID, zs.ZSL_ID, s.ID
--HAVING COUNT(*) > 1
/* and p.FAM = 'Горяинов'
   AND p.IM = 'Анатолий'*/
 -- */
 
--51


--------------------------------------------------------------------------
----перенос
BEGIN TRAN --commit tran --rollback

--DECLARE @D3_SCID_old INT = 11837 /*, 12861, 13878*/  --старый реестр где они сейчас
DECLARE @D3_SCID_new INT =   /*18451*/ /*18470*/ 18482 --новый реестр куда нужно перенести

UPDATE dpo SET dpo.D3_SCID = @D3_SCID_new

--SELECT dpo.id pid,dpo.D3_SCID p_sc
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dzo ON dzo.D3_PID = dpo.ID
--JOIN tmp_jan_dubli4 z ON dpo.ID = z.pid --дубли ЛИС
WHERE dzo.D3_SCID  IN ( /*18419*/ /*18471*/ 18484) --AND ds_onk IS   null-- IN(Select 
--69783

UPDATE dz SET dz.D3_SCID = @D3_SCID_new--, dz.pr_nov=1--, sump=null
--SELECT *
FROM D3_ZSL_OMS AS dz
--JOIN tmp_jan_dubli4 z ON dz.id = z.zsl_id   --дубли ЛИС 
WHERE dz.D3_SCID IN ( /*18419*/ /*18471*/ 18484 ) --AND ds_onk IS   null --(Select 

--69783
--						) AND dso.DS_ONK IS  NULL



--rollback
--select * from  ztemp_protocol_08022
--SELECT * FROM lis_032022_17306

-----------------------------
--если нужно удалить дубли из услуг
USE [ElmedKokod2]
GO
CREATE TABLE [dbo].[tmp_jan_dubli_usl2]([usl_id] [int] NOT NULL)

SELECT * --DISTINCT [zsl_id]
FROM [tmp_jan_dubli_usl2] AS td
/*
BEGIN TRAN 
DELETE FROM tmp_jan_dubli_usl2
COMMIT tran
*/


begin tran   --commit tran   --2   --rollback tran
insert into [tmp_jan_dubli_usl2]([usl_id])
							  
							  
SELECT MAX(u.ID)
FROM [D3_SCHET_OMS] sch                  
 inner join D3_PACIENT_OMS p on p.d3_scid=sch.id
 inner join D3_ZSL_OMS zs on zs.D3_PID=p.id AND sch.code_mo=460061 
 --AND sch.month=5
 AND sch.YEAR = 2024
 and sch.id IN ( /*11794*/ /*17344*/ /*17399*/ 18419) 
  join D3_SL_OMS s on s.D3_ZSLID=zs.ID 
  JOIN D3_USL_OMS u ON u.D3_SLID=s.id


join V009 rz on rz.IDRMP=zs.RSLT
left join F011 doc on doc.Id=p.DOCTYPE
   LEFT JOIN f003 ON f003.mcod=zs.NPR_MO
--WHERE iddokt is  NULL --AND sch.SchetType LIKE 'H'
--WHERE (ds1 NOT BETWEEN 'C00' AND 'D09.z') and ds1 NOT BETWEEN 'D45' AND 'D47.z'
left JOIN medicalServices AS ms ON ms.code_usl=u.CODE_USL AND u.DATE_IN >=ms.dataBegin AND u.DATE_OUT<=ISNULL(ms.dataEnd,'20991231') AND ms.code_usl  BETWEEN 'R01.001.008' AND 'R01.001.036'
left join Yamed_Spr_UslCode y on y.ID=u.vid_vme	
--WHERE zs.EXP_COMENT IS NOT NULL  /*LIKE '%CODE_USL не из справочника%'*/ /* LIKE '%Дублирование рег услуг в одном реестре%'*/   --OR zs.EXP_COMENT LIKE '%ENP%' OR zs.EXP_COMENT LIKE '%vpolis%' OR zs.EXP_COMENT LIKE '%временный полис%' 
-- and u.CODE_USL = 'R01.001.009'
WHERE zs.EXP_COMENT LIKE '%в случае должна быть одна услуг%'
--ORDER BY zs.ZSL_ID
GROUP BY sch.ID, zs.ZSL_ID, s.ID
HAVING COUNT(*) > 1
--2



--удаление из USL
BEGIN TRAN --commit tran --rollback

--DELETE FROM  D3_USL_OMS  
WHERE ID IN (SELECT * 
             FROM tmp_jan_dubli_usl2 )

--44         