SELECT t1.*,t2.*,DATEDIFF(dd,t1.date_2,t2.date_1)	
FROM(	
Select zsl_id,	
sch.month,zs.usl_ok,s.podr	
,k.name,nhistory,p.fam,p.im,p.ot,p.npolis,p.dr,zs.DATE_Z_1,zs.DATE_Z_2,s.DATE_1,s.DATE_2,ds1,v023.NameWithID,zs.sumv	
FROM [D3_SCHET_OMS] sch                  	
join D3_PACIENT_OMS p on p.d3_scid=sch.id 	
    	
join D3_ZSL_OMS zs on zs.D3_PID=p.id AND zs.usl_ok IN (1) --AND p.smo=46006	
join D3_SL_OMS s on s.D3_ZSLID=zs.ID  	
 JOIN D3_KSG_KPG_OMS AS ksg ON ksg.D3_SLID=s.id	
left join KOKOD_OTD k on k.kod_otd=s.podr	
left join v023 on v023.K_KSG=ksg.n_ksg and s.date_2 between v023.DATEBEG and isnull(v023.DATEEND,'20201231')	
WHERE   -- zs.DATE_Z_2 BETWEEN '20200901' AND '20200926'	
 sch.year=2020 AND sch.code_mo=460061 AND YEAR(zs.DATE_Z_2)=2020 AND month(zs.DATE_Z_2)=10) t1	
 JOIN 	
 (Select zsl_id,	
sch.month,zs.usl_ok,s.podr	
,k.name,nhistory,p.fam,p.im,p.ot,p.npolis,p.dr,zs.DATE_Z_1,zs.DATE_Z_2,s.DATE_1,s.DATE_2,ds1,v023.NameWithID,zs.sumv	
FROM [D3_SCHET_OMS] sch                  	
join D3_PACIENT_OMS p on p.d3_scid=sch.id 	
    	
join D3_ZSL_OMS zs on zs.D3_PID=p.id AND zs.usl_ok IN (1) --AND p.smo=46006	
join D3_SL_OMS s on s.D3_ZSLID=zs.ID  	
 JOIN D3_KSG_KPG_OMS AS ksg ON ksg.D3_SLID=s.id	
 left join v023 on v023.K_KSG=ksg.n_ksg and s.date_2 between v023.DATEBEG and isnull(v023.DATEEND,'20201231')	
left join KOKOD_OTD k on k.kod_otd=s.podr	
WHERE   -- zs.DATE_Z_2 BETWEEN '20200901' AND '20200926'	
 sch.year=2020 AND sch.code_mo=460061 AND YEAR(zs.DATE_Z_2)=2020 AND month(zs.DATE_Z_2)=10	
 ) t2 	
 on (t1.FAM=t2.fam and t1.im=t2.im and t1.ot=t2.ot and t1.dr=t2.dr or t1.npolis=t2.npolis) 	and t1.zsl_id<>t2.zsl_id AND t1.date_1<t2.DATE_1
WHERE DATEDIFF(dd,t1.date_2,t2.date_1)<=1	
order by t1.fam, t1.im,t1.ot	
