 --Наташечка,04102019,изменила возрат на конец законченнного случая
 DECLARE @p1 INT = 5522
 select
     DISTINCT
      zsl.id as ID, zsl.sumv as SUMV, '' com --Коэффициент 1.05 применяется для лиц старше 75 
   --   ,KsgKpg.IT_SL
   --  ,SlKoef.Z_SL
   -- ,dbo.f_GetAge(p.dr,date_z_1)
   --  ,sprksg.[KSGNUM]
  -- ,sch.CODE_MO
  --,zsl.MEK_COMENT
 FROM [D3_SCHET_OMS] sch                  
    join D3_PACIENT_OMS p on p.d3_scid=sch.id 
     join D3_ZSL_OMS zsl on zsl.D3_PID=p.id and zsl.D3_SCID=sch.id
        join D3_SL_OMS sl on sl.D3_ZSLID=zsl.ID
     --  JOIN D3_DSS_OMS AS ddo ON ddo.D3_SLID = sl.ID AND ddo.DS_TYPE = 2
         join D3_KSG_KPG_OMS KsgKpg on KsgKpg.D3_SLID=sl.id 
                join D3_SL_KOEF_OMS SlKoef on SlKoef.D3_KSGID=KsgKpg.ID
               left JOIN sprksg ON sprksg.id= KsgKpg.N_KSG AND year(sprksg.DBEG)=YEAR(zsl.date_z_2)
 --    left join v_SprKslpUnq NsiAct on
 --      SlKoef.IDSL=NsiAct.IDSL
 
 
  WHERE 
zsl.USL_OK = 1 AND  ksgkpg.N_KSG not LIKE '%st38.001%' AND dbo.f_GetAge(p.dr,date_z_2) >= 75 

and zsl.D3_SCID IN (5522)

--(4413
--,4416
--,5433
--,5437
--,5437
--,5441
--,5437
--,5489
--,5484
--,5495
--,5504
--,5512)