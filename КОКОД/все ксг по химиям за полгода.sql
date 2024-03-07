select UMPNAME,
name [отделение],
ds1,DS_NAME , count(nhistory) [количество случаев],  count(DISTINCT npolis) [количество пациент]
From
(
SELECT DISTINCT -- sch.month,sch.id AS schit,sch.SchetType,


v006.UMPNAME,
--,s.podr
k.name
--,p.fam,p.im,p.ot,p.dr, p.npolis,zs.DATE_Z_1, zs.DATE_Z_2, s.nhistory
,s.ds1,mos.DS_NAME
,ksg.n_ksg,v23.NameWithID,
 s.NHISTORY,p.npolis--, spr.DOP_KR--, s.sum_m , zs.usl_ok
FROM [D3_SCHET_OMS] sch  
  inner join D3_ZSL_OMS zs on zs.[D3_SCID]=sch.id
  inner join D3_PACIENT_OMS p on zs.D3_PID=p.id  
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID
  JOIN D3_KSG_KPG_OMS AS  ksg ON ksg.D3_SLID=s.ID 
  --left join D3_CRIT_OMS cr on cr.D3_KSGID=ksg.id
left JOIN v023 v23 ON v23.K_KSG=ksg.N_KSG AND date_z_2 between v23.DATEBEG and isnull(v23.DATEend, '20221231') --year(v23.DATEBEG) between 2019 and 2020 AND (v23.DATEend like '20201231'
 LEFT JOIN v012 v12 ON v12.id=zs.ishod
 LEFT JOIN v009 ON v009.IDRMP=zs.RSLT
 LEFT JOIN M001_oplata_status AS mos ON mos.IDDS=s.DS1
left join KOKOD_OTD k on k.kod_otd=s.podr
LEFT JOIN v006 ON v006.id=zs.USL_OK
where year(date_z_2)=2022 and sch.code_MO=460061 --AND MONTH(DATE_Z_2) BETWEEN 1 AND 12  --AND S.PODR IN ('460061206014','460061106006', '460061106017')
AND v23.NameWithID LIKE '%лекарств%'

) t 
group by 
UMPNAME,
name,
ds1,DS_NAME 
order by UMPNAME,
name,
ds1,DS_NAME 