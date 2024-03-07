
----insert usl
--SELECT [ID] --не нужно
--      ,[D3_SLID]
--      ,[D3_ZSLID]
--      ,[D3_SLGID]
--      ,[IDSERV] --?? что сюда ставить???
--      ,[LPU] --460061
--      ,[LPU_1]--301
--      ,[PODR]--NULL
--      ,[PROFIL] --67
--      ,[VID_VME]--A08.30.013
--      ,[DET]--0
--      ,[DATE_IN] --t.date_v
--      ,[DATE_OUT] --t.date_v
--      ,[P_OTK] --NULL
--      ,[DS] --t.ds
--      ,[CODE_USL]--A08.30.013
--      ,[KOL_USL]--1
--      ,[TARIF]--0.00
--      ,[SUMV_USL]--0.00
--      ,[PRVS]--48
--      ,[CODE_MD]--029-089-703 78
--      ,[NPL]--NULL
--      ,[COMENTU]--Патолого-анатомическое исследование биопсийного (операционного) материала с применением иммуногистохимических методов
--      ,[PRVS15]--NULL
--      ,[PRVS21]--NULL
--      ,[VERS_SPEC]--v021
--      ,[PRVS_VERS]--вычисляемое поле, не надо заполнять
--     /* ,[PRVD]
--      ,[DOP]
--      ,[PP]
--      ,[St_IDSERV]
--      ,[FORMUL]
--      ,[KOD_SP]*/

--SELECT DISTINCT  
--       s.id [D3_SLID]
--      ,zs.id [D3_ZSLID]
--      ,s.SL_ID [D3_SLGID]
--      ,1 [IDSERV] --?? что сюда ставить???
--      ,460061 [LPU] --460061
--      ,301 [LPU_1]--301
--      ,NULL [PODR]--NULL
--      ,67 [PROFIL] --67
--      ,'A08.30.013' [VID_VME]--A08.30.013
--      ,0 [DET]--0
--      ,t.date_v [DATE_IN] --t.date_v
--      ,t.date_v [DATE_OUT] --t.date_v
--      ,NULL [P_OTK] --NULL
--      ,t.ds [DS] --t.ds
--      ,'A08.30.013' [CODE_USL]--A08.30.013
--      ,1 [KOL_USL]--1
--      ,0.00 [TARIF]--0.00
--      ,0.00 [SUMV_USL]--0.00
--      ,48 [PRVS]--48
--      ,'029-089-703 78'[CODE_MD]--029-089-703 78
--      ,NULL [NPL]--NULL
--      ,'Патолого-анатомическое исследование биопсийного (операционного) материала с применением иммуногистохимических методов' [COMENTU]--Патолого-анатомическое исследование биопсийного (операционного) материала с применением иммуногистохимических методов
--     ,NULL [PRVS15]--NULL
--      ,NULL [PRVS21]--NULL
--      ,'v021'[VERS_SPEC]--v021
      
     -- INTO temp_immg_032020_vse
select sch.id AS schit,sch.SchetType, zs.id,
ZS.ZSL_ID,

usl.IDSERV,
ksg.SL_K, ksg.IT_SL,

p.fam,p.im,p.ot,p.dr, p.npolis,zs.DATE_Z_1, zs.DATE_Z_2, s.nhistory,s.ds1,ksg.n_ksg,zs.vidpom,v23.NameWithID, t.*
FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
  and sch.year=2020 and sch.month=3-- AND sch.id not IN (210)
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id   and zs.usl_ok in (1) AND zs.vidpom<>32 --AND zs.id=20906231
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID
 LEFT JOIN d3_usl_oms usl ON usl.D3_SLID=s.id
 LEFT JOIN D3_KSG_KPG_OMS AS  ksg ON ksg.D3_SLID=s.ID 
 
 left JOIN v023 v23 ON v23.K_KSG=ksg.N_KSG AND year(v23.DATEBEG)>=2019 AND v23.DATEend IS null
 LEFT JOIN  temp_gist_032020 t ON (t.polis=p.npolis OR (p.fam=t.fam AND p.im=p.im AND p.ot=t.ot AND p.dr=t.dr)) AND t.date_v>=zs.DATE_Z_1 AND t.date_v<=zs.DATE_Z_2
WHERE t.fam IS NOT NULL AND T.id<>2800 --AND ksg.SL_K=0
 
 
-- SELECT * FROM temp_gist_032020
 
