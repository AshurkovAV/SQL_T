--UPDATE zs 
--SET zs.idsp=32




SELECT DISTINCT 	--zs.id,idsp, s.podr, s.IDDOKT		
 sch.id, zs.ID, zs.SUMV,onk.id	,onk.DS1_T, ou.USL_TIP, ou.HIR_TIP, ou.LEK_TIP_L,
 ou.LEK_TIP_V, ou.LUCH_TIP,koef.IDSL, koef.Z_SL
 -- ,p.fam, p.im, p.dr, zs.DATE_Z_1, zs.DATE_Z_2,usl.CODE_USL, ds1--, crit.CRIT 			
---- ,REGNUM,n020.MNN, lp.code_sh,v024.DKKNAME, s.id, lpu,lp.code_sh,n021.CODE_SH,v24.DKKNAME, case when lp.code_sh=n021.CODE_SH THEN 1 ELSE 0 END pr, s.ds1			
 			
FROM [D3_SCHET_OMS] sch                  			
  join D3_PACIENT_OMS p on p.d3_scid=sch.id --and sch.id=@p1 			
          and sch.year=2020		
          and sch.month=2	
      --    AND sch.id=169		
  join D3_ZSL_OMS zs on zs.D3_PID=p.id	
  JOIN D3_SL_OMS AS s ON s.D3_ZSLID=zs.id
  JOIN D3_ONK_SL_OMS AS onk ON onk.D3_SLID=s.ID
  join D3_ONK_USL_OMS ou ON ou.D3_ONKSLID=onk.ID
   join D3_KSG_KPG_OMS KsgKpg on KsgKpg.D3_SLID=s.id
				LEFT  JOIN D3_SL_Koef_OMS AS koef ON koef.D3_KSGID = KsgKpg.ID
WHERE zs.id IN (
SELECT DISTINCT 	--zs.id,idsp, s.podr, s.IDDOKT		
 --sch.id,
 
  zs.ID--, zs.SUMV,onk.id	, COUNT(*)
 -- ,p.fam, p.im, p.dr, zs.DATE_Z_1, zs.DATE_Z_2,usl.CODE_USL, ds1--, crit.CRIT 			
---- ,REGNUM,n020.MNN, lp.code_sh,v024.DKKNAME, s.id, lpu,lp.code_sh,n021.CODE_SH,v24.DKKNAME, case when lp.code_sh=n021.CODE_SH THEN 1 ELSE 0 END pr, s.ds1			
 			
FROM [D3_SCHET_OMS] sch                  			
  join D3_PACIENT_OMS p on p.d3_scid=sch.id --and sch.id=@p1 			
          and sch.year=2020		
          and sch.month=2	
      --    AND sch.id=169		
  join D3_ZSL_OMS zs on zs.D3_PID=p.id	
  JOIN D3_SL_OMS AS s ON s.D3_ZSLID=zs.id
  JOIN D3_ONK_SL_OMS AS onk ON onk.D3_SLID=s.ID
  join D3_ONK_USL_OMS ou ON ou.D3_ONKSLID=onk.ID
GROUP BY sch.id, zs.ID, zs.SUMV,onk.id
HAVING COUNT(*)>1)
--WHERE s.podr IS null