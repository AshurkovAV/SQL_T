select distinct s.nhistory, 
               KsgKpg.n_ksg,
               v23.N_KSG
             
            ,ou.USL_TIP
            ,zs.DATE_Z_2
             
    FROM D3_ZSL_OMS zs  
            join D3_PACIENT_OMS p on p.id=zs.D3_PID  
            join [D3_SCHET_OMS] sch on sch.id=zs.D3_SCID and sch.CODE_MO=460061 and sch.YEAR=2022 
            join D3_SL_OMS s on s.D3_ZSLID=zs.ID
            left join D3_KSG_KPG_OMS KsgKpg on KsgKpg.D3_SLID = s.id --КСГ --KsgKpg.n_ksg
            left join D3_ONK_SL_OMS onk on onk.D3_SLID=s.id
            left join D3_ONK_USL_OMS ou on ou.D3_ONKSLID=onk.id
             left join v023 v23 ON v23.K_KSG=KsgKpg.N_KSG  and s.DATE_2 between v23.DATEBEG and isnull(v23.dateend,'20991231')	
             --  left  JOIN v024 ON v024.IDDKK=lek.CODE_SH   AND date_2 BETWEEN v024.DATEBEG and isnull(v024.DATEEND,'20991231')  
           
             
              join ( --находим ксг, которые определяются хт
                    SELECT distinct 
                        [NKSG]                      
  
                      FROM [SprKSGDecode]
                      where year(dbeg)=2022 
                    
                        and (dop_kr LIKE 'sh%' OR dop_kr LIKE 'gem%')
                                ) t on KsgKpg.n_ksg=t.NKSG
          
WHERE date_z_2>= '20220101'  AND ou.USL_TIP IS NULL
 AND sch.CODE_MO=460061
       