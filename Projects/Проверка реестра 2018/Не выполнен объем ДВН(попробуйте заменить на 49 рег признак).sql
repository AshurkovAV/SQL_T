DECLARE @p1 INT=2155
--Наташа 04062019
--НЕ выполнен объем 47
--Не выполнен объем ДВН(попробуйте заменить на 49 рег признак)
SELECT --t.lpu,
distinct t.ID, t.SUMV,''com
,t.real_kol,spr.kol_etal_n,kol_etal_all,(spr.kol_etal_n-t.real_kol)*1.0/(kol_etal_all+1)




--ROUND((spr.kol_etal_n-t.real_kol)/(kol_etal_all+1),2)--,t.ID_List_Group,t.w,t.OS_SLUCH_REGION
--t.ID, t.SUMV,''com-- spr.kol_etal
FROM     
(SELECT zs.lpu,zs.ID,s.id slid,zs.SUMV,usl.ID_List_Group,p.w,zs.OS_SLUCH_REGION,COUNT(*) AS real_kol
--,u.*
          FROM D3_ZSL_OMS zs  
            join D3_PACIENT_OMS p on p.id=zs.D3_PID  
            join [D3_SCHET_OMS] sch on sch.id=zs.D3_SCID and sch.id=@p1
            join D3_SL_OMS s on s.D3_ZSLID=zs.ID AND zs.OS_SLUCH_REGION IN (47)  
             JOIN D3_USL_OMS u ON u.D3_SLID=s.id AND (u.npl NOT IN (1,2) OR u.npl IS NULL)
            JOIN Kursk_Usl_124N usl ON usl.CODE_USL = u.CODE_USL 
                AND usl.OsSluchReg=zs.OS_SLUCH_REGION-- AND zs.id=18057261
                AND charindex(cast((YEAR(zs.DATE_Z_2)-YEAR(p.dr)) as nvarchar)+',',usl.Age)<>0 
                AND usl.Obyaz=0
                AND p.w=usl.Pol
           GROUP BY zs.lpu,zs.ID,zs.SUMV, s.id, zs.ZSL_ID,usl.ID_List_Group,p.w,zs.OS_SLUCH_REGION
) t
LEFT JOIN   (SELECT [ID_List_Group]
                ,[OsSluchReg]
                ,[Pol]
                ,[Age]
                ,count(*)-SUM([Obyaz]) kol_etal_n
                ,count(*) kol_etal_all
             FROM [Kursk_Usl_124N] usl
             GROUP BY [ID_List_Group],
                   [OsSluchReg]
                   ,[Pol]
                  ,[Age]) spr ON spr.[ID_List_Group]=t.[ID_List_Group]
                                 AND spr.pol=t.W  
                      
WHERE  (spr.kol_etal_n-t.real_kol)*1.0/(kol_etal_all+1)>=0.16