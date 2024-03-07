
--191+197+199
DECLARE @p1 INT=319
--лекарственный препарат не соотвествует схеме

SELECT DISTINCT --zs.id,s.ID,REGNUM, zs.SUMV
 zs.ID, zs.SUMV, '' com
  --,p.fam, p.im, p.dr, zs.DATE_Z_1, zs.DATE_Z_2--, crit.CRIT 
 --,REGNUM,n020.MNN, lp.code_sh,v024.DKKNAME, s.id, lpu,lp.code_sh,n021.CODE_SH,v24.DKKNAME, case when lp.code_sh=n021.CODE_SH THEN 1 ELSE 0 END pr, s.ds1
 
FROM [D3_SCHET_OMS] sch                  
  join D3_PACIENT_OMS p on p.d3_scid=sch.id and sch.id=@p1 
          --and sch.year=2019
          --and sch.month=4
  join D3_ZSL_OMS zs on zs.D3_PID=p.id
  join D3_SL_OMS s on s.D3_ZSLID=zs.ID  
  join D3_ONK_SL_OMS onk on onk.D3_SLID=s.id  
  join D3_ONK_USL_OMS ou on ou.D3_ONKSLID=onk.id  
  join D3_LEK_PR_OMS lp on lp.D3_ONKUSLID=ou.id  
  JOIN [N021] n021 ON n021.ID_LEKP=REGNUM AND zs.DATE_Z_2 BETWEEN n021.DATEBEG AND ISNULL(n021.DATEEND,'22000101')
  LEFT JOIN v024 ON v024.IDDKK=lp.CODE_SH AND YEAR(v024.DATEBEG)=YEAR(date_z_2)
  LEFT JOIN v024 v24 ON v24.IDDKK=n021.CODE_SH AND YEAR(v24.DATEBEG)=YEAR(date_z_2)
  LEFT JOIN n020 ON n020.ID_LEKP=lp.REGNUM AND zs.DATE_Z_2 BETWEEN n020.DATEBEG AND ISNULL(n020.DATEEND,'22000101')
  LEFT JOIN D3_KSG_KPG_OMS AS ksg ON ksg.D3_SLID=s.ID
  LEFT JOIN D3_CRIT_OMS AS crit ON crit.D3_KSGID=ksg.ID
WHERE zs.id IN(


Select
  zs.ID--, zs.SUMV, '' com 
 -- ,REGNUM, lp.code_sh, s.id, lpu,lp.code_sh,n021.CODE_SH, case when lp.code_sh=n021.CODE_SH THEN 1 ELSE 0 END pr
FROM [D3_SCHET_OMS] sch                  
  join D3_PACIENT_OMS p on p.d3_scid=sch.id and sch.id=@p1 
  join D3_ZSL_OMS zs on zs.D3_PID=p.id
  join D3_SL_OMS s on s.D3_ZSLID=zs.ID  
  join D3_ONK_SL_OMS onk on onk.D3_SLID=s.id  
  join D3_ONK_USL_OMS ou on ou.D3_ONKSLID=onk.id  
  join D3_LEK_PR_OMS lp on lp.D3_ONKUSLID=ou.id  
  JOIN [N021] n021 ON n021.ID_LEKP=REGNUM AND zs.DATE_Z_2 BETWEEN n021.DATEBEG AND ISNULL(n021.DATEEND,'22000101')

WHERE 	not
		(
			s.DS1 between 'C81' and 'C96.z'
			or dbo.f_GetAge(p.DR,s.DATE_1)<18
		)
		AND lp.CODE_SH NOT IN ('sh903','sh904')
GROUP BY zs.id,s.ID,REGNUM, zs.SUMV
HAVING sum(case when lp.code_sh=n021.CODE_SH THEN 1 ELSE 0 END)=0)
--where 
--lp.CODE_SH
--  REGNUM is null 
--  or REGNUM not in (select ID_LEKP from [NSI].[dbo].[N021]) 
--  or code_sh is null
--  or code_sh not in (select ID_LEKP from [NSI].[dbo].[N021])
  
--group by 
--  zs.id, zs.SUMV