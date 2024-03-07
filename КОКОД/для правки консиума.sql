SELECT distinct sch.id AS shit,p.fam, p.im, s.NHISTORY,zs.DATE_Z_1, zs.DATE_Z_2, s.DATE_1,s.DATE_2, dco.*

FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
  and sch.year=2022 and sch.month=6--sch.id in (2840,2843,2844)
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id    and zs.usl_ok in (1) --AND zs.id=20906231
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID   
 --JOIN temp_disp_5 t ON t.slid=s.id
 left join D3_ONK_SL_OMS onk on onk.D3_SLID=s.id
 LEFT JOIN D3_CONS_OMS AS dco ON dco.D3_SLID = s.ID
WHERE zs.id=7363334
 