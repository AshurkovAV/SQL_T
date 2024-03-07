select p.d3_scid, z.d3_scid
from d3_zsl_oms z
join D3_PACIENT_OMS p on z.d3_pid = p.id 
join  [D3_SCHET_OMS] sch on sch.id = z.d3_scid 
where sch.id IN (1265)

select p.d3_scid, z.d3_scid
from d3_zsl_oms z
join D3_PACIENT_OMS p on z.d3_pid = p.id 
join  [D3_SCHET_OMS] sch on sch.id = z.d3_scid 
where sch.id IN (1247)


--group by sch.id
 


select top 10 *
from d3_zsl_oms

select *
FROM [D3_SCHET_OMS] sch                  
 inner join D3_PACIENT_OMS p on p.d3_scid=sch.id
 inner join D3_ZSL_OMS zs on zs.D3_PID=p.id 
 where sch.id IN (1265)--(1247,1258,1248,1265)
--AND sch.ID IN (686, 688, 682)

--update p set p.d3_scid=zs_shid
select pa.*,p.d3_scid,zs.d3_scid
 --distinct zs.d3_scid as zs_shid, p.d3_scid as p_schid,zs.zsl_id,p.id as pid,p.d3_scid--,count(zs.id)
--into temp_pid_scid_11_2020
 from 
D3_PACIENT_OMS p
 inner join D3_ZSL_OMS zs on zs.D3_PID=p.id
 inner join  temp_pid_scid_11_2020 pa on pa.pid=p.id
 where zs.d3_scid<>
 pa.p_schid
 --group bd, p.d3_scid