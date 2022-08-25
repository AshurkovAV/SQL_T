select
cast(t.N_KSG as char(4)) grup,
t.N_KSG
,v23.N_KSG as name
,count(distinct zs.ID) zaksl
,sum(zs.sumv) summa
,cast(round(sum(sl.KD*1.0)/count(distinct zs.ID),2) as numeric(15,2))sred
, (SELECT v.NameWithID FROM V006 AS v WHERE v.id =  zs.USL_OK)
from
D3_SL_OMS sl 
join D3_ZSL_OMS zs on zs.ID=sl.D3_ZSLID 
join D3_PACIENT_OMS p on zs.D3_PID=p.id --and (@smo in ('','0') or (@smo='46' and (p.SMO is null or p.SMO not like '46%')) or (p.SMO = @smo and @smo like '460%')) 
join D3_KSG_KPG_OMS t on sl.ID = t.D3_SLID
JOIN D3_SCHET_OMS AS dso ON dso.ID = zs.D3_SCID
join v023 v23 on t.N_KSG=v23.K_KSG and zs.DATE_Z_2 between v23.DATEBEG and isnull(v23.dateend,'01.01.2099') and v23.datebeg>='01.01.2019'
 and zs.USL_OK=v23.IDUMP
where zs.usl_ok in (1,2) and zs.VIDPOM<>32 AND dso.CODE_MO = 460013 AND dso.[YEAR] = 2019
group by cast(t.N_KSG as char(4)),t.N_KSG,v23.N_KSG, zs.USL_OK
order by t.N_KSG