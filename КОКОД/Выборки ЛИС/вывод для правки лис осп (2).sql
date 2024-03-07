--BEGIN TRAN  --commit tran  --rollback tran
--UPDATE s SET iddokt='029-796-491 19'
--UPDATE u SET code_md='029-796-491 19'
--UPDATE u SET u.code_usl='R01.001.030' --u.VID_VME LIKE 'A08.09.011'--1
--UPDATE u SET u.code_usl='R01.001.020' --u.VID_VME LIKE 'A12.05.123'--3
--UPDATE u SET u.code_usl='R01.001.029' --u.VID_VME LIKE 'A12.20.001'--719
--UPDATE u SET u.code_usl='R01.001.009' --u.VID_VME LIKE 'A26.06.033'--13
--UPDATE u SET u.code_usl='R01.001.013' --u.VID_VME LIKE 'A26.19.011'--67
--UPDATE u SET u.VID_VME = 'A26.01.017'
--UPDATE s SET s.ds1 ='Z01.7'
--UPDATE zs SET ISHOD = 304			--29057
--UPDATE p SET p.smo='46007'
--UPDATE zs SET sump=NU LL
--UPDATE zs SET OS_SLUCH = 2
--UPDATE p SET p.w = 2
--UPDATE p SET p.enp = p.npolis
--UPDATE p SET p.npolis = null
--UPDATE p SET p.smo = '46007'
--UPDATE zs set zs.NPR_MO = 460066

--/*
SELECT --sch.*,
		/*zs.ID, zs.ZSL_ID, zs.D3_PID, zs.D3_PGID, zs.D3_SCID, zs.IDCASE,
		zs.DATE_Z_1, zs.DATE_Z_2, zs.SysDtChange
		,s.ID, s.D3_ZSLID, s.D3_ZSLGID, s.SL_ID, s.NHISTORY, s.DS1
		,u.ID, u.D3_SLID, u.D3_ZSLID, u.D3_SLGID, u.P_OTK, u.PRVS15, u.PRVS21,
		u.D3_USLGID
		,p.fam AS [Фамилия]
				,p.im AS [Имя]
				,isnull(p.ot,'') AS [Отчество] 
				,p.W as [Пол]
				,p.DR as [Дата рождения]*/

 DISTINCT --zs.ID AS zsl_id, p.ID AS pid,
		--	p.NPOLIS, p.ENP  --, p.SMO as [Страховая компания],
				p.fam AS [Фамилия]
				,p.im AS [Имя]
				,isnull(p.ot,'') AS [Отчество] 
				,p.W as [Пол]
				,p.DR as [Дата рождения]
				,replace(replace(zs.EXP_COMENT, CHAR(10), ''), CHAR(13), '') AS [ОСП] 
				,COUNT(zs.id) AS [кол-во]
				,f003.nam_mok AS [Направившая МО]
				,p.SMO as [Страховая компания]
				,p.VPOLIS
				,p.SPOLIS
				,p.NPOLIS
				,p.ENP
				,zs.SUMV
				,zs.DATE_Z_1
				,u.VID_VME
			    ,u.CODE_USL
				,p.DOCTYPE, p.DOCSER, p.DOCNUM, p.DOCDATE, p.DOCORG
				--,p.ID
				--,u.CODE_MD
				,zs.OS_SLUCH
			--	,zs.ISHOD
				,zs.ID
				,zs.ZSL_ID
				,u.ID
			--	,zs.OS_SLUCH
			,zs.NPR_MO
				
  --,zs.SUMV
--*/ 
FROM [D3_SCHET_OMS] sch                  
 inner join D3_PACIENT_OMS p on p.d3_scid=sch.id
 inner join D3_ZSL_OMS zs on zs.D3_PID=p.id AND sch.code_mo=460061 
 --AND sch.month=5
 AND sch.YEAR=2023
 and sch.id IN (/*15024*/ /*17339*/ 17399 /*17344*/ /*17339*/) 
  join D3_SL_OMS s on s.D3_ZSLID=zs.ID 
  JOIN D3_USL_OMS u ON u.D3_SLID=s.id


join V009 rz on rz.IDRMP=zs.RSLT
left join F011 doc on doc.Id=p.DOCTYPE
   LEFT JOIN f003 ON f003.mcod=zs.NPR_MO
--WHERE iddokt is  NULL --AND sch.SchetType LIKE 'H'
--WHERE (ds1 NOT BETWEEN 'C00' AND 'D09.z') and ds1 NOT BETWEEN 'D45' AND 'D47.z'
left JOIN medicalServices AS ms ON ms.code_usl=u.CODE_USL AND u.DATE_IN >=ms.dataBegin AND u.DATE_OUT<=ISNULL(ms.dataEnd,'20991231') AND ms.code_usl  BETWEEN 'R01.001.008' AND 'R01.001.036'
left join Yamed_Spr_UslCode y on y.ID=u.vid_vme	
WHERE zs.EXP_COMENT /*IS NOT NULL*/ LIKE '%в случае должна быть одна услуга;  Количество единиц оплаты в случае не совпадает с количеством блоков услуг по случаю;  некорректный тариф к рег услуге;%' --OR zs.EXP_COMENT LIKE '%ENP%' OR zs.EXP_COMENT LIKE '%vpolis%' OR zs.EXP_COMENT LIKE '%временный полис%' 
 --zs.EXP_COMENT LIKE '% CODE_USL не из справочника;  Не заполнено обязательное поле сумма выставленная SUMV в ЗАКОНЧЕННОМ СЛУЧАЕ%'
--AND  f003.nam_mok IN ('ОБУЗ "КУРСКАЯ ГОРБОЛЬНИЦА №2"' /*, 'ОБУЗ "КГБ №1 ИМ. Н.С. КОРОТКОВА"'*/)
--and u.VID_VME = 'A26.08.019.003'
--AND p.NPOLIS = '4697499783000171'
--AND zs.OS_SLUCH <> 2
--AND p.SMO = ''
--AND p.W =  
--WHERE zs.ISHOD <> 304
--WHERE u.ID IN(11063283, 11609227)
--OR zs.ID = 15074407
 --p.FAM LIKE '%БАЗЬКО%'
--AND p.npolis = '4648140878000052'
--AND 
--p.enp IS null		--<> p.npolis 
--AND p.VPOLIS = 3
--/*
GROUP BY p.SMO
  , p.fam,p.im,isnull(p.ot,'') 
 ,p.W 
  ,p.DR 
  , replace(replace(zs.EXP_COMENT, CHAR(10), ''), CHAR(13), '')
  ,f003.nam_mok 
  ,p.VPOLIS
  ,p.SPOLIS
  ,p.NPOLIS
  ,p.ENP
  ,zs.SUMV
  
  ,zs.DATE_Z_1
  ,u.VID_VME
  ,u.CODE_USL
 ,p.DOCTYPE, p.DOCSER, p.DOCNUM, p.DOCDATE, p.DOCORG
 ,p.ID
 ,u.CODE_MD
 ,zs.OS_SLUCH
-- ,zs.ISHOD
 ,zs.ID
,zs.ZSL_ID
,u.ID
--,zs.OS_SLUCH
--,zs.SUMV
,zs.NPR_MO
ORDER BY --p.SMO ,
   p.fam,p.im,isnull(p.ot,'') 
 ,p.W 
  ,p.DR 
  ,f003.nam_mok
  ,p.VPOLIS
  ,p.SPOLIS
  ,p.NPOLIS
 -- ,u.VID_VME
 -- ,u.CODE_USL 
 ,p.DOCTYPE, p.DOCSER, p.DOCNUM, p.DOCDATE, p.DOCORG 
 --*/
 
 
 
/*DELETE FROM  D3_USL_OMS  
WHERE ID = 24441669
*/