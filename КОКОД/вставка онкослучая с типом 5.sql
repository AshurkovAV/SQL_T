INSERT INTO [D3_ONK_SL_OMS] (
      [D3_SLID]
      ,[D3_SLGID]
      ,[DS1_T]
 
)
SELECT  --ds1,iddokt,
     s.id
      ,s.SL_ID
    ,5
FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id--and sch.month=11
                 and sch.year=2024  -- and sch.id IN (3514,3517,3518)
 inner join D3_ZSL_OMS zs on zs.D3_PID=p.id
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID  
left join  D3_ONK_SL_OMS onk on onk.D3_SLID=s.id  
 --left join Yamed_Spr_Usl804 u on u.id=n.NAPR_USL
where  onk.id is  null  and sch.id IN  (18504) and ds_onk=0         -- and ds1 between 'D00' and 'D09.z'