--им надо добавить itr4
--select --t.id_ksg,t.KSG_ID,91,
--t.*,dss.ds

--вставл€ю данные в таб кслп
--INSERT INTO [D3_CRIT_OMS] ([D3_KSGID]
--      ,[D3_KSGGID]
--      ,[CRIT])

SELECT id_ksg, KSG_ID, 'itr4'--, t.id
from
(
select --distinct zsl.id 
  DISTINCT sch.id as schit, zsl.id as ID, zsl.sumv as SUMV, zsl.kd_z,ksgkpg.id as id_ksg, ksgkpg.KSG_ID, ksgkpg.N_KSG,ksgkpg.IT_SL,sl.id as D3_SLID,ds1--, dsko.idsl 
FROM [D3_SCHET_OMS] sch                  
  left join D3_PACIENT_OMS p on p.d3_scid=sch.id 
    left join D3_ZSL_OMS zsl on zsl.D3_PID=p.id and zsl.D3_SCID=sch.id
      left join D3_SL_OMS sl on sl.D3_ZSLID=zsl.ID
        left join D3_KSG_KPG_OMS KsgKpg on KsgKpg.D3_SLID=sl.id 
    left join D3_CRIT_OMS cr on cr.D3_KSGID=KsgKpg.id
        LEFT JOIN D3_SL_KOEF_OMS AS dsko
                 ON dsko.D3_KSGID = KsgKpg.ID
WHERE sch.year=2021 and sch.code_mo=460026 and sch.month=2 --and sch.id=4204 
--AND zsl.pr_nov = 1
     --and ksgkpg.N_KSG  in (select * from @ksg_sv) 
   
   and zsl.USL_OK=1
group by sch.id, zsl.id , zsl.sumv , zsl.kd_z,ksgkpg.N_KSG,ksgkpg.IT_SL,ksgkpg.id , ksgkpg.KSG_ID,sl.id ,ds1
having sum(case when cr.CRIT like 'itr3' then 1 else 0 end)=0
)t
join D3_DSS_OMS dss on dss.D3_SLID=t.D3_SLID and dss.DS_TYPE=3
where (dss.DS in (SELECT [DS3]
  FROM [SprKSGDecode]
  where DOP_KR like 'itr4%') or dss.ds like 'J12%' or dss.ds like 'J13%' or dss.ds like 'J14%' or dss.ds like 'J15%' 
                     or dss.ds like 'J16%'
           or dss.ds like 'J17%'
           or dss.ds like 'J18%')
           and t.ds1 like 'U07%'
           AND t.N_KSG != 'st12.013.2'