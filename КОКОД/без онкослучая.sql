
 select DISTINCT sch.id,zsl.usl_ok,ds1,sl.PODR, 
  sl.iddokt,zsl.id zslid, sl.id slid,sl.SL_ID, onksl.*,kp.fam+' '+kp.im+' '+kp.ot vrach,p.fam, p.im,p.ot,p.dr,p.NPOLIS,date_z_2
 -- ,sl.METOD_HMP,v019.HMNAME --тья

FROM [D3_SCHET_OMS] sch
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
    inner join D3_ZSL_OMS zsl on zsl.D3_PID=p.id and zsl.D3_SCID=sch.id
      inner join D3_SL_OMS sl on sl.D3_ZSLID=zsl.ID
      LEFT JOIN  D3_ONK_SL_OMS OnkSl on OnkSl.D3_SLID=sl.id 
      LEFT JOIN (select DISTINCT * from kokod_podr  ) AS kp ON kp.IDDOCT=dbo.f_digit_only(iddokt) AND zsl.usl_ok=kp.usl_ok
	where 			
		sch.[YEAR]=2023		
		and sch.month =10
		AND sch.schettype LIKE 'C'
		AND onksl.ds1_t IS NULL
		AND sl.DS_ONK=0
		AND zsl.USL_OK<>3
 ORDER BY sl.IDDOKT