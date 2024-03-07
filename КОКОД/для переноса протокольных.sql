SELECT * 
UPDATE dzo SET dzo.EXP_COMENT = 'Spisok KT'
FROM D3_ZSL_OMS AS dzo
WHERE dzo.id IN (


SELECT distinct zslid

FROM (
SELECT sch.id, zs.ID zslid, p.fam,p.im,p.ot,p.dr  ,zs.DATE_Z_2 , zs.EXP_COMENT
FROM [D3_SCHET_OMS] sch                    
join D3_PACIENT_OMS p on p.d3_scid=sch.id   
      
join D3_ZSL_OMS zs on zs.D3_PID=p.id --AND zs.usl_ok IN (1) --AND p.smo=46006  
join D3_SL_OMS s on s.D3_ZSLID=zs.ID    

WHERE  
 sch.year=2020 
 --AND ds1 LIKE 'C50%' AND ds_onk=0 
 --AND YEAR(zs.DATE_Z_2)=2020 
 AND sch.[MONTH] = 11
 --AND sch.code_mo=460061 AND YEAR(zs.DATE_Z_2)=2020 AND month(zs.DATE_Z_2)=10  
GROUP BY sch.id, zs.ID, p.fam,p.im,p.ot,p.dr, zs.DATE_Z_2, zs.EXP_COMENT
) t1
JOIN 
(
SELECT * FROM kt	
) t2 ON t1.fam = t2.fam AND t1.im = t2.im AND t1.ot = t2.ot AND t1.dr = t2.dr

WHERE t1.DATE_Z_2 >= t2.date_ds
)