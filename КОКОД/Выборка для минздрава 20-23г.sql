--отдельно стац, дневной и поликлинику не услуги  --- 1 лист эксель
Select 
distinct

 sch.YEAR[Год]
, zs.USL_OK
 , COUNT(distinct zs.id) kol_vo_sl
 ,COUNT(distinct p.npolis) kol_vo_pac
 
FROM [D3_SCHET_OMS] sch                  
 inner join D3_PACIENT_OMS p on p.d3_scid=sch.id
 inner join D3_ZSL_OMS zs on zs.D3_PID=p.id  
                                             AND sch.code_mo=460061 
                                             AND (sch.YEAR between 2020 AND 2022 or (sch.YEAR=2023 AND sch.month between 1 AND 9) )
                                             AND (zs.USL_OK IN (1,2) OR zs.USL_OK=3 AND zs.idsp IN (29,30))
 LEFT JOIN D3_SANK_OMS AS dso ON dso.D3_ZSLID=zs.id AND dso.s_tip=1
WHERE dso.id IS null                                            

GROUP BY  sch.YEAR
, zs.USL_OK




--отдельно поликлинику услуги --- 2 лист эксель
Select 
distinct

 sch.YEAR[Год]
, zs.USL_OK
,CASE WHEN u.CODE_USL BETWEEN 'R01.001.008' AND 'R01.001.036' THEN 'lab' ELSE 'usl_pril_4' END vid_usl
 , COUNT(distinct zs.id) kol_vo_sl
 ,COUNT(distinct p.npolis) kol_vo_pac
 
FROM [D3_SCHET_OMS] sch                  
 inner join D3_PACIENT_OMS p on p.d3_scid=sch.id
 inner join D3_ZSL_OMS zs on zs.D3_PID=p.id  
                                             AND sch.code_mo=460061 
                                             AND (sch.YEAR between 2020 AND 2022 or (sch.YEAR=2023 AND sch.month between 1 AND 9) )

join D3_SL_OMS s on s.D3_ZSLID=zs.ID 
JOIN D3_USL_OMS u ON u.D3_SLID=s.id AND u.CODE_USL LIKE 'R01%'
 LEFT JOIN D3_SANK_OMS AS dso ON dso.D3_ZSLID=zs.id AND dso.s_tip=1
WHERE dso.id IS null                                            

GROUP BY  sch.YEAR
, zs.USL_OK
,CASE WHEN u.CODE_USL BETWEEN 'R01.001.008' AND 'R01.001.036' THEN 'lab' ELSE 'usl_pril_4' END


--отдельно июль-сентябрь 2022 и 2023
--отдельно стац, дневной и поликлинику не услуги --- 3 лист эксель
Select 
distinct

 sch.YEAR[Год]
, zs.USL_OK
 , COUNT(distinct zs.id) kol_vo_sl
 ,COUNT(distinct p.npolis) kol_vo_pac
 
FROM [D3_SCHET_OMS] sch                  
 inner join D3_PACIENT_OMS p on p.d3_scid=sch.id
 inner join D3_ZSL_OMS zs on zs.D3_PID=p.id  
                                             AND sch.code_mo=460061 
                                             AND (sch.YEAR between 2022 AND 2023 and  sch.month between 7 AND 9 )
                                             AND (zs.USL_OK IN (1,2) OR zs.USL_OK=3 AND zs.idsp IN (29,30))
 LEFT JOIN D3_SANK_OMS AS dso ON dso.D3_ZSLID=zs.id AND dso.s_tip=1
WHERE dso.id IS null                                            

GROUP BY  sch.YEAR
, zs.USL_OK




--отдельно поликлинику услуги --- 4 лист эксель
Select 
distinct

 sch.YEAR[Год]
, zs.USL_OK
,CASE WHEN u.CODE_USL BETWEEN 'R01.001.008' AND 'R01.001.036' THEN 'lab' ELSE 'usl_pril_4' END vid_usl
 , COUNT(distinct zs.id) kol_vo_sl
 ,COUNT(distinct p.npolis) kol_vo_pac
 
FROM [D3_SCHET_OMS] sch                  
 inner join D3_PACIENT_OMS p on p.d3_scid=sch.id
 inner join D3_ZSL_OMS zs on zs.D3_PID=p.id  
                                             AND sch.code_mo=460061 
                                           AND (sch.YEAR between 2022 AND 2023 and  sch.month between 7 AND 9 )

join D3_SL_OMS s on s.D3_ZSLID=zs.ID 
JOIN D3_USL_OMS u ON u.D3_SLID=s.id AND u.CODE_USL LIKE 'R01%'
 LEFT JOIN D3_SANK_OMS AS dso ON dso.D3_ZSLID=zs.id AND dso.s_tip=1
WHERE dso.id IS null                                            

GROUP BY  sch.YEAR
, zs.USL_OK
,CASE WHEN u.CODE_USL BETWEEN 'R01.001.008' AND 'R01.001.036' THEN 'lab' ELSE 'usl_pril_4' END