--st23.004.1,st12.013.1-2
--справочник ксг, дл€ которых сверхдлит - это 45 дней

declare @ksg_sv table (ksg nvarchar(20))

insert @ksg_sv values('st23.004.1')
insert @ksg_sv values('st12.013.1')
insert @ksg_sv values('st12.013.2')



--вставл€ю данные в таб кслп
INSERT INTO [D3_SL_KOEF_OMS] ([D3_KSGID]
      ,[D3_KSGGID]
      ,[IDSL]
      ,[Z_SL])

SELECT KsgKpg.ID, KsgKpg.KSG_ID, 62, 1.5000


--select --distinct zsl.id 
--  DISTINCT sch.id as schit, zsl.id as ID, zsl.sumv as SUMV, zsl.kd_z,ksgkpg.id as id_ksg, ksgkpg.KSG_ID, ksgkpg.N_KSG,ksgkpg.IT_SL--, dsko.idsl 
FROM [D3_SCHET_OMS] sch                  
  left join D3_PACIENT_OMS p on p.d3_scid=sch.id 
    left join D3_ZSL_OMS zsl on zsl.D3_PID=p.id and zsl.D3_SCID=sch.id
      left join D3_SL_OMS sl on sl.D3_ZSLID=zsl.ID
        left join D3_KSG_KPG_OMS KsgKpg on KsgKpg.D3_SLID=sl.id 
        LEFT JOIN D3_SL_KOEF_OMS AS dsko
                 ON dsko.D3_KSGID = KsgKpg.ID
WHERE sch.year=2020 and sch.code_mo=460026 and sch.month=11 AND zsl.PR_NOV != 1
     and ksgkpg.N_KSG  in (select * from @ksg_sv) AND month(zsl.DATE_Z_2) <= 10
    
   and zsl.USL_OK=1
group by sch.id, zsl.id , zsl.sumv , zsl.kd_z,ksgkpg.N_KSG,ksgkpg.IT_SL,ksgkpg.id , ksgkpg.KSG_ID
having sum(case when dsko.idsl=62 then 1 else 0 end)=0