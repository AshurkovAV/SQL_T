SELECT DISTINCT  sch.month,sch.id AS schit,sch.[NSCHET], zs.id zslid
,s.podr
,k.name
,p.fam,p.im,p.ot,p.dr, p.npolis
,zs.DATE_Z_1, zs.DATE_Z_2, s.nhistory,s.ds1,ksg.n_ksg,v23.NameWithID
                                                     , zs.ishod,v12.IZNAME,v009.NameWithID v9, s.sum_m ,zs.sumv,kd_z

,case when s.sum_m=0 then 0 else 
	convert(numeric(12,2),ksg.BZTSZ) 
* ksg.KOEF_Z *

( (1-isnull(calc.lek,1)) + isnull(calc.lek,1)*
isnull(case when calc.up is not null OR zs.usl_ok=2 then 1 else 1.1 end,1)
* CASE WHEN zs.usl_ok=2 or calc.up is not null 
THEN 1.00  ELSE ISNULL(ksg.KOEF_Up,1.00) 
  END   
  * ksg.KOEF_D) 
+(convert(numeric(12,2),ksg.BZTSZ)* 1  * 0) end [now]


,case when s.sum_m=0 then 0 else 
	convert(numeric(12,2),ksg.BZTSZ) 
* ksg.KOEF_Z *

( (1-isnull(calc.lek,1)) + isnull(calc.lek,1)*
isnull(case when calc.up is not null OR zs.usl_ok=2 then 1 else 1.4 end,1)
* CASE WHEN zs.usl_ok=2 or calc.up is not null 
THEN 1.00  ELSE ISNULL(ksg.KOEF_Up,1.00) 
  END  
  * ksg.KOEF_D) 
+(convert(numeric(12,2),ksg.BZTSZ)* 1  * 0) end [must have]


-----


--convert(numeric(12,2),ksg.BZTSZ) * ksg.KOEF_Z *( (1-isnull(calc.lek,1)) + isnull(calc.lek,1)*isnull(case when zs.usl_ok=2 then 1 else 1.1 end,1)*ksg.koef_up
--* CASE WHEN zs.usl_ok=2 or calc.up is not null 
--THEN 1.00  ELSE ISNULL(ksg.KOEF_U,1.00) 
--  END  
--  * ksg.KOEF_D) ,
FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
 --AND sch.month=8 
 --AND sch.YEAR=2021  and  sch.month=9 and   sch.id in (3125)--,3121,3117)
 and sch.id in  (Select 
      --sch.month,nschet
      id

      FROM [D3_SCHET_OMS] sch  
      WHERE YEAR=2022 and   sch.id in (4351,4352,4037,4038,4203,4204)
)
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id   and zs.usl_ok in (1) --AND zs.vidpom<>32 --AND zs.id=20906231
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID
 JOIN D3_KSG_KPG_OMS AS  ksg ON ksg.D3_SLID=s.ID 
 left JOIN v023 v23 ON v23.K_KSG=ksg.N_KSG  AND s.DATE_2 between v23.DATEBEG AND  isnull(v23.DATEend ,'20221231') --AND year(v23.DATEBEG)>=2019
 LEFT JOIN v012 v12 ON v12.id=zs.ishod
 LEFT JOIN v009 ON v009.IDRMP=zs.RSLT
left join KOKOD_OTD k on k.kod_otd=s.podr
 left join [CalcKsg] calc on calc.K_KSG=v23.[K_KSG] AND YEAR(calc.[DATEBEG])=2022
where  zs.usl_ok in (1,2)







--) t
--LEFT JOIN 
--(
--Select 
--DISTINCT v23.K_KSG, v23.NameWithID

-- ,round (convert(numeric(12,2),bt.BZTSZ) * v23.KOEF_Z *( (1-isnull(calc.lek,1)) + isnull(calc.lek,1)*isnull(case when calc.up is not null then 1 else upr.upr end,1)* 
--CASE WHEN v23.K_KSG LIKE 'ds%' or calc.up is not null THEN 1.00  ELSE ISNULL(upr.upr,1.00) END  * 1) +convert(numeric(12,2),bt.BZTSZ)* 
--1  * 0,2) [now]




--FROM  v023 v23    --AND year(v23.DATEBEG)>=2019
-- left join [CalcKsg] calc on calc.K_KSG=v23.[K_KSG] AND YEAR(calc.[DATEBEG])=2022
--left join SprBZTSZ bt on bt.USL_OK=case when v23.k_ksg like 'st%' then 1 else 2 END AND YEAR(bt.[DBEG])=2022
--LEFT JOIN [CalcUprk] upr ON upr.[IDKSG]=v23.K_KSG
--WHERE   --sch.id IN (1751,1747,1746)-- and zs.pr_nov=0-- AND  --AND zs.DATE_Z_2 BETWEEN '20200914' AND '20200920'  AND 

--       YEAR(v23.DATEBEG)=2022 ) t1 ON t.n_ksg=t1.K_KSG
