SELECT distinct kp.fam+' '+kp.im+' '+kp.ot vrach
				,p.fam AS [Фамилия]
				,p.im AS [Имя]
				,isnull(p.ot,'') AS [Отчество] 
				,p.W as [Пол]
				,p.DR as [Дата рождения]
				,replace(replace(zs.EXP_COMENT, CHAR(10), ''), CHAR(13), '') AS [ОСП] 
			,s.DN
				,f003.nam_mok AS [Направившая МО]
				,p.VPOLIS
				,p.SPOLIS
				,p.NPOLIS
				,p.ENP
				
				,zs.DATE_Z_1
				,sumv
				,u.VID_VME
				,u.CODE_USL
				,p.DOCTYPE, p.DOCSER, p.DOCNUM, p.DOCDATE, p.DOCORG
				--,p.ID
				--,u.CODE_MD
				--,zs.OS_SLUCH
				,zs.ISHOD
				,zs.ID
				,zs.ZSL_ID
				,u.ID
				,zs.OS_SLUCH
				
  
--*/ 
FROM [D3_SCHET_OMS] sch                  
 inner join D3_PACIENT_OMS p on p.d3_scid=sch.id
 inner join D3_ZSL_OMS zs on zs.D3_PID=p.id AND sch.code_mo=460061 
 --AND sch.month=5
 AND sch.YEAR=2023
 and sch.id IN (9610,9567,9409)
  join D3_SL_OMS s on s.D3_ZSLID=zs.ID 
  JOIN D3_USL_OMS u ON u.D3_SLID=s.id
LEFT JOIN (select DISTINCT * from kokod_podr WHERE usl_ok=3 ) AS kp ON kp.IDDOCT=dbo.f_digit_only(iddokt) AND zs.usl_ok=kp.usl_ok

join V009 rz on rz.IDRMP=zs.RSLT
left join F011 doc on doc.Id=p.DOCTYPE
   LEFT JOIN f003 ON f003.mcod=zs.NPR_MO

left JOIN medicalServices AS ms ON ms.code_usl=u.CODE_USL AND u.DATE_IN >=ms.dataBegin AND u.DATE_OUT<=ISNULL(ms.dataEnd,'20991231') AND ms.code_usl  BETWEEN 'R01.001.008' AND 'R01.001.036'
left join Yamed_Spr_UslCode y on y.ID=u.vid_vme	
WHERE zs.EXP_CoMENT like'%DN%' OR zs.EXP_COMENT LIKE '%1.3%' 