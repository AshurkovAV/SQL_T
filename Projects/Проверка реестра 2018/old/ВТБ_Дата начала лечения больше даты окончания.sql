DECLARE @D3_SCID INT = 2077
select 
zsl.ID,
     p.fam,
     p.IM,
     p.ot,
     CAST(p.DR AS DATE) dr,
     --p.NPOLIS,
     CAST(zsl.DATE_Z_1 AS DATE) DATE_Z_1,
     CAST(zsl.DATE_Z_2 AS DATE) DATE_Z_2,   
     'ƒата начала лечени€ больше даты окончани€' com
FROM D3_ZSL_OMS_OMS zsl
INNER join D3_D3_PACIENT_OMS_OMS p on zsl.D3_PID = p.ID
WHERE   zsl.ID IN (
Select zsl.ID
FROM D3_ZSL_OMS_OMS zsl
join D3_SL_OMS_OMS sl on sl.D3_ZSL_OMSid=zsl.id
where zsl.d3_SCID = @D3_SCID and (sl.DATE_1 > sl.DATE_2 or zsl.DATE_Z_1 > zsl.DATE_Z_2)
group by zsl.ID, zsl.SUMV)