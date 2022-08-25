SELECT distinct sch.code_mo
,zs.ZSL_ID
, p.fam
,p.im
,p.ot
,p.DR
,dso.S_SUM
,(SELECT f002.NameWithID FROM f002 WHERE smocod = p.SMO)
,REPLACE(REPLACE(rtrim(ltrim(dso.S_COM)), char(13), ''), char(10), '')
,zs.DATE_Z_1, zs.DATE_Z_2
, zs.USL_OK
   
  FROM [ELMEDICINENEWFOND].[dbo].[D3_SCHET_OMS] sch                    
    inner join D3_PACIENT_OMS p on p.d3_scid=sch.id                  
    inner join D3_ZSL_OMS zs on zs.D3_PID=p.id     
    INNER JOIN d3_sl_oms sl ON sl.D3_ZSLID=zs.id             
   JOIN D3_SANK_OMS AS dso ON dso.D3_ZSLID=zs.id AND s_tip=1                  
  --INNER JOIN D3_KSG_KPG_OMS AS ksg ON ksg.D3_SLID=sl.ID
  --INNER JOIN D3_CRIT_OMS AS cr ON cr.D3_KSGID=ksg.ID
  INNER JOIN v006 ON v006.id=zs.USL_OK
  --LEFT JOIN sprksg k ON k.ID=ksg.N_KSG
  LEFT JOIN f002 ON f002.smocod=p.smo
  left join v002 v2 on v2.idpr=sl.profil
WHERE sch.CODE_MO='460060' AND sch.month BETWEEN 5 AND 11 AND sch.year=2021 --AND dso.S_OSN  LIKE '5.3.2.' 
--AND dso.S_COM IN ('Нет лицензии', 'Код МКБ10 не соответствует цели посещения Код МКБ10 только для профилактических случаев')