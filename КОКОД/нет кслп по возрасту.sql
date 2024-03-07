
--Наташечка,04102019,изменила возрат на конец законченнного случая
 DECLARE @p1 INT = 393
 select
     DISTINCT
      zsl.id as ID, zsl.sumv as SUMV, '' com,[IDSL],sl.nhistory
      ,[Z_SL] --Коэффициент 1.05 применяется для лиц старше 75 
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
         join D3_KSG_KPG_OMS Ksg on Ksg.D3_SLID=sl.id 
               left join D3_SL_KOEF_OMS SlKoef on SlKoef.D3_KSGID=Ksg.ID and [IDSL]=41
               left JOIN sprksg ON sprksg.id= Ksg.N_KSG AND year(sprksg.DBEG)=YEAR(zsl.date_z_2)
 --    left join v_SprKslpUnq NsiAct on
 --      SlKoef.IDSL=NsiAct.IDSL
 
 
  WHERE 
 
  

  zsl.USL_OK = 1 
  AND  ksg.N_KSG not LIKE '%st38.001%' 
  AND dbo.f_GetAge(p.dr,date_z_2) >= 75 
  and SlKoef.id is null
  
 
and zsl.D3_SCID = @p1