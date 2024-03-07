UPDATE  OnkSl SET ds1_t=5
--                 onk_t=199,onk_n=114,onk_m=69
--3039804, 3045077 ,3046624
 --select DISTINCT zsl.id zslid, sl.id slid,sl.SL_ID, onksl.*
 -- ,sl.METOD_HMP,v019.HMNAME --тья

FROM [D3_SCHET_OMS] sch
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
    inner join D3_ZSL_OMS zsl on zsl.D3_PID=p.id and zsl.D3_SCID=sch.id
      inner join D3_SL_OMS sl on sl.D3_ZSLID=zsl.ID
      LEFT JOIN  D3_ONK_SL_OMS OnkSl on OnkSl.D3_SLID=sl.id 
WHERE zsl.ID in (3745779)