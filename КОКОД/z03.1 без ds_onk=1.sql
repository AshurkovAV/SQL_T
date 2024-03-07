--  zs.oplata=0
--OS_SLUCH_REGION is null, там где OS_SLUCH_REGION=40
--enp
Select --DISTINCT
 sch.SchetType as [Тип счета]

  ,case when p.smo like '46%' then p.smo else '46' end as [Плательщик]

  , p.NPOLIS as [Полис]
  , p.enp
  
  , zs.DATE_Z_1 [дата начала]
  , zs.DATE_Z_2 [дата окончания]
   

  , zs.SUMV as [Стоимость оказанной мед. помощи],
  zs.oplata, sl.p_cel25, sl.tarif

 , sl.nhistory
  --, s.PODR as [Подразделение]
 , sl.DS1 as [Диагноз в соответствии с МКБ-10]
 , ds_onk, idsp
 , zsl_id, p.ID_PAC
FROM [D3_SCHET_OMS] sch                  
 inner join D3_PACIENT_OMS p on p.d3_scid=sch.id
 inner join D3_ZSL_OMS zs on zs.D3_PID=p.id AND sch.code_mo=460061 
 AND sch.month=9
 AND sch.YEAR=2022 
and   sch.id in (8625,8623)
--AND sch.ID IN (686, 688, 682)
join d3_sl_oms sl on sl.D3_ZSLID=zs.id
join V009 rz on rz.IDRMP=zs.RSLT
left join F011 doc on doc.Id=p.DOCTYPE
--order by schettype
WHERE-- OS_SLUCH_REGION=40
--sl.nhistory like '2022-992362'
ds1 like 'Z03.1' and (ds_onk<>1 or ds_onk is null)