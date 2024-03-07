Select --DISTINCT s.IDDOKT
--distinct s.IDDOKT,
--zs.id,
--sch.month,zs.usl_ok,pk.PODR,zs.USL_OK, otd.[naim],s.IDDOKT, s.NHISTORY,zs.SUMV

sch.month,zs.usl_ok,s.podr
,k.name,case when zs.vidpom=32 then 'вмп' else 'не вмп' end vidpom,count( distinct zs.ID) [количество],sum(s.sum_m) sumv,sum(zs.SUMp) sump , SUM(isnull(kd,kd_z))[койко-дни],sum(s.sum_m)/count( distinct zs.ID) [средняя стоимость]
FROM [D3_SCHET_OMS] sch                  
join D3_PACIENT_OMS p on p.d3_scid=sch.id 
    
join D3_ZSL_OMS zs on zs.D3_PID=p.id AND zs.usl_ok IN (1,2) --AND p.smo=46006
join D3_SL_OMS s on s.D3_ZSLID=zs.ID  
left JOIN D3_KSG_KPG_OMS AS ksg ON ksg.D3_SLID=s.id
LEFT JOIN d3_sank_oms sa ON sa.D3_ZSLID=zs.id AND sa.S_TIP=1
left join KOKOD_OTD k on k.kod_otd=s.podr
WHERE   --sch.id IN (1751,1747,1746)-- and zs.pr_nov=0-- AND  --AND zs.DATE_Z_2 BETWEEN '20200914' AND '20200920'  AND 

						 sch.year=2021 and sch.id in  (Select 
						--sch.month,nschet
						id

						FROM [D3_SCHET_OMS] sch  
						WHERE YEAR=2021 AND nschet LIKE 'дешевые'
)-- AND YEAR(zs.DATE_Z_2)=2020 AND sch.month=12 and zs.pr_nov=0
 
 --AND month(zs.DATE_Z_2)=11-- AND sch.id IN (1082,1088,1087) and s.podr like '460061106004'
 --AND s.podr IN ('460061206014','460061206006','460061206017')
GROUP BY sch.month,zs.usl_ok,s.podr,case when zs.vidpom=32 then 'вмп' else 'не вмп' end ,k.name














