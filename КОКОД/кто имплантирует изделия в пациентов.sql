SELECT distinct s.podr,
k.name,case when zs.vidpom=32 then 'тья' else 'эх тья' end vidpom,s.nhistory,ksg.n_ksg,v023.NameWithID, u.code_usl,v.s_code,
y.NameWithID , p.fam, p.im,p.ot
--,case when (s.ds1 between 'C00%'  then 1 end onk
  FROM D3_ZSL_OMS zs  
    join D3_PACIENT_OMS p on p.id=zs.D3_PID  
    join [D3_SCHET_OMS] sch on sch.id=zs.D3_SCID 
    and sch.year=2022 AND sch.month=2 
    join D3_SL_OMS s on s.D3_ZSLID=zs.ID 
    JOIN D3_USL_OMS u ON u.D3_SLID=s.id 
   join [V036] v on v.s_code=u.code_usl
   left JOIN D3_KSG_KPG_OMS AS ksg ON ksg.D3_SLID=s.id
   left join v023 on v023.K_KSG=ksg.n_ksg and s.date_2 between v023.DATEBEG and isnull(v023.DATEEND,'20211231')
   left join KOKOD_OTD k on k.kod_otd=s.podr
   		
left join Yamed_Spr_UslCode y on y.ID=u.CODE_USL
    where  --s.ds1 not like 'C%' 
            --and 
             zs.usl_ok in (1,2)
            -- AND s.podr LIKE '460061106013'
            -- AND LEN(u.CODE_USL)>10
ORDER BY s.podr 