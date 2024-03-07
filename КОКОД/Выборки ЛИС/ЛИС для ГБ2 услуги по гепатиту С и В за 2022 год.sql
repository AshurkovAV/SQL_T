--ЛИС для ГБ2: услуги по гепатиту С и В за 2022 год
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

 distinct p.SMO as [Страховая компания]
				,p.fam AS [Фамилия]
				,p.im AS [Имя]
				,isnull(p.ot,'') AS [Отчество] 
				,p.W as [Пол]
				,p.DR as [Дата рождения]
				--,replace(replace(zs.EXP_COMENT, CHAR(10), ''), CHAR(13), '') AS [ОСП] 
				,COUNT(zs.id) AS [кол-во]
				,f003.nam_mok AS [Направившая МО]
				,p.VPOLIS
				,p.SPOLIS
				,p.NPOLIS
				,p.ENP
				
				,zs.DATE_Z_1
				,u.VID_VME
				,u.CODE_USL
				,p.DOCTYPE, p.DOCSER, p.DOCNUM, p.DOCDATE, p.DOCORG

FROM [D3_SCHET_OMS] sch                  
 /*inner*/left join D3_PACIENT_OMS p on p.d3_scid=sch.id
 inner join D3_ZSL_OMS zs on zs.D3_PID=p.id --AND sch.code_mo= 460023     --460061 
											AND sch.YEAR = 2022
											and sch.id IN (4375, 5379
											, 5596, 5602, 5595, 6855, 6856, 7074, 7075, 7076, 8222, 8235, 8236, 8446, 8453, 
											8470, 8501, 8587, 8667, 8685, 8727, 8866, 8913, 8916, 9025, 9068, 9160
											,5449, 6905, 8144, 8230, 8691, 8585, 8684, 8909)  --реестры ЛИС за 2022 год 
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID 
 JOIN D3_USL_OMS u ON u.D3_SLID=s.id
 join V009 rz on rz.IDRMP=zs.RSLT
 left join F011 doc on doc.Id=p.DOCTYPE
 LEFT JOIN f003 ON f003.mcod=zs.NPR_MO
 left JOIN medicalServices AS ms ON ms.code_usl=u.CODE_USL AND u.DATE_IN >=ms.dataBegin AND u.DATE_OUT<=ISNULL(ms.dataEnd,'20991231') AND ms.code_usl  BETWEEN 'R01.001.008' AND 'R01.001.036'
 left join Yamed_Spr_UslCode y on y.ID=u.vid_vme	
WHERE --u.VID_VME IN ('A26.06.041', 'A26.06.041.002', 'A26.06.041.001.01', 'A26.05.019.001', 'A26.06.036', 'A26.06.040')    --гепатит C 
  u.VID_VME IN ('A26.05.020.001', 'A26.06.036')    --гепатит B
/*(u.VID_VME LIKE '%26.06.041'
OR u.VID_VME LIKE '%26.06.041.002'
or u.VID_VME LIKE '%26.06.041.002')*/
  AND f003.nam_mok like '%2%'
--WHERE --zs.EXP_COMENT IS NOT NULL -- LIKE '%"Отчество" или Отчество представителя%' --OR zs.EXP_COMENT LIKE '%ENP%' OR zs.EXP_COMENT LIKE '%vpolis%' OR zs.EXP_COMENT LIKE '%временный полис%' 
--WHERE zs.ISHOD <> 304
--WHERE u.ID IN(11063283, 11609227)
--OR zs.ID = 15074407
--where p.FAM ='золотар%'
--AND p.npolis = '4652710883000041'
--AND p.enp IS null		--<> p.npolis 
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
  ,zs.DATE_Z_1
  ,u.VID_VME
  ,u.CODE_USL
 ,p.DOCTYPE, p.DOCSER, p.DOCNUM, p.DOCDATE, p.DOCORG
 
ORDER BY p.SMO 
  , p.fam,p.im,isnull(p.ot,'') 
 ,p.W 
  ,p.DR 
  ,f003.nam_mok
  ,p.VPOLIS
  ,p.SPOLIS
  ,p.NPOLIS
 ,p.DOCTYPE, p.DOCSER, p.DOCNUM, p.DOCDATE, p.DOCORG 
 --*/