  DECLARE @p1 INT = 20336
--для зак случая UPDATE и INSERT
--select  s.profil, s.P_CEL25, isnull(p.npolis, p.ENP) npolis
UPDATE zs set OS_SLUCH_REGION = 59, idsp = 30 
FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id AND sch.id=@p1
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id  and zs.[D3_SCID]=sch.id    --and zs.usl_ok in (1,2) --AND zs.id=20906231
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID  AND s.P_CEL25= '1.3' 
 
 
INSERT INTO D3_USL_OMS (D3_SLID, D3_SLGID,   D3_ZSLID,      DATE_IN,   DATE_OUT, DS, VERS_SPEC,  CODE_MD,
DET, PRVS, PROFIL, CODE_USL,  VID_VME, KOL_USL, LPU)
 SELECT s.id, s.sl_id, zs.id, zs.DATE_Z_1, zs.DATE_Z_2, s.DS1, 'V021',  
 s.IDDOKT, s.DET, s.PRVS, s.PROFIL, dn.s_code, dn.s_code, 1, zs.LPU  
 FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id  and zs.[D3_SCID]=sch.id    --and zs.usl_ok in (1,2) --AND zs.id=20906231
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID  
 LEFT JOIN D3_USL_OMS AS duo ON duo.D3_SLID = s.ID
 --JOIN temp_disp_1_3 d ON s.id = d.slid  AND d.n_p_p = 1        
 left JOIN dn_v001_v021 dn ON dn.idspec = s.PRVS
 WHERE s.P_CEL25= '1.3'  AND sch.id=20336
 AND duo.ID IS NULL
 AND zs.EXP_COMENT LIKE '%Некорректно подан случай диспансерного наблюдения%'