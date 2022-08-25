--Необходимость проведения антимикробной терапии инфекций
----вставляю данные в таб кслп
INSERT INTO [D3_SL_KOEF_OMS] ([D3_KSGID]
      ,[D3_KSGGID]
      ,[IDSL]
      ,[Z_SL])

SELECT KsgKpg.ID, KsgKpg.KSG_ID, 121, 1.4000


--select --distinct zsl.id 
--  DISTINCT zsl.ID, sch.id as schit, zsl.id as ID, zsl.sumv as SUMV, zsl.kd_z,ksgkpg.id as id_ksg, ksgkpg.KSG_ID, ksgkpg.N_KSG,ksgkpg.IT_SL--, dsko.idsl 
FROM [D3_SCHET_OMS] sch                  
  left join D3_PACIENT_OMS p on p.d3_scid=sch.id 
    left join D3_ZSL_OMS zsl on zsl.D3_PID=p.id and zsl.D3_SCID=sch.id
      left join D3_SL_OMS sl on sl.D3_ZSLID=zsl.ID
        left join D3_KSG_KPG_OMS KsgKpg on KsgKpg.D3_SLID=sl.id 
        LEFT JOIN D3_SL_KOEF_OMS AS dsko
                 ON dsko.D3_KSGID = KsgKpg.ID
         left join D3_DSS_OMS dss on dss.D3_SLID=sl.id 
WHERE sch.year=2020 and sch.code_mo=460026 and sch.month=11 AND zsl.PR_NOV != 1
     and (sl.DS1 IN ('U07.1', 'U07.2')
    or (dss.DS_TYPE = 3 AND dss.DS LIKE 'U0%')
  )
    
   and zsl.USL_OK=1
group by sch.id, zsl.id , zsl.sumv , zsl.kd_z,ksgkpg.N_KSG,ksgkpg.IT_SL,ksgkpg.id , ksgkpg.KSG_ID
having sum(case when dsko.idsl=121 then 1 else 0 end)=0