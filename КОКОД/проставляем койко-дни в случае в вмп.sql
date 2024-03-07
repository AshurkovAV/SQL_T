UPDATE sl SET sl.KD=zs.kd_z
--select
--  zs.id as ID, zs.sumv as SUMV, ''com--'Не заполнена продолжительность лечения в случае для круглосут и днев стационаров KD' com
FROM [D3_ZSL_OMS] zs
  inner join [D3_SL_OMS] sl on zs.id=sl.[D3_ZSLID]
where zs.D3_SCID = 198--@p1
  and (zs.usl_ok in (1,2) and sl.KD is null)
group by zs.id, zs.sumv