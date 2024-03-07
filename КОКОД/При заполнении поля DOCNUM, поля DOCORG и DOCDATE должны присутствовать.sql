declare @p1 int =495
update pa set pa.docnum=null,docser=null, pa.DOCORG=NULL, pa.DOCDATE=NULl,pa.doctype=null
--select
--  zs.id as ID, zs.sumv as SUMV, ''com, pa.vpolis,pa.DOCNUM,pa.DOCORG,pa.DOCDATE,pa.fam,pa.im,pa.ot,pa.dr--'ѕри заполнении пол€ DOCNUM, пол€ DOCORG и DOCDATE должны присутствовать' com
FROM [D3_ZSL_OMS] zs
    join D3_PACIENT_OMS pa on pa.id=zs.D3_PID
  inner join [D3_SL_OMS] sl on zs.id=sl.[D3_ZSLID]
where zs.D3_SCID = @p1
   and pa.DOCNUM is not null
   AND ( 
            pa.DOCORG IS NULL or pa.DOCDATE IS null 
        )
  
  and pa.vpolis=3 
--group by zs.id, zs.sumv