DECLARE @p1 INT=2155
--SELECT t3.*, zsl.MEK_COMENT, zsl.ZSL_ID
--FROM 
--(
  SELECT t.lpu,t.ID, t.SUMV,''com,t2.real_kol,t.real_kol_spr




--ROUND((spr.kol_etal_n-t.real_kol)/(kol_etal_all+1),2)--,t.ID_List_Group,t.w,t.OS_SLUCH_REGION
--t.ID, t.SUMV,''com-- spr.kol_etal
FROM     
(
  
  
  SELECT zs.lpu,zs.ID,s.id slid,zs.SUMV,usl.ID_List_Group,p.w,zs.OS_SLUCH_REGION,COUNT(*) AS real_kol_spr
--,u.*
          FROM D3_ZSL_OMS zs  
            join D3_PACIENT_OMS p on p.id=zs.D3_PID  
            join [D3_SCHET_OMS] sch on sch.id=zs.D3_SCID and sch.id=@p1
            join D3_SL_OMS s on s.D3_ZSLID=zs.ID AND zs.OS_SLUCH_REGION IN (47)  
             JOIN D3_USL_OMS u ON u.D3_SLID=s.id AND (u.npl NOT IN (1,2) OR u.npl IS NULL)
             JOIN Kursk_Usl_124N usl ON usl.CODE_USL = u.CODE_USL 
                AND usl.OsSluchReg=zs.OS_SLUCH_REGION-- AND zs.id=18057261
                AND charindex(cast((YEAR(zs.DATE_Z_2)-YEAR(p.dr)) as nvarchar)+',',usl.Age)<>0 
                --AND usl.Obyaz=0
                AND p.w=usl.Pol
                        
  GROUP BY zs.lpu,zs.ID,zs.SUMV, s.id, zs.ZSL_ID,usl.ID_List_Group,p.w,zs.OS_SLUCH_REGION



) t
LEFT JOIN   (SELECT zs.ID,zs.zsl_id,COUNT(*) AS real_kol
--,u.*
          FROM D3_ZSL_OMS zs  
            join D3_PACIENT_OMS p on p.id=zs.D3_PID  
            join [D3_SCHET_OMS] sch on sch.id=zs.D3_SCID and sch.id=@p1 
            
            join D3_SL_OMS s on s.D3_ZSLID=zs.ID AND zs.OS_SLUCH_REGION IN (47)  
             JOIN D3_USL_OMS u ON u.D3_SLID=s.id AND (u.npl NOT IN (1,2) OR u.npl IS NULL)
             GROUP BY zs.ID,zs.zsl_id



) t2 ON t2.id=t.ID  
                      
WHERE  t2.real_kol-t.real_kol_spr>0
--) t3
--JOIN D3_ZSL_OMS zsl ON zsl.id=t3.id
--/(kol_etal_all+1)<>0-->0.15