UPDATE s SET PROFIL_k=43
--prvs=41,
--PROFIL=60, det=0
--profil=29
--SELECT sch.id,zs.id,zsl_id,s.id, profil,prvs, s.PROFIL_K, date_1, zs.pr_nov, s.det



FROM [D3_SCHET_OMS] sch                  
join D3_PACIENT_OMS p on p.d3_scid=sch.id AND  sch.year=2021 
--AND sch.id in (3539)
join D3_ZSL_OMS zs on zs.D3_PID=p.id 
join D3_SL_OMS s on s.D3_ZSLID=zs.ID  
WHERE --sch.id=3149
zs.id=3745339 --AND s.id=2610844