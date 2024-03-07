---------------------апрель-----------
--2312, 2313, 2314 апрель сдены уже без первичных
--2312, 2313, 2314, 2315 с мэками
--2312, 2313, 2314, 2315, 2211 с мэками и дешевые

---------------------март-----------
--2091,2086,2084  сдены уже без первичных
--2091,2086,2084,2085,2092 с мэками
--2091,2086,2084,2085,2092, 2010 с мэками и дешевые


Select --DISTINCT s.IDDOKT
--distinct s.IDDOKT,
--zs.id,
--sch.month,zs.usl_ok,pk.PODR,zs.USL_OK, otd.[naim],s.IDDOKT, s.NHISTORY,zs.SUMV

sch.year,zs.usl_ok,s.podr
,k.name,case when zs.vidpom=32 then 'вмп' else 'не вмп' end vidpom,count( distinct zs.ID) [количество],sum(s.sum_m) sumv,sum(zs.SUMp) sump , SUM(isnull(kd,kd_z))[койко-дни],sum(s.sum_m)/count( distinct zs.ID) [средн€€ стоимость]
FROM [D3_SCHET_OMS] sch                  
join D3_PACIENT_OMS p on p.d3_scid=sch.id 
    
join D3_ZSL_OMS zs on zs.D3_PID=p.id AND zs.usl_ok IN (1,2) --AND p.smo=46006
join D3_SL_OMS s on s.D3_ZSLID=zs.ID  
left JOIN D3_KSG_KPG_OMS AS ksg ON ksg.D3_SLID=s.id
LEFT JOIN d3_sank_oms sa ON sa.D3_ZSLID=zs.id AND sa.S_TIP=1
left join KOKOD_OTD k on k.kod_otd=s.podr
WHERE   --sch.id IN (1751,1747,1746)-- and zs.pr_nov=0-- AND  --AND zs.DATE_Z_2 BETWEEN '20200914' AND '20200920'  AND 

 sch.year=2023 AND sch.id IN (16161,16163,16164)
 --AND sch.id IN (Select 
	--					--sch.month,nschet,
	--					id

	--					FROM [D3_SCHET_OMS] sch  
	--					WHERE YEAR=2022 and (nschet LIKE '%дешевые1%' OR nschet LIKE '%сдан1%')
--AND sch.month=3
--and   sch.id in (4350,4351,4352)--AND MONTH(date_z_2)=6
-- and sch.id in (2312, 2313, 2314,2315,2211)-- AND YEAR(zs.DATE_Z_2)=2020 AND sch.month=12 and zs.pr_nov=0
 --AND month(zs.DATE_Z_2)=11-- AND sch.id IN (1082,1088,1087) and s.podr like '460061106004'
 --AND s.podr IN ('460061206014','460061106006','460061106017')
 --AND s.podr like '460061106013'
GROUP BY sch.year,zs.usl_ok,s.podr,case when zs.vidpom=32 then 'вмп' else 'не вмп' end ,k.name














