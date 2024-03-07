--begin tran --commit tran
--select 
-- distinct sch.month,date_z_2,zsl.id as ID,SCH.CODE_MO,v23.NameWithID,cr.crit--, lekPr.id lek_id,code_sh,regnum,sl.nhistory
  update LekPr
  set lekPr.code_sh=cr.crit
  --006F.00.0652
  --into temp_update_lek_0321
FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
    inner join D3_ZSL_OMS zsl on zsl.D3_PID=p.id and zsl.D3_SCID=sch.id
      --SL--------------------------------------------------------------------------
      inner join D3_SL_OMS sl on sl.D3_ZSLID=zsl.ID
        ----OnkSl-----------------------------------------------------------------
        inner join D3_ONK_SL_OMS OnkSl on OnkSl.D3_SLID=sl.id 
          inner join D3_ONK_USL_OMS OnkUsl on OnkUsl.D3_ONKSLID=OnkSl.ID 
            inner join D3_LEK_PR_OMS LekPr on LekPr.D3_ONKUSLID=OnkUsl.id 
          left  JOIN D3_KSG_KPG_OMS AS  ksg ON ksg.D3_SLID=sl.ID 
 left JOIN v023 v23 ON v23.K_KSG=ksg.N_KSG AND year(v23.DATEBEG)>=2019 AND v23.DATEend IS NULL
 left join d3_crit_oms cr on cr.d3_ksgid=ksg.id
where 
  sch.year=2021 and sch.month=6 AND sch.CODE_MO='460061'
  -----------------------------  
  and 
    (
      dbo.f_GetAge(p.DR,sl.DATE_1)>=18
      and 
      ( 
      (
      sl.DS1 between 'C81' and 'C96.z' 
      or 
      sl.DS1 between 'D45' and 'D47.z' 
      )and OnkUsl.USL_TIP = 2
      )
      )
      and 
      not
      (lekpr.CODE_SH between 'gemop1' and 'gemop24'
      or 
      lekpr.CODE_SH='gem'
      )
	--  and crit is null