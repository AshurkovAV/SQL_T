--update p set d3_scid = z.d3_scid
select p.d3_scid, z.d3_scid--,count(*)
from d3_zsl_oms z
join D3_PACIENT_OMS p on z.d3_pid = p.id 
join  [D3_SCHET_OMS] sch on sch.id = z.d3_scid 
where z.d3_scid IN (1247) and p.d3_scid not IN (1247) or p.d3_scid IN (1265)
--group by p.d3_scid, z.d3_scid


--select * from temp_pid_scid_11_2020 where zs_shid=1247
--select * from ztemp_desh_Cdelete_112020