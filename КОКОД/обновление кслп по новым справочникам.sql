





--UPDATE sl_koef SET IDSL = 4171,Z_SL = 2.67
UPDATE zs SET sumv=s.SUM_M
--UPDATE s SET TARIF = round(zs.sumv-ksg.BZTSZ*1.2+ksg.BZTSZ*2.67,2), SUM_M = round(zs.sumv-ksg.BZTSZ*1.2+ksg.BZTSZ*2.67,2)
--SELECT DISTINCT --cast(sl_koef.id as VARCHAR) +','
--zs.usl_ok,s.nhistory,sk.NameWithID, sl_koef.Z_SL, s.sum_m, s.tarif,zs.SUMV, ksg.BZTSZ
--,cr.CRIT,round(zs.sumv-ksg.BZTSZ*1.2+ksg.BZTSZ*2.67,2)-- , ksg.IT_SL [суммарный кслп по случаю]
FROM [D3_SCHET_OMS] sch                  
 inner join D3_PACIENT_OMS p on p.d3_scid=sch.id
 inner join D3_ZSL_OMS zs on zs.D3_PID=p.id AND sch.code_mo=460061 
                                            AND sch.YEAR=2024  
  join D3_SL_OMS s on s.D3_ZSLID=zs.ID 
  JOIN D3_KSG_KPG_OMS ksg ON s.ID=ksg.D3_SLID
  JOIN d3_sl_koef_oms sl_koef ON sl_koef.D3_KSGID = ksg.ID 
 -- JOIN D3_SL_KSLP_OMS AS dsko ON dsko.SLID=s.id
  LEFT JOIN SprKSLP AS sk ON sk.IDSL=sl_koef.IDSL
 JOIN D3_CRIT_OMS cr ON cr.D3_KSGID=ksg.ID AND cr.CRIT LIKE 'supt05%'
WHERE  zs.USL_OK IN (2) AND sl_koef.IDSL=4171