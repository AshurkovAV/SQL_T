---insert вид направления на 1, где стоит подозрение 
declare @p1 int =2612

INSERT INTO [D3_NAPR_OMS] (
  [D3_SLID]
      ,[D3_SLGID]
      ,[NAPR_DATE]
      ,[NAPR_MO]
      ,[NAPR_V]
      ,[MET_ISSL]
      ,[NAPR_USL]
)
SELECT  
     s.id
      ,s.SL_ID
      ,s.DATE_2
      ,'460061'
      ,1
      ,NULL
      ,NULL
FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id--and sch.month=11
                 and sch.year=2023   and sch.month in (1) and sch.id IN   (9374,9382,9395)
 inner join D3_ZSL_OMS zs on zs.D3_PID=p.id
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID  
left join   D3_NAPR_OMS n on n.D3_SLID=s.id  
 --left join Yamed_Spr_Usl804 u on u.id=n.NAPR_USL
where  n.id is  null  AND ds_onk=1