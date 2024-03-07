--declare @p1 int =1
select 
  distinct zsl.id as ID, sl.nhistory,zsl.sumv as SUMV, '' com, ou.USL_TIP,lp.code_sh --VID_VME  не из справочника V019 при ВМП
FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
    inner join D3_ZSL_OMS zsl on zsl.D3_PID=p.id and zsl.D3_SCID=sch.id
      inner join D3_SL_OMS sl on sl.D3_ZSLID=zsl.ID
	   join D3_ONK_SL_OMS onk on onk.D3_SLID=sl.id
 join d3_onk_usl_oms ou on ou.D3_ONKSLID=onk.id
 left join d3_lek_pr_oms lp on lp.D3_ONKUSLID=ou.id
       -- inner join D3_USL_OMS usl on sl.id=usl.D3_SLID
        --------------------------------------------
       -- left join V019 v019 on usl.vid_vme=cast(v019.IDHM as varchar(5)) AND sl.DATE_2 BETWEEN v019.DATEBEG AND v019.DATEEND
where 
  sch.code_mo=460061 and sch.year=2020 and month=5
  and sl.METOD_HMP=348
  and zsl.vidpom=32
  order by zsl.id
