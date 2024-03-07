--UPDATE s SET s.p_cel25='1.0', dn=NULL
--UPDATE zs SET rslt=301--, ishod=304
--SELECT  DISTINCT  sch.id AS schit,sch.SchetType, zs.id zslid,  rslt, ds_onk
--	,p.id pid

	--INTO temp_du_05_h
select distinct sch.id AS shit,sch.nschet,zs.ID AS zslid, s.id AS slid, s.NHISTORY, s.DATE_1, p.fam, p.im, ds1,
mos.DS_NAME, kp.fam+' ' +kp.im+' '+ kp.ot [врач], rslt, ishod

FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
  and sch.year=2022 and sch.month=6 and sch.id in (7055)
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id    and zs.usl_ok in (3) --AND zs.id=20906231
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID   
 
 left join D3_ONK_SL_OMS onk on onk.D3_SLID=s.id
 LEFT JOIN kokod_podr AS kp ON kp.IDDOCT=dbo.f_digit_only(iddokt) AND zs.usl_ok=kp.usl_ok
 LEFT JOIN M001_oplata_status AS mos ON mos.IDDS=s.ds1
 --WHERE  s.P_CEL25  LIKE '1.3' --AND dn IS null
WHERE s.P_CEL25  LIKE '1.0' AND rslt=314
--zs.id IN (7343491,7343510)