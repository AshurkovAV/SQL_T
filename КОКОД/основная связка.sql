--DECLARE @p1 INT=169			
		
--UPDATE s	
--SET p_cel25='1.0'		
SELECT DISTINCT 			
 sch.id, zs.ID, zs.SUMV, '' com	,s.ds_onk		
--  ,p.fam, p.im, p.dr, zs.DATE_Z_1, zs.DATE_Z_2,usl.CODE_USL, ds1--, crit.CRIT 			
-- ,REGNUM,n020.MNN, lp.code_sh,v024.DKKNAME, s.id, lpu,lp.code_sh,n021.CODE_SH,v24.DKKNAME, case when lp.code_sh=n021.CODE_SH THEN 1 ELSE 0 END pr, s.ds1			
 			
FROM [D3_SCHET_OMS] sch                  			
  join D3_PACIENT_OMS p on p.d3_scid=sch.id --and sch.id=@p1 			
          and sch.year=2020		
          and sch.month=1	
          --AND sch.id=169		
  join D3_ZSL_OMS zs on zs.D3_PID=p.id			
  join D3_SL_OMS s on s.D3_ZSLID=zs.ID  
  LEFT JOIN D3_USL_OMS AS usl ON usl.D3_SLID=s.id			
  --join D3_ONK_SL_OMS onk on onk.D3_SLID=s.id  			
  --join D3_ONK_USL_OMS ou on ou.D3_ONKSLID=onk.id
WHERE s.P_CEL25 LIKE '1.3' OR s.P_CEL LIKE '1.3'--dn IS NOT null
--s.ds_onk=1 --or s.ds_onk=0
ORDER BY usl.CODE_USL