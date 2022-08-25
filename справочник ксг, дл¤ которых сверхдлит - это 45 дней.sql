--справочник ксг, дл¤ которых сверхдлит - это 45 дней
declare @ksg_sv table (ksg nvarchar(20))

insert @ksg_sv values('st10.001')
insert @ksg_sv values('st10.002')
insert @ksg_sv values('st17.002')
insert @ksg_sv values('st17.003')
insert @ksg_sv values('st29.007')
insert @ksg_sv values('st32.006')
insert @ksg_sv values('st32.007')
insert @ksg_sv values('st33.007')


--вставл¤ю данные в таб кслп
INSERT INTO [D3_SL_KOEF_OMS] ([D3_KSGID]
      ,[D3_KSGGID]
      ,[IDSL]
      ,[Z_SL])

select t.id_ksg,t.KSG_ID,91,
--, t.ID--,
case when t.N_KSG not in (select * from @ksg_sv) then 1+round(0.25*(t.kd_z-30)/30,5)
                when t.N_KSG  in (select * from @ksg_sv) then 1+round(0.25*(t.kd_z-45)/45,5)
				end z_sl_must
from
(
select --distinct zsl.id 
	DISTINCT sch.id as schit, zsl.id as ID, zsl.sumv as SUMV, zsl.kd_z,ksgkpg.id as id_ksg, ksgkpg.KSG_ID, ksgkpg.N_KSG,ksgkpg.IT_SL--, dsko.idsl 
FROM [D3_SCHET_OMS] sch                  
	left join D3_PACIENT_OMS p on p.d3_scid=sch.id 
		left join D3_ZSL_OMS zsl on zsl.D3_PID=p.id and zsl.D3_SCID=sch.id
			left join D3_SL_OMS sl on sl.D3_ZSLID=zsl.ID
				left join D3_KSG_KPG_OMS KsgKpg on KsgKpg.D3_SLID=sl.id 
				LEFT JOIN D3_SL_KOEF_OMS AS dsko
				         ON dsko.D3_KSGID = KsgKpg.ID
WHERE sch.year=2020 and sch.code_mo=460026 and sch.month=12
     and ( ksgkpg.N_KSG not in (select * from @ksg_sv) and zsl.kd_z>30 or ksgkpg.N_KSG in (select * from @ksg_sv) and zsl.kd_z>45)
	  and not (ksgkpg.N_KSG  between 'st19.039' and 'st19.055' or ksgkpg.N_KSG  between 'ds19.001' and 'ds19.015')
	 and zsl.USL_OK=1
group by sch.id, zsl.id , zsl.sumv , zsl.kd_z,ksgkpg.N_KSG,ksgkpg.IT_SL,ksgkpg.id , ksgkpg.KSG_ID
having sum(case when dsko.idsl=91 then 1 else 0 end)=0
)t
--st10.001
--st10.002
--st17.002
--st17.003
--st29.007
--st32.006
--st32.007
--st33.007


--select 
--	DISTINCT sch.id, zsl.id as ID, zsl.sumv as SUMV, zsl.kd_z,ksgkpg.N_KSG,ksgkpg.IT_SL, dsko.idsl 
--FROM [D3_SCHET_OMS] sch                  
--	left join D3_PACIENT_OMS p on p.d3_scid=sch.id 
--		left join D3_ZSL_OMS zsl on zsl.D3_PID=p.id and zsl.D3_SCID=sch.id
--			left join D3_SL_OMS sl on sl.D3_ZSLID=zsl.ID
--				left join D3_KSG_KPG_OMS KsgKpg on KsgKpg.D3_SLID=sl.id 
--				LEFT JOIN D3_SL_KOEF_OMS AS dsko
--				         ON dsko.D3_KSGID = KsgKpg.ID
--WHERE sch.year=2020 and sch.code_mo=460010 and zsl.kd_z>30 and zsl.id in (select distinct zsl.id 
--	--DISTINCT sch.id, zsl.id as ID, zsl.sumv as SUMV, zsl.kd_z,ksgkpg.N_KSG,ksgkpg.IT_SL--, dsko.idsl 
--FROM [D3_SCHET_OMS] sch                  
--	left join D3_PACIENT_OMS p on p.d3_scid=sch.id 
--		left join D3_ZSL_OMS zsl on zsl.D3_PID=p.id and zsl.D3_SCID=sch.id
--			left join D3_SL_OMS sl on sl.D3_ZSLID=zsl.ID
--				left join D3_KSG_KPG_OMS KsgKpg on KsgKpg.D3_SLID=sl.id 
--				LEFT JOIN D3_SL_KOEF_OMS AS dsko
--				         ON dsko.D3_KSGID = KsgKpg.ID
--WHERE sch.year=2020 and sch.code_mo=460010 and zsl.kd_z>30 --and (idsl is null or idsl<>91)
--group by sch.id, zsl.id , zsl.sumv , zsl.kd_z,ksgkpg.N_KSG,ksgkpg.IT_SL
--having sum(case when dsko.idsl=91 then 1 else 0 end)=0)
--order by zsl.id
