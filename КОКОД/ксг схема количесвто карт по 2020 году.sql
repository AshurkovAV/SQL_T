select namewithid,[диагноз],dkkname,
 count(nhistory)
 from 
 (


SELECT DISTINCT -- sch.month,sch.id AS schit,sch.SchetType,
 --zs.id zslid, date_z_2
 --, 
 case when ds1 like 'C15%' then 'C15'
        when ds1 like 'C16%' then 'C16'
		when ds1 like 'C18%' then 'C18'
		when ds1 like 'C19%' then 'C19'
		when ds1 like 'C20%' then 'C20'
		when ds1 like 'C22%' then 'C22'
		when ds1 like 'C25%' then 'C25'
		when ds1 like 'C32%' then 'C32'
		when ds1 like 'C34%' then 'C34'
		when ds1 like 'C43%' then 'C43'
		when ds1 like 'C44%' then 'C44'
		when ds1 like 'C50%' then 'C50'
		when ds1 like 'C61%' then 'C61'
	    when ds1 like 'C64%' then 'C64'
		when ds1 like 'C67%' then 'C67'
		when ds1 like 'C73%' then 'C73'
		when  ds1 between 'C53' and 'C56.z' then 'C53-C56' 
		else 'потряшка' end [диагноз]


--,s.podr
--,k.name
--,p.fam,p.im,p.ot,p.dr, p.npolis,zs.DATE_Z_1, zs.DATE_Z_2, s.nhistory,s.ds1
,ksg.n_ksg,v23.NameWithID--, cr.CRIT
,v024.namewithid dkkname,
 s.nhistory--, spr.DOP_KR--, s.sum_m , zs.usl_ok
FROM [D3_SCHET_OMS] sch  
  inner join D3_ZSL_OMS zs on zs.[D3_SCID]=sch.id
  inner join D3_PACIENT_OMS p on zs.D3_PID=p.id  
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID
  JOIN D3_KSG_KPG_OMS AS  ksg ON ksg.D3_SLID=s.ID 
  left join D3_CRIT_OMS cr on cr.D3_KSGID=ksg.id
left JOIN v023 v23 ON v23.K_KSG=ksg.N_KSG AND date_z_2 between v23.DATEBEG and isnull(v23.DATEend, '20201231') --year(v23.DATEBEG) between 2019 and 2020 AND (v23.DATEend like '20201231'
 LEFT JOIN v012 v12 ON v12.id=zs.ishod
 LEFT JOIN v009 ON v009.IDRMP=zs.RSLT
left join KOKOD_OTD k on k.kod_otd=s.podr
LEFT JOIN v024 ON v024.IDDKK=cr.crit AND date_z_2 between v024.DATEBEG and v024.dateend
left join (select distinct dop_kr,nksg, dbeg, dend from SprKSGDecode where (year(dbeg)=2020 or year(dbeg)=2019) and (dop_kr like 'sh%')) spr on spr.nksg=ksg.N_KSG and date_z_2 between spr.DBEG and spr.DEND
and cr.CRIT=DOP_KR
WHERE      sch.year=2020 and code_mo=460061 and s.podr in  ('460061206014', '460061106006', '460061106017')
and vidpom<>32 and (isnull(zs.pr_nov,0)=0 or year(date_z_2)=2019) 
and (ds1 like 'C15%' 
or  ds1 like 'C16%' 
or  ds1 like 'C18%'
or  ds1 like 'C19%'
or  ds1 like 'C20%'
or  ds1 like 'C22%'
or  ds1 like 'C25%'
or  ds1 like 'C32%'
or  ds1 like 'C34%'
or  ds1 like 'C43%'
or  ds1 like 'C44%'
or  ds1 like 'C50%'
or  ds1 like 'C61%'
or  ds1 like 'C64%'
or  ds1 like 'C67%'
or  ds1 like 'C73%'
or  (ds1 between 'C53' and 'C56.z')
)
--and zs.id=32353755
and DOP_KR is not  null
--and year(date_z_2)=2019 --and month(zs.date_z_2)=1
) t
group by  namewithid,[диагноз],dkkname
order by  namewithid,[диагноз],dkkname