select distinct sch.year,--,sch.MONTH,zs.id,
sch.NSCHET,p.fam, p.im,p.ot,p.dr,p.NPOLIS
,s.NHISTORY,s.sum_m, SUMV,sank.id sank,sank.s_osn s_osn,v.UMPNAME usl_ok,             
CASE
          WHEN s.P_CEL25='1.1' THEN 'Õ≈Œ“ÀŒ∆ ¿ ¿œœ'   
          WHEN  ( (s.P_CEL25 LIKE '1%' AND s.P_CEL25 NOT LIKE '1.1')   
            OR  s.P_CEL25 IN ('2.1','2.5','2.6')
 AND    zs.OS_SLUCH_REGION IS NULL
            ) OR 
            zs.OS_SLUCH_REGION in (29,35,48,23,12,18)  THEN 'œ–Œ‘»À¿ “» ¿ ¿œœ' 
WHEN
          (s.P_CEL25 = '3.0' and OS_SLUCH_REGION is null)   
 OR
          zs.OS_SLUCH_REGION in (21,30,31,32,33,34,36,39,40)    
OR
          (s.P_CEL25='2.3' AND usl.CODE_USL like 'R03%')   
           then '«¿¡ŒÀ≈¬¿Õ»ﬂ ¿œœ'  
WHEN
          zs.OS_SLUCH_REGION in (6)    
           then '«¿¡ŒÀ≈¬¿Õ»ﬂ ¿œœ „ÂÏÓ‰Ë‡ÎËÁ'  
          when usl.code_usl like 'R01%' then ms.name   
          ELSE ''   
 END tip
FROM [D3_SCHET_OMS] sch             
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id           
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id           
  inner join d3_sl_oms s on s.D3_ZSLID=zs.id            
  LEFT JOIN [D3_USL_OMS] usl on usl.D3_SLID=s.id           
  left join medicalServices ms on ms.code_usl =usl.CODE_USL and s.DATE_2 between ms.dataBegin and isnull(ms.dataend,'20991231')           
  left join [D3_SANK_OMS] sank on sank.[D3_ZSLID]=zs.id and sank.s_tip=1          
  left join v006 v on v.IDUMP=zs.USL_OK    
      
  --left join [Yamed_Spr_SchetType] spr on spr.id=sch.SchetType           
  where sch.year=2023          
  and sch.code_mo='460061'  
  AND sch.month=9         
 AND sch.id IN (16168,16169,16170)
  ------------------------------------------           
  and sank.id is null           
  and p.doctype in (9,11,21)            
  AND ISNULL(zs.PR_NOV,0)=0           
