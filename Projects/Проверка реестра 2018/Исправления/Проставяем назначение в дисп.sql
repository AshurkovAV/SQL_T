--назначения в дисп
insert into D3_NAZ_OMS (D3_SLID, D3_SLGID, naz_r, naz_sp)

Select s.id, s.sl_id, 1, 76
-- ,dbo.f_GetAge(p.DR, DATE_Z_1)
--, naz.D3_SLID, naz.D3_SLGID
--,zs.ID


FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id --and sch.month=11
  and sch.id=2347
 inner join D3_ZSL_OMS zs on zs.D3_PID=p.id
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID  
 left join   D3_DSS_OMS sd on sd.D3_SLID=s.id and sd.DS_TYPE=2  
 left join   D3_NAZ_OMS naz ON naz.D3_SLID=s.id  
where   sch.SchetType like '%H%' --проверяем пока только случаи диспансеризации с онкодиагнозом или подозрением на онко
       AND s.p_cel25 LIKE '2.2' 
    --   AND (S.DS1 LIKE 'C%' 
        --OR S.DS1 between 'D00' AND 'D09.z' 
        --OR (S.DS1 LIKE 'd70%' AND SD.DS LIKE 'C%')
    --            OR ds_onk=1 )
            
      AND (
        (zs.RSLT IN (232,324,325,334,335,336,345,349,350,351,355,356,357,358) AND DN in (2)
        )
        OR zs.RSLT IN (357,358)
        )
     AND naz.ID IS null
      and dbo.f_GetAge(p.DR, DATE_Z_1) > = 18
    --  and zs.ID = 111480
      --and zs.ID = 111455
      --and s.sl_id = 'a96d1d74-a253-46d6-8708-0738792bae3b'



insert into D3_NAZ_OMS (D3_SLID, D3_SLGID, naz_r, naz_sp)

Select s.id, s.sl_id, 1, 49
-- ,dbo.f_GetAge(p.DR, DATE_Z_1)
--, naz.D3_SLID, naz.D3_SLGID
--,zs.ID


FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id --and sch.month=11
  and sch.id=2347
 inner join D3_ZSL_OMS zs on zs.D3_PID=p.id
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID  
 left join   D3_DSS_OMS sd on sd.D3_SLID=s.id and sd.DS_TYPE=2  
 left join   D3_NAZ_OMS naz ON naz.D3_SLID=s.id  
where   sch.SchetType like '%H%' --проверяем пока только случаи диспансеризации с онкодиагнозом или подозрением на онко
       AND s.p_cel25 LIKE '2.2' 
    --   AND (S.DS1 LIKE 'C%' 
        --OR S.DS1 between 'D00' AND 'D09.z' 
        --OR (S.DS1 LIKE 'd70%' AND SD.DS LIKE 'C%')
    --            OR ds_onk=1 )
            
      AND (
        (zs.RSLT IN (232,324,325,334,335,336,345,349,350,351,355,356,357,358) AND DN in (2)
        )
        OR zs.RSLT IN (357,358)
        )
     AND naz.ID IS null
      and dbo.f_GetAge(p.DR, DATE_Z_1) < 18
    --  and zs.ID = 111480
      --and zs.ID = 111455
      --and s.sl_id = 'a96d1d74-a253-46d6-8708-0738792bae3b'