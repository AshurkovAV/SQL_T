declare @p1 int = 342
select
	--zs.id as ID, zs.sumv as SUMV, ''com--'ѕри заполнении пол€ DOCNUM, пол€ DOCORG и DOCDATE должны присутствовать' com

	--p.*
p.fam, p.im, p.ot, cast(p.dr as date) dr, p.npolis
--into dogor
--update p set DOCORG = d.dOCORG ,  DOCDATE = d.DOCDt
FROM [D3_ZSL_OMS] zs
    join D3_PACIENT_OMS p on p.id=zs.D3_PID
	inner join [D3_SL_OMS] sl on zs.id=sl.[D3_ZSLID]
	--inner join adogor d on (p.FAM = d.FAM and p.IM=d.IM and p.OT = d.OT and p.DR = d.DR)
where zs.D3_SCID = @p1
	 and p.DOCNUM is not null
	 AND ( 
            p.DOCORG IS NULL or 
			p.DOCDATE IS null 
	      )
	

---group by p.fam, p.im, p.ot, p.dr, p.npolis
--zs.id, zs.sumv

--select * from adogor
--drop table dogor
--drop table adogor