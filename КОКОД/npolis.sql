SELECT p.enp, p.NPOLIS
--UPDATE zs SET EXP_COMENT = 'npolis'
FROM [D3_SCHET_OMS] sch                  
join D3_PACIENT_OMS p on p.d3_scid=sch.id 
    
join D3_ZSL_OMS zs on zs.D3_PID=p.id
WHERE sch.id = 16302 AND (p.NPOLIS = '' OR p.NPOLIS IS NULL)