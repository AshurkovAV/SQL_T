declare @p1 int = 9070

delete s
from D3_SL_OMS s where s.id in (
select min(s.ID)
 from D3_ZSL_OMS zs         
  inner join D3_SL_OMS s on s.D3_ZSLID=zs.ID
  where zs.ID in (
 select zs.id--,zs.sumv,s.DATE_1,s.DATE_2,s.ds1,s.profil,s.prvs,count(distinct s.id) k 
 from D3_ZSL_OMS zs         
  inner join D3_SL_OMS s on s.D3_ZSLID=zs.ID  
  where D3_SCID = @p1 
      group by zs.id,zs.sumv,s.DATE_1,s.DATE_2,s.ds1,s.profil,s.prvs
	  having count(distinct s.id)>1
	  )
      group by zs.ID
)
--

update zs set DATE_Z_1 = d.date_1
  from
  (SELECT --TOP 10
    ZS.ID as zs_id,  
    zs.date_z_1,  
    zs.date_z_2,
    min(sl.date_1) as date_1

  FROM D3_ZSL_OMS zs        
      inner join D3_SL_OMS sL on sL.D3_ZSLID=zs.ID   
							and zs.D3_SCID = @p1  
							and (zs.OS_SLUCH_REGION not in (7,11,17)
								or zs.OS_SLUCH_REGION is null)
  group by
    ZS.ID,  
    zs.date_z_1,  
    zs.date_z_2
  having 
    zs.date_z_1<>min(sl.date_1)
    )d  inner join D3_ZSL_OMS zs on d.zs_id=zs.ID
								and zs.D3_SCID = @p1
								and (zs.OS_SLUCH_REGION not in (7,11,17)
									or zs.OS_SLUCH_REGION is null)