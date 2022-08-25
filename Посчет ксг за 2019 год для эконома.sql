SELECT --sch.month [месяц счета],
DISTINCT sch.code_mo,
(SELECT TOP 1 od.NameWithID FROM OtdelDb AS od WHERE od.OTDID_REGION_NOTEDIT = s.podr) podr,
 v006.UMPNAME [условие оказания],
 --ot.Name,
--AS t2_id
 --p.fam AS [фамилия],
 -- p.im [имя], 
 -- p.ot [отчество],
 --p.npolis [номер полиса],
   --CASE WHEN p.smo LIKE '46%' THEN f002.nam_smok ELSE 'иногородний' END [СМО],
   -- p.dr [дата рождения],
  --  zs.sumv [сумма выставленная],
  --zs.SUMP [сумма принятая],
  --s.NHISTORY [№ истории болезни],
  -- s.ds1 [нозология],
  -- mos.DS_NAME [диагноз],
  --  zs.DATE_Z_1 [дата начала],
  --  zs.DATE_Z_2 [дата окончания],
CASE WHEN YEAR(zs.DATE_Z_2)=2018 THEN s.N_KSG ELSE ksg.N_KSG END [номер КСГ],ISNULL(sk.NameWithID , sksg.NameWithID) [наименование КСГ],
 count(zs.ID) ,
--s.id,
sum(s.sum_m)



FROM [D3_SCHET_OMS] sch                  
inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
                  and SCH.Year=2019 
                  AND sch.month BETWEEN 1 AND 12
                  AND sch.code_mo in (460026,460013)
 inner join D3_ZSL_OMS zs on zs.D3_PID=p.id AND zs.usl_ok in(1,2) 
 
join D3_SL_OMS s on s.D3_ZSLID=zs.ID 
left JOIN f003 ON f003.mcod=sch.CODE_MO
LEFT JOIN D3_SANK_OMS AS sa ON sa.D3_ZSLID=zs.id AND sa.s_tip=1
--LEFT JOIN M001_oplata_status AS mos ON mos.IDDS=s.ds1
left JOIN D3_KSG_KPG_OMS AS ksg ON ksg.D3_SLID=s.id  
LEFT JOIN SprKsg AS sk ON sk.KSGNUM=s.N_KSG AND sk.STYPE=zs.USL_OK AND YEAR(zs.DATE_Z_2)=2018 AND YEAR(sk.DBEG)=2018
LEFT JOIN SprKsg AS sksg  ON sksg.id=ksg.N_KSG AND YEAR(zs.DATE_Z_2)=2019
--LEFT JOIN D3_SANK_OMS AS san ON san.D3_ZSLID=zs.id AND san.s_tip=2
--LEFT JOIN D3_SANK_OMS AS sank ON sank.D3_ZSLID=zs.id AND sank.s_tip=3
LEFT JOIN v006 ON v006.IDUMP=zs.USL_OK
--LEFT JOIN f002 ON f002.smocod=p.smo
--LEFT JOIN OtdelDb ot ON ot.Id = s.podr
WHERE sa.D3_ZSLID IS NULL AND zs.VIDPOM<>32 --AND sum_m<>sumvф
GROUP BY sch.code_mo,
s.podr,
 v006.UMPNAME, 

CASE WHEN YEAR(zs.DATE_Z_2)=2018 THEN s.N_KSG ELSE ksg.N_KSG END ,ISNULL(sk.NameWithID , sksg.NameWithID)