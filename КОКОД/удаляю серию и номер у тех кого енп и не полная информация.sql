update pa set pa.DOCtype=NULL,pa.DOCNUM=NULL,PA.DOCSER=NULL,pa.DOCORG=NULL,pa.DOCDATE=null
--select
--	zs.D3_SCID,zs.id as ID, zs.sumv as SUMV, ''com,pa.fam,pa.im,pa.ot,pa.dr, pa.DOCtype,pa.docser,pa.docnum,pa.docorg,pa.docdate--'ѕри заполнении пол€ DOCNUM, пол€ DOCORG и DOCDATE должны присутствовать' com
FROM [D3_ZSL_OMS] zs
    join D3_PACIENT_OMS pa on pa.id=zs.D3_PID
	inner join [D3_SL_OMS] sl on zs.id=sl.[D3_ZSLID]
where zs.D3_SCID in (318,319,306)
	 and pa.DOCNUM is not null
	 AND ( 
            pa.DOCORG IS NULL or pa.DOCDATE IS null 
	      )
	and vpolis=3
