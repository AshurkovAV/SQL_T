
--INSERT INTO [D3_ONK_SL_OMS] (

--      [D3_SLID]
--      ,[D3_SLGID]
--      ,[DS1_T]
     
 
--)
--SELECT  
--     s.id
--      ,s.SL_ID
--      ,5
  SELECT 	sch.id,kp.fam+' '+kp.im+' '+kp.ot vrach,zs.id, p.fam, p.im, p.ot,ds1, idsp, s.IDDOKT, date_2, usl.CODE_USL, usl.VID_VME, u.Name, onk.*
FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id--and sch.month=11
                 and sch.year=2023   and sch.month in (2) --and sch.id IN (8231) 
 inner join D3_ZSL_OMS zs on zs.D3_PID=p.id AND zs.USL_OK=3
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID  
 LEFT JOIN D3_ONK_SL_OMS AS onk ON onk.D3_SLID=s.id
 LEFT JOIN D3_USL_OMS AS usl ON usl.D3_SLID=s.id
 left join Yamed_Spr_Usl804 u on u.id=usl.VID_VME
 LEFT JOIN kokod_podr AS kp ON kp.IDDOCT=dbo.f_digit_only(iddokt) AND zs.usl_ok=kp.usl_ok
--where  n.id is  null  AND ds_onk=1
WHERE ds1 BETWEEN 'D00' AND 'D09' AND idsp=28-- AND ds1_t=5
--AND onk.id IS NULL
   --ORDER BY s.IDDOKT, date_2