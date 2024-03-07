select t1.*,t2.*
from
(--
select p.fam,p.im,p.ot,s.nhistory,usl.CODE_USL, usl.VID_VMe, p.npolis,usl.DATE_IN,s.IDDOKT
--sch.id, zs.id, usl.CODE_USL, usl.VID_VME,ms.ishod,zs.ISHOD

FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
  and sch.year=2021 and sch.month=9-- AND sch.id IN (625,624)
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id   --and zs.usl_ok in (1,2) --AND zs.id=20906231
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID 
 JOIN d3_usl_oms usl ON usl.D3_SLID=s.id
WHERE --usl.VID_VME LIKE 'A06.09.005.002' or
      usl.VID_VME LIKE 
    -- 'A05.30.005.001'
     'A06.30.005.003'

) t1
left join 
(--
select p.fam,p.im,p.ot,s.nhistory,usl.CODE_USL, usl.VID_VMe, p.npolis,usl.DATE_IN,s.IDDOKT
--sch.id, zs.id, usl.CODE_USL, usl.VID_VME,ms.ishod,zs.ISHOD

FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
  and sch.year=2021 and sch.month=9-- AND sch.id IN (625,624)
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id   --and zs.usl_ok in (1,2) --AND zs.id=20906231
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID 
 JOIN d3_usl_oms usl ON usl.D3_SLID=s.id
WHERE --usl.VID_VME LIKE 'A06.09.005.002' or
      usl.VID_VME LIKE 
    --  'A05.30.005'
      'A06.30.005'

) t2 on t1.npolis=t2.npolis and t1.date_in=t2.date_in
where t2.nhistory is null




select t1.*,t2.*
from
(--
select p.fam,p.im,p.ot,s.nhistory,usl.CODE_USL, usl.VID_VMe, p.npolis,usl.DATE_IN,s.IDDOKT
--sch.id, zs.id, usl.CODE_USL, usl.VID_VME,ms.ishod,zs.ISHOD

FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
  and sch.year=2021 and sch.month=9-- AND sch.id IN (625,624)
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id   --and zs.usl_ok in (1,2) --AND zs.id=20906231
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID 
 JOIN d3_usl_oms usl ON usl.D3_SLID=s.id
WHERE --usl.VID_VME LIKE 'A06.09.005.002' or
      usl.VID_VME LIKE 
     'A05.30.005.001'
    -- 'A06.30.005.003'

) t1
left join 
(--
select p.fam,p.im,p.ot,s.nhistory,usl.CODE_USL, usl.VID_VMe, p.npolis,usl.DATE_IN,s.IDDOKT
--sch.id, zs.id, usl.CODE_USL, usl.VID_VME,ms.ishod,zs.ISHOD

FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
  and sch.year=2021 and sch.month=9-- AND sch.id IN (625,624)
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id   --and zs.usl_ok in (1,2) --AND zs.id=20906231
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID 
 JOIN d3_usl_oms usl ON usl.D3_SLID=s.id
WHERE --usl.VID_VME LIKE 'A06.09.005.002' or
      usl.VID_VME LIKE 
      'A05.30.005'
     -- 'A06.30.005'

) t2 on t1.npolis=t2.npolis and t1.date_in=t2.date_in
where t2.nhistory is null

