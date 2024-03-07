--BEGIN TRAN  --commit tran
--UPDATE s SET iddokt='029-796-491 19'
--UPDATE u SET code_md='029-796-491 19'
--UPDATE u SET u.code_usl='R01.001.030' --u.VID_VME LIKE 'A08.09.011'--1
--UPDATE u SET u.code_usl='R01.001.020' --u.VID_VME LIKE 'A12.05.123'--3
--UPDATE u SET u.code_usl='R01.001.029' --u.VID_VME LIKE 'A12.20.001'--719
--UPDATE u SET u.code_usl='R01.001.009' --u.VID_VME LIKE 'A26.06.033'--13
--UPDATE u SET u.code_usl='R01.001.013' --u.VID_VME LIKE 'A26.19.011'--67
--UPDATE s SET s.ds1 ='Z01.7'
--UPDATE zs SET ISHOD = 304
--UPDATE p SET p.smo='46007'
--UPDATE zs SET sump=NULL
--UPDATE D3_SL_OMS SET IDDOKT = u.code_md
--UPDATE  D3_SL_OMS SET IDDOKT = '137-073-736 61'
--UPDATE  D3_USL_OMS SET code_md = '137-073-736 61'

SELECT /*distinct*/ p.SMO as [Страховая компания]
  , p.fam,p.im,isnull(p.ot,'') 
 ,p.W as [Пол]
  ,p.DR as [Дата рождения]
  , replace(replace(zs.EXP_COMENT, CHAR(10), ''), CHAR(13), '')
  ,COUNT(zs.id)
  
  --,s.IDDOKT AS [СНИЛС врача]
  --,u.code_md
  ,p.VPOLIS
  ,p.SPOLIS
  ,p.NPOLIS
  ,u.LPU
  ,zs.NPR_MO
  ,f003.nam_mok
  /*,s.ds1
  ,p.DOCTYPE
  ,p.DOCSER
  ,p.DOCNUM
  ,sch.NSCHET
  ,zs.ISHOD
  ,u.vid_vme
  ,y.Name
*/	
FROM [D3_SCHET_OMS] sch                  
 inner join D3_PACIENT_OMS p on p.d3_scid=sch.id
 inner join D3_ZSL_OMS zs on zs.D3_PID=p.id AND sch.code_mo=460061 
 --AND sch.month=5
 AND sch.YEAR=2022  
 and sch.id in (8998)
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
	--AND  u.code_md = '137--07-3-7 61'
GROUP BY p.SMO 
  , p.fam,p.im,isnull(p.ot,'') 
 ,p.W 
  ,p.DR 
  , replace(replace(zs.EXP_COMENT, CHAR(10), ''), CHAR(13), '')
  
  --,s.IDDOKT
  --,u.code_md
  ,p.VPOLIS
  ,p.SPOLIS
  ,p.NPOLIS
  ,u.LPU
  ,zs.NPR_MO
  ,f003.nam_mok
  /*,s.ds1
  ,p.DOCTYPE
  ,p.DOCSER
  ,p.DOCNUM
  ,sch.NSCHET
  ,zs.ISHOD
  ,u.vid_vme
  ,y.Name
  */
ORDER BY p.SMO 
  , p.fam,p.im,isnull(p.ot,'') 
 ,p.W 
  ,p.DR 
  
 -- ,s.IDDOKT
  --,u.code_md
  ,p.VPOLIS
  ,p.SPOLIS
  ,p.NPOLIS
  ,u.LPU
  ,zs.NPR_MO
  ,f003.nam_mok
  /*,s.ds1
  ,p.DOCTYPE
  ,p.DOCSER
  ,p.DOCNUM
  ,sch.NSCHET
  ,zs.ISHOD
  ,u.vid_vme
  ,y.Name
  */
--265  