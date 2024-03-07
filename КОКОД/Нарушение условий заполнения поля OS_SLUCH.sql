declare @p1 int=319
SELECT distinct zs.id as ID, zs.sumv as SUMV, '' com,p.NOVOR,p.fam,p.im,p.ot,zs.OS_SLUCH --Нарушение условий заполнения поля OS_SLUCH
 FROM [D3_PACIENT_OMS] p      
  inner join [D3_ZSL_OMS] zs on p.id=zs.[D3_PID]
  join D3_SCHET_OMS sch on sch.id=p.D3_SCID 
  and zs.D3_SCID=@p1
  where zs.OS_SLUCH is not null 
  and 
  ((p.NOVOR=0 and p.OT is not null)
  or 
  (p.OT_P is null and p.NOVOR<>0 )
  or 
  (p.NOVOR<>0 and left(p.NOVOR,1)<>1 ))
-- and sch.year=2020 and sch.month=3 and (p.smo=46007 or p.smo=46002)
-- group by zs.id,zs.SUMV