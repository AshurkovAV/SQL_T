DECLARE @p1 INT = 16223
--выбираю тех, у кого больше 1 приема дисп с одним диагнозом и профилем, во всех кроме 1 меняем цель на 1.0

SELECT 
distinct sch.id, zs.id zslid, kp.fam+' '+kp.im+' '+kp.ot vrach,p.fam,p.im,isnull(p.ot,''),p.dr, s.nhistory, s.PROFIL,date_1, s.ds1
    ,kp.fam+' '+kp.im+' '+kp.ot vrach,zs.MEK_COMENT
   
FROM [D3_SCHET_OMS] sch   
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
 -- and sch.year=2022 and sch.month=12 and sch.CODE_MO = 460010
 AND sch.id = @p1
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id  and zs.[D3_SCID]=sch.id --and zs.usl_ok in (1,2) 
  --AND zs.id in (1889455, 1887726)
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID AND s.P_CEL25 = '1.3' 
 LEFT JOIN (select DISTINCT * from kokod_podr WHERE usl_ok=3 ) AS kp ON kp.IDDOCT=dbo.f_digit_only(iddokt) AND zs.usl_ok=kp.usl_ok
where s.p_cel25='1.3' and zs.MEK_COMENT is not null