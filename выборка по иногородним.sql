select distinct code_mo                          
,ed_vol [ед объема],PRNAME  [профиль] , COUNT(ID) [кол_во зак сл]  , SUM(COUNT_sl) [кол_во случаев]                

,sum(case when idsp in (35,36) and pr_nov=0 then 0 else sumv end) [подано на сумму]
                        
from                           
(
	select distinct --sank.id sank,sank.S_OSN, 
zs.IDSP,zs.PR_NOV,
sch.code_mo,sch.MONTH,sch.SchetType,  zs.id,---s.NHISTORY,
zs.SUMV SUMV,sank.id sank,sank.s_osn s_osn,v.UMPNAME usl_ok , s.P_CEL25, zs.OS_SLUCH_REGION  ,v002.PRNAME  ,CASE WHEN s.P_CEL25 LIKE '3.0' AND OS_SLUCH_REGION IS NULL THEN 'обращения по заболеванию'   
       WHEN s.P_CEL25 LIKE '2.1' AND OS_SLUCH_REGION IS NULL THEN 'мед осмотр'     
       WHEN s.P_CEL25 LIKE '1.1' AND OS_SLUCH_REGION IS NULL THEN 'неотложка'   
       WHEN  OS_SLUCH_REGION IS not NULL  THEN   db.NameWithID
       ELSE 'посещения'  END ed_vol   , COUNT(s.id)     COUNT_sl               
  
FROM [D3_SCHET_OMS] sch                          
    inner join D3_PACIENT_OMS p on p.d3_scid=sch.id                      
    inner join D3_ZSL_OMS zs on zs.D3_PID=p.id                      
    inner join d3_sl_oms s on s.D3_ZSLID=zs.id                     
   
    left join OsobSluchDb db on db.Id=zs.OS_SLUCH_REGION
                       
    left join [D3_SANK_OMS] sank on sank.[D3_ZSLID]=zs.id and sank.s_tip=1                
    left join v006 v on v.IDUMP=zs.USL_OK    
    LEFT JOIN v002 ON v002. IDPR=s.profil    
                 
    where sch.year=2023 
    and sch.month BETWEEN 1 and 5                      
    and sch.code_mo='460031'--'460031'    
    and p.smo NOT LIKE '46%'
    AND zs.USL_OK IN (3)
    AND s.P_CEL25 not LIKE '2.2'
    AND sank.ID IS null
	and (zs.pr_nov = 0 or zs.pr_nov is null)
    ------------------------------------------                    
	GROUP BY zs.IDSP,zs.PR_NOV,zs.SUMV,
sch.code_mo,sch.MONTH,sch.SchetType,  zs.id,sank.id ,sank.s_osn ,v.UMPNAME  , s.P_CEL25, zs.OS_SLUCH_REGION  ,v002.PRNAME  ,CASE WHEN s.P_CEL25 LIKE '3.0' AND OS_SLUCH_REGION IS NULL THEN 'обращения по заболеванию'   
       WHEN s.P_CEL25 LIKE '2.1' AND OS_SLUCH_REGION IS NULL THEN 'мед осмотр'     
       WHEN s.P_CEL25 LIKE '1.1' AND OS_SLUCH_REGION IS NULL THEN 'неотложка'   
       WHEN  OS_SLUCH_REGION IS not NULL  THEN   db.NameWithID
       ELSE 'посещения'  end                     
                          
                          
    )t                      
    group by code_mo , ed_vol                        
,PRNAME  
ORDER BY code_mo , ed_vol                        
,PRNAME  