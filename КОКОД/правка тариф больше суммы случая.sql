declare @p1 int =2597
--update sl set tarif=0
select
zs.D3_SCID,pa.smo,sl.tarif,sl.profil,sl.nhistory, sl.sum_m,  zs.id as ID, zs.sumv as SUMV, ''com, pa.vpolis,pa.DOCNUM,pa.DOCORG,pa.DOCDATE,pa.fam,pa.im,pa.ot,pa.dr,sl.p_cel--'ѕри заполнении пол€ DOCNUM, пол€ DOCORG и DOCDATE должны присутствовать' com
FROM [D3_ZSL_OMS] zs
    join D3_PACIENT_OMS pa on pa.id=zs.D3_PID
  inner join [D3_SL_OMS] sl on zs.id=sl.[D3_ZSLID]
where zs.D3_SCID = @p1
   --and sl.tarif>sl.sum_m
   and zs.usl_ok=3
   and p_cel25 like '3.0'
   and os_sluch_region is null
--group by zs.id, zs.sumv