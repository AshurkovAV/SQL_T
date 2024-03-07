Select --DISTINCT s.IDDOKT
--distinct s.IDDOKT,
--zs.id,
--sch.month,zs.usl_ok,pk.PODR,zs.USL_OK, otd.[naim],s.IDDOKT, s.NHISTORY,zs.SUMV
sch.month,month(zs.DATE_Z_2) M_OK,zs.usl_ok,s.podr
,k.name,case when zs.vidpom=32 then 'вмп' else 'не вмп' end vidpom,count( distinct NHISTORY) [количество]--,sum(zs.SUMV) sumv,sum(zs.SUMp) sump , SUM(kd_z)[койко-дни],sum(zs.SUMV)/count( distinct zs.ID) [средняя стоимость]
FROM [D3_SCHET_OMS] sch                  
join D3_PACIENT_OMS p on p.d3_scid=sch.id 
    
join D3_ZSL_OMS zs on zs.D3_PID=p.id AND zs.usl_ok IN (1,2) --AND p.smo=46006
join D3_SL_OMS s on s.D3_ZSLID=zs.ID  
left JOIN D3_KSG_KPG_OMS AS ksg ON ksg.D3_SLID=s.id
LEFT JOIN d3_sank_oms sa ON sa.D3_ZSLID=zs.id AND sa.S_TIP=1
left join KOKOD_OTD k on k.kod_otd=s.podr
WHERE  --sch.id IN (795,796,797) AND
--AND zs.DATE_Z_2 BETWEEN '20200914' AND '20200922'
sch.year=2021 AND sch.code_mo=460061-- AND YEAR(zs.DATE_Z_2)=2021
 --AND month(zs.DATE_Z_2)=10 
 AND zs.vidpom=32
 --AND (zs.pr_nov=0 AND  YEAR(zs.DATE_Z_2)=2021 OR zs.pr_nov=1 AND  YEAR(zs.DATE_Z_2)=2020)
 and sch.id in  (Select 
						--sch.month,nschet
						id

						FROM [D3_SCHET_OMS] sch  
						WHERE YEAR=2021 AND nschet LIKE '%СДАН%')
 --AND s.podr IN ('460061206014','460061206006','460061206017')
GROUP BY sch.month,month(zs.DATE_Z_2),zs.usl_ok,s.podr,case when zs.vidpom=32 then 'вмп' else 'не вмп' end ,k.name
