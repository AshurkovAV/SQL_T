SELECT DISTINCT  s.nhistory, p.npolis, date_1,date_2,p_cel25, v021.NameWithID, s.tarif, zs.sumv, p.smo, zs.idsp,
replace(replace(zs.EXP_COMENT, CHAR(10), ''), CHAR(13), '') [комментарий мэк]
FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
  and sch.year=2022 and sch.month=9-- AND   sch.id   IN (8368)
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id  and zs.[D3_SCID]=sch.id --and zs.usl_ok in (1,2) --AND zs.id=20906231

 join D3_SL_OMS s on s.D3_ZSLID=zs.ID 
   left join v021 on v021.IDSPEC=s.prvs21
   where zs.EXP_COMENT is not null