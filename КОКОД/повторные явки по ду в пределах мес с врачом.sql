DECLARE @p1 INT = 16315
--выбираю тех, у кого больше 1 приема дисп с одним диагнозом и профилем, во всех кроме 1 меняем цель на 1.0
SELECT * FROM
(
SELECT 
distinct  ROW_NUMBER() OVER(PARTITION BY p.fam,p.im,isnull(p.ot,''),p.dr, s.PROFIL, s.ds1 order BY p.fam,p.im,isnull(p.ot,''),p.dr, s.PROFIL, s.ds1) 
    n_p_p,kp.fam+' '+kp.im+' '+kp.ot vrach,
    sch.id, zs.id zslid,p.id as pid, s.id slid, s.nhistory, p.npolis,  p.fam,p.im,isnull(p.ot,'') ot,p.dr,date_1, s.ds1
--INTO temp_disp_1_3
FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
 -- and sch.year=2022 and sch.month=12 and sch.CODE_MO = 460010
 AND sch.id = @p1
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id  and zs.[D3_SCID]=sch.id --and zs.usl_ok in (1,2) 
  --AND zs.id in (1889455, 1887726)
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID AND s.P_CEL25 = '1.3' 
 LEFT JOIN (select DISTINCT * from kokod_podr WHERE usl_ok=3 ) AS kp ON kp.IDDOCT=dbo.f_digit_only(iddokt) AND zs.usl_ok=kp.usl_ok
JOIN(--группируем по профилю, диагнозу, у кого было более 1 приема с целью дисп наблюдение в мес
select  s.profil, s.P_CEL25, isnull(p.npolis, p.ENP) npolis, ds1
FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
 --  and sch.year=2022 and sch.month=12 AND sch.CODE_MO = 460010
 AND sch.id = @p1
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id  and zs.[D3_SCID]=sch.id    --and zs.usl_ok in (1,2) 
  --AND zs.id in (1889455, 1887726)
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID AND s.P_CEL25= '1.3' 

GROUP BY  s.profil, s.P_CEL25, isnull(p.npolis, p.ENP), ds1
HAVING COUNT(*) > 1
) t ON t.npolis=isnull(p.NPOLIS, p.enp) AND s.ds1=t.ds1

)tt
ORDER BY  tt.fam,tt.im,tt.ot,tt.dr,tt. n_p_p