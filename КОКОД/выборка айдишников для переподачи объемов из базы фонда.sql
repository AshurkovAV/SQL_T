
SELECT distinct  sch.SchetType, sch.month,

zs.zsl_ID
,f002.nam_smok

,zs.sumv
--,dso.S_OSN
--,dso.S_COM
, dso.S_DATE
INTO temp_08_09_20_V
  FROM [ELMEDICINENEWFOND].[dbo].[D3_SCHET_OMS] sch                    
    inner join D3_PACIENT_OMS p on p.d3_scid=sch.id                  
    inner join D3_ZSL_OMS zs on zs.D3_PID=p.id     
    --INNER JOIN d3_sl_oms sl ON sl.D3_ZSLID=zs.id             
   JOIN D3_SANK_OMS AS dso ON dso.D3_ZSLID=zs.id AND s_tip=1                  
  --INNER JOIN D3_KSG_KPG_OMS AS ksg ON ksg.D3_SLID=sl.ID
  --INNER JOIN D3_CRIT_OMS AS cr ON cr.D3_KSGID=ksg.ID
  INNER JOIN v006 ON v006.id=zs.USL_OK
  --LEFT JOIN sprksg k ON k.ID=ksg.N_KSG
  LEFT JOIN f002 ON f002.smocod=p.smo
WHERE sch.CODE_MO='460061' AND sch.month BETWEEN 7 AND 9 AND sch.year=2020 AND dso.S_OSN  LIKE '5.3.2.' --and sch.SchetType like 'H'
 AND MONTH(DSO.S_DATE)<>7
