DECLARE @year INT=2020
 DECLARE @month1 INT=9
 DECLARE @month2 INT=9
 DECLARE @m_cod INT = 460026
 SELECT 
  month,
    CASE 
    WHEN [CEL]='1.1' THEN 'Õ≈Œ“ÀŒ∆ ¿ ¿œœ'
    WHEN  ( (CEL LIKE '1%' AND CEL NOT LIKE '1.1' AND CEL NOT LIKE '1.0')    
          OR   CEL IN ('2.1','2.5','2.6')  
          AND    (OS_SLUCH_REGION IS NULL)
           ) 
           OR
          OS_SLUCH_REGION in (29,35,48,23,12,18)  THEN 'œ–Œ‘»À¿ “» ¿ ¿œœ'
     WHEN  ( CEL  LIKE '1.0')    
         
             THEN 'œ–Œ‘»À¿ “» ¿ ¿œœ ‡ÁÓ‚˚Â'  
    WHEN  ( CEL  LIKE '2.2')    
         
             THEN 'œ–Œ‘»À¿ “» ¿ ‰ËÒÔ'       
    WHEN 
    (
      (CEL = '3.0' and OS_SLUCH_REGION is null)  
    or 
        OS_SLUCH_REGION in (6,21,30,31,32,33,34,36,39,40) 
  
    )
     then '«¿¡ŒÀ≈¬¿Õ»ﬂ ¿œœ'
    
    ELSE NULL 
    END [÷ÂÎ¸],
    COUNT(id) [ÍÓÎ-‚Ó ÓÔÎ‡˜ ÒÎ]
  
from
(
SELECT
    DISTINCT
    
      f3.nam_mok,
    sch.month,
    zs.id,                
    zs.usl_ok,  
      zs.OS_SLUCH_REGION,
    v6.[UMPNAME],  
    sl.P_CEL25 [CEL],          
    case when zs.idsp in (25,36) then 0 else  
         case when zs.sump IS NULL THEN sumv ELSE sump  END
                                      end sump,
    zs.idsp,
    CASE WHEN   [dbo].[f_GetAge] (P.DR,ZS.DATE_Z_1)  <=17 THEN 1 ELSE 0 END pr_det
    ------------
    --,sl.profil
    --,substring(sl.ds1,1,3) ds
    --,sch.month
    --,sch.code_mo            
  FROM [D3_SCHET_OMS] sch                
    inner join D3_PACIENT_OMS p on p.d3_scid=sch.id    
    inner join D3_ZSL_OMS zs on zs.D3_PID=p.id  --AND (zs.OS_SLUCH_REGION IS NULL OR zs.OS_SLUCH_REGION NOT IN (4,5,7,11,17,9,22,37,38,47,49))
    inner join D3_SL_OMS sl on sl.D3_ZSLID=zs.ID --AND profil not IN (85,86,87,88,89,90,140,171)
    LEFT JOIN [D3_USL_OMS] usl on usl.D3_SLID=sl.id 
    --LEFT JOIN medicalServices AS ms ON ms.code_usl=usl.CODE_USL
    left join [D3_SANK_OMS] sank                 
        on sank.[D3_ZSLID]=zs.id            
        and sank.s_tip=1  
    left join [V006] v6 on v6.[IDUMP]=zs.usl_ok  
    LEFT JOIN v002 ON v002.IDPR=sl.PROFIL  
    left join f003 f3 on f3.mcod=sch.code_mo          
  where 
    sch.[YEAR]=@year        
    AND year(p.DR) <  2002 
    and sch.month between @month1 and @month2              
    ----
    and zs.usl_ok in (3)
    --and sl.profil in (42)
    --and sl.ds1 between 'C81' and 'C96.z' --- ÓÌÍÓ„ÂÏ‡ÚÓÎÓ„Ëˇ
    -----------
    --and sank.[ID] is NULL
    AND sch.code_mo=@m_cod
    ) t
    group by month,
    CASE 
    WHEN [CEL]='1.1' THEN 'Õ≈Œ“ÀŒ∆ ¿ ¿œœ'
    WHEN  ( (CEL LIKE '1%' AND CEL NOT LIKE '1.1' AND CEL NOT LIKE '1.0')    
          OR   CEL IN ('2.1','2.5','2.6')  
          AND    (OS_SLUCH_REGION IS NULL)
           ) 
           OR
          OS_SLUCH_REGION in (29,35,48,23,12,18)  THEN 'œ–Œ‘»À¿ “» ¿ ¿œœ'
     WHEN  ( CEL  LIKE '1.0')    
         
             THEN 'œ–Œ‘»À¿ “» ¿ ¿œœ ‡ÁÓ‚˚Â'  
    WHEN  ( CEL  LIKE '2.2')    
         
             THEN 'œ–Œ‘»À¿ “» ¿ ‰ËÒÔ'       
    WHEN 
    (
      (CEL = '3.0' and OS_SLUCH_REGION is null)  
    or 
        OS_SLUCH_REGION in (6,21,30,31,32,33,34,36,39,40) 
  
    )
     then '«¿¡ŒÀ≈¬¿Õ»ﬂ ¿œœ'
    
    ELSE NULL 
    END