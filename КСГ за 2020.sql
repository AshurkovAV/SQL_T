	
select NameWithID,count(zslid) [количество случаев],sum(sum_m) [сумма] ,sum(kd) [койко-дни]	
	
from	
	
(	
SELECT DISTINCT  sch.month,sch.id AS schit,sch.SchetType, zs.id zslid	
--,s.podr	
--,k.name	
--,p.fam,p.im,p.ot,p.dr, p.npolis,zs.DATE_Z_1, zs.DATE_Z_2, s.nhistory,s.ds1	
,ksg.n_ksg,case when v23.NameWithID is null then v023.N_KSG  else v23.NameWithID end NameWithID, s.sum_m , zs.usl_ok,s.kd		
FROM [D3_SCHET_OMS] sch  	
  inner join D3_ZSL_OMS zs on zs.[D3_SCID]=sch.id	
  inner join D3_PACIENT_OMS p on zs.D3_PID=p.id  	
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID	
 left JOIN D3_KSG_KPG_OMS AS  ksg ON ksg.D3_SLID=s.ID 	
left JOIN v023 v23 ON v23.K_KSG=ksg.N_KSG AND date_z_2 between v23.DATEBEG and isnull(v23.DATEend, '20201231') --year(v23.DATEBEG) between 2019 and 2020 AND (v23.DATEend like '20201231'	
 left JOIN [NSI].[dbo].[RV023] v023 ON v023.K_KSG=ksg.N_KSG AND date_z_2 between v023.DATEBEG and isnull(v023.DATEend, '20201231')
 LEFT JOIN v012 v12 ON v12.id=zs.ishod	
 LEFT JOIN v009 ON v009.IDRMP=zs.RSLT	
left join KOKOD_OTD k on k.kod_otd=s.podr	
	left JOIN D3_SANK_OMS AS dso ON dso.D3_ZSLID=zs.id AND s_tip=1
	
	
WHERE      sch.year=2020 and code_mo=460013 and zs.usl_ok in (2)	
and vidpom<>32 and dso.id is null	
--and v23.NameWithID is null	
) t	
group by NameWithID	
